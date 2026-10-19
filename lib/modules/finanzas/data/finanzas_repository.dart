import 'package:drift/drift.dart';

import '../../../core/db/database.dart';
import '../../../core/db/observar.dart';
import '../../../core/formato.dart';
import '../../../core/notifications/notification_service.dart';
import 'calculos.dart';

class FinanzasRepository {
  FinanzasRepository(this._db, this._notificaciones);

  final AppDatabase _db;
  final NotificationService _notificaciones;

  Stream<EstadoFinanzas> watchEstado() => observar(_db, [
    _db.cuentas,
    _db.tarjetas,
    _db.categorias,
    _db.gastosFijos,
    _db.metas,
    _db.deudas,
    _db.movimientos,
  ], () => estado(DateTime.now()));

  Future<EstadoFinanzas> estado(DateTime ahora) async {
    return calcularEstado(
      cuentas: await (_db.select(
        _db.cuentas,
      )..orderBy([(c) => OrderingTerm.asc(c.id)])).get(),
      tarjetas: await (_db.select(
        _db.tarjetas,
      )..orderBy([(t) => OrderingTerm.asc(t.id)])).get(),
      categorias: await (_db.select(
        _db.categorias,
      )..orderBy([(c) => OrderingTerm.asc(c.id)])).get(),
      fijos: await _db.select(_db.gastosFijos).get(),
      metas: await (_db.select(
        _db.metas,
      )..orderBy([(m) => OrderingTerm.asc(m.id)])).get(),
      deudas: await (_db.select(
        _db.deudas,
      )..orderBy([(d) => OrderingTerm.desc(d.fecha)])).get(),
      movimientos: await _db.select(_db.movimientos).get(),
      ahora: ahora,
    );
  }

  /// Movimientos de un mes, del más reciente al más antiguo.
  Stream<List<Movimiento>> watchMovimientosDelMes(DateTime mes) {
    final desde = DateTime(mes.year, mes.month);
    final hasta = DateTime(mes.year, mes.month + 1);
    return (_db.select(_db.movimientos)
          ..where(
            (m) =>
                m.fecha.isBiggerOrEqualValue(desde) &
                m.fecha.isSmallerThanValue(hasta),
          )
          ..orderBy([
            (m) => OrderingTerm.desc(m.fecha),
            (m) => OrderingTerm.desc(m.id),
          ]))
        .watch();
  }

  // ---------- Movimientos ----------

  Future<void> guardarMovimiento(MovimientosCompanion datos) async {
    if (datos.id.present) {
      await (_db.update(
        _db.movimientos,
      )..where((m) => m.id.equals(datos.id.value))).write(datos);
    } else {
      await _db.into(_db.movimientos).insert(datos);
    }
  }

  Future<void> eliminarMovimiento(int id) =>
      (_db.delete(_db.movimientos)..where((m) => m.id.equals(id))).go();

  Future<void> restaurarMovimiento(Movimiento m) =>
      _db.into(_db.movimientos).insert(m, mode: InsertMode.insertOrReplace);

  /// Registra el gasto fijo de este mes con su monto y cuenta por defecto.
  Future<void> registrarFijo(GastoFijo f, {DateTime? fecha}) {
    return _db
        .into(_db.movimientos)
        .insert(
          MovimientosCompanion.insert(
            tipo: TipoMovimiento.gasto,
            monto: f.monto,
            fecha: fecha ?? DateTime.now(),
            descripcion: Value(f.descripcion),
            categoriaId: Value(f.categoriaId),
            cuentaId: Value(f.cuentaId),
            fijoId: Value(f.id),
          ),
        );
  }

  // ---------- Cuentas, tarjetas, categorías ----------

  Future<void> guardarCuenta(CuentasCompanion datos) =>
      _guardar(_db.cuentas, datos, datos.id);
  Future<void> eliminarCuenta(int id) =>
      (_db.delete(_db.cuentas)..where((c) => c.id.equals(id))).go();

  Future<void> guardarTarjeta(TarjetasCompanion datos) async {
    final id = await _guardar(_db.tarjetas, datos, datos.id);
    await _programarTarjeta(id);
  }

  Future<void> eliminarTarjeta(int id) async {
    await _notificaciones.cancelar(IdsNotificacion.tarjetas + id);
    await (_db.delete(_db.tarjetas)..where((t) => t.id.equals(id))).go();
  }

  Future<void> fijarPresupuesto(int categoriaId, int monto) =>
      (_db.update(_db.categorias)..where((c) => c.id.equals(categoriaId)))
          .write(CategoriasCompanion(presupuesto: Value(monto)));

  Future<void> crearCategoria(String nombre, String tipo) => _db
      .into(_db.categorias)
      .insert(CategoriasCompanion.insert(nombre: nombre, tipo: tipo));

  // ---------- Gastos fijos ----------

  Future<void> guardarFijo(GastosFijosCompanion datos) async {
    final id = await _guardar(_db.gastosFijos, datos, datos.id);
    await _programarFijo(id);
  }

  Future<void> eliminarFijo(int id) async {
    await _notificaciones.cancelar(IdsNotificacion.gastosFijos + id);
    await (_db.delete(_db.gastosFijos)..where((f) => f.id.equals(id))).go();
  }

  // ---------- Metas y deudas ----------

  Future<void> guardarMeta(MetasCompanion datos) =>
      _guardar(_db.metas, datos, datos.id);
  Future<void> eliminarMeta(int id) =>
      (_db.delete(_db.metas)..where((m) => m.id.equals(id))).go();

  Future<void> aportarMeta(Meta meta, int monto) =>
      (_db.update(_db.metas)..where((m) => m.id.equals(meta.id))).write(
        MetasCompanion(
          ahorrado: Value((meta.ahorrado + monto).clamp(0, 1 << 62)),
        ),
      );

  Future<void> guardarDeuda(DeudasCompanion datos) =>
      _guardar(_db.deudas, datos, datos.id);
  Future<void> eliminarDeuda(int id) =>
      (_db.delete(_db.deudas)..where((d) => d.id.equals(id))).go();

  Future<void> abonarDeuda(Deuda deuda, int monto) =>
      (_db.update(_db.deudas)..where((d) => d.id.equals(deuda.id))).write(
        DeudasCompanion(
          abonado: Value((deuda.abonado + monto).clamp(0, deuda.monto)),
        ),
      );

  // ---------- Recordatorios ----------

  Future<void> programarTodos() async {
    for (final f in await _db.select(_db.gastosFijos).get()) {
      await _programarFijo(f.id);
    }
    for (final t in await _db.select(_db.tarjetas).get()) {
      await _programarTarjeta(t.id);
    }
  }

  Future<void> _programarFijo(int id) async {
    final notifId = IdsNotificacion.gastosFijos + id;
    await _notificaciones.cancelar(notifId);
    final f = await (_db.select(
      _db.gastosFijos,
    )..where((f) => f.id.equals(id))).getSingleOrNull();
    if (f == null || !f.activo || !f.recordar) return;
    await _notificaciones.programar(
      id: notifId,
      titulo: 'Hoy se paga: ${f.descripcion}',
      cuerpo: '${dinero(f.monto)}. Regístralo en Finanzas cuando lo pagues.',
      cuando: proximoDiaDelMes(f.dia, DateTime.now()),
    );
  }

  Future<void> _programarTarjeta(int id) async {
    final notifId = IdsNotificacion.tarjetas + id;
    await _notificaciones.cancelar(notifId);
    final t = await (_db.select(
      _db.tarjetas,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    if (t == null || t.archivada || t.diaPago == null) return;
    await _notificaciones.programar(
      id: notifId,
      titulo: 'Pago de tarjeta: ${t.nombre}',
      cuerpo: 'Hoy es la fecha límite de pago.',
      cuando: proximoDiaDelMes(t.diaPago!, DateTime.now()),
    );
  }

  /// Inserta o actualiza (si [id] está presente) y devuelve el id.
  Future<int> _guardar<T extends Table, D>(
    TableInfo<T, D> tabla,
    Insertable<D> datos,
    Value<int> id,
  ) async {
    final nuevo = await _db.into(tabla).insertOnConflictUpdate(datos);
    return id.present ? id.value : nuevo;
  }
}
