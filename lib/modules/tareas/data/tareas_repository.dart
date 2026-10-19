import 'package:drift/drift.dart';

import '../../../core/db/database.dart';
import '../../../core/notifications/notification_service.dart';
import '../../cocina/data/cocina_repository.dart';
import 'recurrencia.dart';

class ListaConPendientes {
  const ListaConPendientes(this.lista, this.pendientes);
  final Lista lista;
  final int pendientes;
}

class TareaConLista {
  const TareaConLista(this.tarea, this.lista);
  final Tarea tarea;
  final Lista lista;
}

class TareasRepository {
  TareasRepository(this._db, this._notificaciones);

  final AppDatabase _db;
  final NotificationService _notificaciones;

  // ---------- Listas ----------

  Stream<List<ListaConPendientes>> watchListas() {
    final pendientes = _db.tareas.id.count(
      filter: _db.tareas.completadaEn.isNull(),
    );
    final query =
        _db.select(_db.listas).join([
            leftOuterJoin(
              _db.tareas,
              _db.tareas.listaId.equalsExp(_db.listas.id),
            ),
          ])
          ..addColumns([pendientes])
          ..groupBy([_db.listas.id])
          ..orderBy([
            OrderingTerm.asc(_db.listas.orden),
            OrderingTerm.asc(_db.listas.id),
          ]);
    return query.watch().map(
      (rows) => [
        for (final r in rows)
          ListaConPendientes(r.readTable(_db.listas), r.read(pendientes) ?? 0),
      ],
    );
  }

  Stream<Lista> watchLista(int id) =>
      (_db.select(_db.listas)..where((l) => l.id.equals(id))).watchSingle();

  Future<int> crearLista(String nombre, {required String tipo}) async {
    final orden = await _db.listas.count().getSingle();
    return _db
        .into(_db.listas)
        .insert(
          ListasCompanion.insert(
            nombre: nombre.trim(),
            tipo: Value(tipo),
            icono: Value(tipo == TipoLista.mercado ? 'mercado' : 'lista'),
            color: Value(tipo == TipoLista.mercado ? 0xFF2E7D32 : 0xFF3F51B5),
            orden: Value(orden),
          ),
        );
  }

  Future<void> renombrarLista(int id, String nombre) =>
      (_db.update(_db.listas)..where((l) => l.id.equals(id))).write(
        ListasCompanion(nombre: Value(nombre.trim())),
      );

  Future<void> eliminarLista(int id) async {
    final tareas = await (_db.select(
      _db.tareas,
    )..where((t) => t.listaId.equals(id))).get();
    for (final t in tareas) {
      await _notificaciones.cancelar(t.id);
    }
    await (_db.delete(_db.listas)..where((l) => l.id.equals(id))).go();
  }

  // ---------- Tareas ----------

  Stream<List<Tarea>> watchTareasDeLista(int listaId) {
    return (_db.select(_db.tareas)
          ..where((t) => t.listaId.equals(listaId))
          ..orderBy([
            (t) => OrderingTerm(expression: t.completadaEn.isNotNull()),
            (t) => OrderingTerm.desc(t.prioridad),
            (t) => OrderingTerm(expression: t.vence, nulls: NullsOrder.last),
            (t) => OrderingTerm.desc(t.completadaEn),
            (t) => OrderingTerm.asc(t.id),
          ]))
        .watch();
  }

  /// Tareas pendientes que vencen hoy o están atrasadas.
  Stream<List<TareaConLista>> watchHoy(DateTime hoy) {
    final manana = DateTime(hoy.year, hoy.month, hoy.day + 1);
    final query =
        _db.select(_db.tareas).join([
            innerJoin(_db.listas, _db.listas.id.equalsExp(_db.tareas.listaId)),
          ])
          ..where(
            _db.tareas.completadaEn.isNull() &
                _db.tareas.vence.isSmallerThanValue(manana),
          )
          ..orderBy([
            OrderingTerm.asc(_db.tareas.vence),
            OrderingTerm.desc(_db.tareas.prioridad),
          ]);
    return query.watch().map(
      (rows) => [
        for (final r in rows)
          TareaConLista(r.readTable(_db.tareas), r.readTable(_db.listas)),
      ],
    );
  }

  Future<int> guardarTarea(TareasCompanion datos) async {
    final int id;
    if (datos.id.present) {
      id = datos.id.value;
      await (_db.update(
        _db.tareas,
      )..where((t) => t.id.equals(id))).write(datos);
    } else {
      id = await _db.into(_db.tareas).insert(datos);
    }
    await _sincronizarRecordatorio(id);
    return id;
  }

  /// Marca o desmarca una tarea. Si es repetitiva, en vez de completarla se
  /// mueve a su siguiente vencimiento.
  Future<void> alternarCompletada(Tarea tarea, {DateTime? ahora}) async {
    ahora ??= DateTime.now();
    if (tarea.completadaEn != null) {
      await (_db.update(_db.tareas)..where((t) => t.id.equals(tarea.id))).write(
        const TareasCompanion(completadaEn: Value(null)),
      );
    } else {
      final siguiente = tarea.vence == null
          ? null
          : siguienteVencimiento(
              tarea.vence!,
              tarea.repeticion,
              conHora: tarea.conHora,
              ahora: ahora,
            );
      await (_db.update(_db.tareas)..where((t) => t.id.equals(tarea.id))).write(
        siguiente != null
            ? TareasCompanion(vence: Value(siguiente))
            : TareasCompanion(completadaEn: Value(ahora)),
      );
    }
    if (tarea.productoId != null) {
      await sincronizarCompraDeMercado(
        _db,
        tarea.productoId!,
        comprado: tarea.completadaEn == null,
      );
    }
    await _sincronizarRecordatorio(tarea.id);
  }

  Future<void> eliminarTarea(int id) async {
    await _notificaciones.cancelar(id);
    await (_db.delete(_db.tareas)..where((t) => t.id.equals(id))).go();
  }

  /// Vuelve a insertar una tarea eliminada (para "Deshacer").
  Future<void> restaurarTarea(Tarea tarea) async {
    await _db.into(_db.tareas).insert(tarea, mode: InsertMode.insertOrReplace);
    await _sincronizarRecordatorio(tarea.id);
  }

  Future<void> limpiarCompletadas(int listaId) async {
    await (_db.delete(
          _db.tareas,
        )..where((t) => t.listaId.equals(listaId) & t.completadaEn.isNotNull()))
        .go();
  }

  /// Programa todos los recordatorios pendientes (al abrir la app, después
  /// de cancelar todos).
  Future<void> programarTodos() async {
    final tareas = await (_db.select(
      _db.tareas,
    )..where((t) => t.recordar.equals(true) & t.completadaEn.isNull())).get();
    for (final t in tareas) {
      await _programar(t);
    }
  }

  Future<void> _sincronizarRecordatorio(int id) async {
    await _notificaciones.cancelar(id);
    final tarea = await (_db.select(
      _db.tareas,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    if (tarea != null) await _programar(tarea);
  }

  Future<void> _programar(Tarea t) async {
    if (!t.recordar ||
        !t.conHora ||
        t.vence == null ||
        t.completadaEn != null) {
      return;
    }
    await _notificaciones.programar(
      id: t.id,
      titulo: t.titulo,
      cuerpo: t.notas?.isNotEmpty == true ? t.notas! : 'Recordatorio de tarea',
      cuando: t.vence!,
    );
  }
}
