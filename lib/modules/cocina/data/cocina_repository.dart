import 'package:drift/drift.dart';

import '../../../core/db/database.dart';
import '../../../core/db/observar.dart';
import '../../../core/formato.dart';
import '../../../core/notifications/notification_service.dart';

/// Días de historial que se usan para estimar el consumo.
const ventanaConsumoDias = 30;

/// Días restantes por debajo de los cuales un producto "se está acabando".
const umbralPorAcabarseDias = 5;

class EstadoProducto {
  const EstadoProducto(this.producto, {this.consumoDiario, this.diasRestantes});

  final Producto producto;

  /// Promedio diario en la unidad del producto (null si no hay consumos).
  final double? consumoDiario;
  final double? diasRestantes;

  bool get agotado => producto.cantidad <= 0;

  bool get porAcabarse =>
      agotado ||
      (producto.stockMinimo > 0 && producto.cantidad <= producto.stockMinimo) ||
      (diasRestantes != null && diasRestantes! <= umbralPorAcabarseDias);

  /// Días hasta el vencimiento (negativo si ya venció).
  int? diasParaVencer(DateTime ahora) {
    final v = producto.vence;
    if (v == null) return null;
    return DateTime(
      v.year,
      v.month,
      v.day,
    ).difference(DateTime(ahora.year, ahora.month, ahora.day)).inDays;
  }
}

/// Consumo diario promedio y días que alcanza la [cantidad] actual.
///
/// Se promedia lo consumido en los últimos [ventanaConsumoDias] días entre
/// los días transcurridos desde el primer movimiento del producto en esa
/// ventana (mínimo 1 día), para no subestimar productos recién agregados.
({double? consumoDiario, double? diasRestantes}) estimarDuracion({
  required double cantidad,
  required List<MovCocina> movimientos,
  required DateTime ahora,
}) {
  final desde = ahora.subtract(const Duration(days: ventanaConsumoDias));
  final recientes = movimientos.where((m) => m.fecha.isAfter(desde)).toList();
  final consumido = recientes
      .where((m) => m.tipo == TipoMovCocina.consumo)
      .fold<double>(0, (s, m) => s + m.cantidad);
  if (consumido <= 0) return (consumoDiario: null, diasRestantes: null);

  final primero = recientes
      .map((m) => m.fecha)
      .reduce((a, b) => a.isBefore(b) ? a : b);
  final dias = ahora.difference(primero).inHours / 24;
  final consumoDiario = consumido / (dias < 1 ? 1 : dias);
  return (
    consumoDiario: consumoDiario,
    diasRestantes: cantidad / consumoDiario,
  );
}

/// Al marcar como comprado un ítem de mercado ligado a un producto, suma su
/// compra habitual al inventario (o la resta si se desmarca).
Future<void> sincronizarCompraDeMercado(
  AppDatabase db,
  int productoId, {
  required bool comprado,
}) async {
  final p = await (db.select(
    db.productos,
  )..where((p) => p.id.equals(productoId))).getSingleOrNull();
  if (p == null) return;
  final cantidad = comprado ? p.compraHabitual : -p.compraHabitual;
  await (db.update(db.productos)..where((x) => x.id.equals(p.id))).write(
    ProductosCompanion(
      cantidad: Value((p.cantidad + cantidad).clamp(0, double.infinity)),
    ),
  );
  if (comprado) {
    await db
        .into(db.movimientosCocina)
        .insert(
          MovimientosCocinaCompanion.insert(
            productoId: p.id,
            tipo: TipoMovCocina.compra,
            cantidad: p.compraHabitual,
            fecha: DateTime.now(),
          ),
        );
  }
}

class CocinaRepository {
  CocinaRepository(this._db, this._notificaciones);

  final AppDatabase _db;
  final NotificationService _notificaciones;

  Stream<List<EstadoProducto>> watchInventario() => observar(_db, [
    _db.productos,
    _db.movimientosCocina,
  ], () => inventario(DateTime.now()));

  Future<List<EstadoProducto>> inventario(DateTime ahora) async {
    final productos = await (_db.select(
      _db.productos,
    )..orderBy([(p) => OrderingTerm.asc(p.nombre)])).get();
    final desde = ahora.subtract(const Duration(days: ventanaConsumoDias));
    final movimientos = await (_db.select(
      _db.movimientosCocina,
    )..where((m) => m.fecha.isBiggerThanValue(desde))).get();
    final porProducto = <int, List<MovCocina>>{};
    for (final m in movimientos) {
      porProducto.putIfAbsent(m.productoId, () => []).add(m);
    }
    return [
      for (final p in productos)
        () {
          final e = estimarDuracion(
            cantidad: p.cantidad,
            movimientos: porProducto[p.id] ?? [],
            ahora: ahora,
          );
          return EstadoProducto(
            p,
            consumoDiario: e.consumoDiario,
            diasRestantes: e.diasRestantes,
          );
        }(),
    ];
  }

  Stream<List<MovCocina>> watchHistorial(int productoId) =>
      (_db.select(_db.movimientosCocina)
            ..where((m) => m.productoId.equals(productoId))
            ..orderBy([(m) => OrderingTerm.desc(m.fecha)])
            ..limit(30))
          .watch();

  Future<int> guardarProducto(ProductosCompanion datos) async {
    final nuevo = !datos.id.present;
    final id = await _db.into(_db.productos).insertOnConflictUpdate(datos);
    final productoId = nuevo ? id : datos.id.value;
    final cantidad = datos.cantidad.present ? datos.cantidad.value : 0.0;
    if (nuevo && cantidad > 0) {
      await _registrar(productoId, TipoMovCocina.compra, cantidad);
    }
    await _programarVencimiento(productoId);
    return productoId;
  }

  Future<void> eliminarProducto(int id) async {
    await _notificaciones.cancelar(IdsNotificacion.vencimientosCocina + id);
    await (_db.delete(_db.productos)..where((p) => p.id.equals(id))).go();
  }

  /// Registra que se usó [cantidad] del producto.
  Future<void> consumir(
    Producto p,
    double cantidad, {
    String tipo = TipoMovCocina.consumo,
  }) async {
    final usado = cantidad > p.cantidad ? p.cantidad : cantidad;
    if (usado <= 0) return;
    await (_db.update(_db.productos)..where((x) => x.id.equals(p.id))).write(
      ProductosCompanion(cantidad: Value(p.cantidad - usado)),
    );
    await _registrar(p.id, tipo, usado);
  }

  /// Registra una compra; [vence] reemplaza la fecha de vencimiento.
  Future<void> comprar(Producto p, double cantidad, {DateTime? vence}) async {
    if (cantidad <= 0) return;
    await (_db.update(_db.productos)..where((x) => x.id.equals(p.id))).write(
      ProductosCompanion(
        cantidad: Value(p.cantidad + cantidad),
        vence: vence == null ? const Value.absent() : Value(vence),
      ),
    );
    await _registrar(p.id, TipoMovCocina.compra, cantidad);
    if (vence != null) await _programarVencimiento(p.id);
  }

  Future<void> _registrar(int productoId, String tipo, double cantidad) => _db
      .into(_db.movimientosCocina)
      .insert(
        MovimientosCocinaCompanion.insert(
          productoId: productoId,
          tipo: tipo,
          cantidad: cantidad,
          fecha: DateTime.now(),
        ),
      );

  // ---------- Lista de mercado ----------

  Future<Lista?> _listaMercado() =>
      (_db.select(_db.listas)
            ..where((l) => l.tipo.equals(TipoLista.mercado))
            ..orderBy([
              (l) => OrderingTerm.asc(l.orden),
              (l) => OrderingTerm.asc(l.id),
            ])
            ..limit(1))
          .getSingleOrNull();

  /// Agrega los productos a la primera lista de mercado (sin duplicar los que
  /// ya están pendientes). Devuelve cuántos se agregaron, o null si no hay
  /// lista de mercado.
  Future<int?> agregarAMercado(List<Producto> productos) async {
    final lista = await _listaMercado();
    if (lista == null) return null;
    final pendientes =
        await (_db.select(_db.tareas)..where(
              (t) =>
                  t.listaId.equals(lista.id) &
                  t.completadaEn.isNull() &
                  t.productoId.isNotNull(),
            ))
            .get();
    final yaEstan = {for (final t in pendientes) t.productoId};
    var agregados = 0;
    for (final p in productos) {
      if (yaEstan.contains(p.id)) continue;
      await _db
          .into(_db.tareas)
          .insert(
            TareasCompanion.insert(
              listaId: lista.id,
              titulo: p.nombre,
              cantidad: Value('${numero(p.compraHabitual)} ${p.unidad}'),
              productoId: Value(p.id),
            ),
          );
      agregados++;
    }
    return agregados;
  }

  // ---------- Recordatorios ----------

  Future<void> programarTodos() async {
    final productos = await (_db.select(
      _db.productos,
    )..where((p) => p.vence.isNotNull())).get();
    for (final p in productos) {
      await _programarVencimiento(p.id);
    }
  }

  Future<void> _programarVencimiento(int id) async {
    final notifId = IdsNotificacion.vencimientosCocina + id;
    await _notificaciones.cancelar(notifId);
    final p = await (_db.select(
      _db.productos,
    )..where((p) => p.id.equals(id))).getSingleOrNull();
    if (p?.vence == null || p!.cantidad <= 0) return;
    final v = p.vence!;
    await _notificaciones.programar(
      id: notifId,
      titulo: '${p.nombre} vence mañana',
      cuerpo:
          'Te quedan ${numero(p.cantidad)} ${p.unidad}. ¡Úsalo antes de que se dañe!',
      cuando: DateTime(v.year, v.month, v.day - 1, 9),
    );
  }
}
