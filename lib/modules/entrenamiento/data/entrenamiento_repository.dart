import 'package:drift/drift.dart';

import '../../../core/db/database.dart';
import '../../../core/db/observar.dart';

class EjercicioEnSesion {
  const EjercicioEnSesion(this.ejercicio, this.series);
  final Ejercicio ejercicio;
  final List<Serie> series;

  double get pesoMax => series.fold(0, (m, s) => s.pesoKg > m ? s.pesoKg : m);
}

class SesionDetalle {
  const SesionDetalle(this.sesion, this.ejercicios);
  final Sesion sesion;
  final List<EjercicioEnSesion> ejercicios;

  int get totalSeries => ejercicios.fold(0, (n, e) => n + e.series.length);
}

/// Un punto del progreso de un ejercicio (una sesión).
class PuntoProgreso {
  const PuntoProgreso(this.fecha, this.pesoMax, this.volumen, this.mejorReps);
  final DateTime fecha;
  final double pesoMax;

  /// Σ reps × kg.
  final double volumen;

  /// Reps hechas con el peso máximo.
  final int mejorReps;
}

/// Agrupa series por sesión y calcula el progreso de un ejercicio.
List<PuntoProgreso> calcularProgreso(List<(Sesion, Serie)> filas) {
  final porSesion = <int, (Sesion, List<Serie>)>{};
  for (final (sesion, serie) in filas) {
    porSesion.putIfAbsent(sesion.id, () => (sesion, [])).$2.add(serie);
  }
  final puntos = [
    for (final (sesion, series) in porSesion.values)
      () {
        var max = series.first;
        var volumen = 0.0;
        for (final s in series) {
          volumen += s.reps * s.pesoKg;
          if (s.pesoKg > max.pesoKg ||
              (s.pesoKg == max.pesoKg && s.reps > max.reps)) {
            max = s;
          }
        }
        return PuntoProgreso(sesion.fecha, max.pesoKg, volumen, max.reps);
      }(),
  ]..sort((a, b) => a.fecha.compareTo(b.fecha));
  return puntos;
}

class EntrenamientoRepository {
  EntrenamientoRepository(this._db);

  final AppDatabase _db;

  // ---------- Sesiones ----------

  Stream<List<SesionDetalle>> watchHistorial({int limite = 60}) =>
      observar(_db, [_db.sesiones, _db.series, _db.ejercicios], () async {
        final sesiones =
            await (_db.select(_db.sesiones)
                  ..orderBy([
                    (s) => OrderingTerm.desc(s.fecha),
                    (s) => OrderingTerm.desc(s.id),
                  ])
                  ..limit(limite))
                .get();
        return _detalles(sesiones);
      });

  Stream<SesionDetalle?> watchSesion(int id) =>
      observar(_db, [_db.sesiones, _db.series, _db.ejercicios], () async {
        final s = await (_db.select(
          _db.sesiones,
        )..where((s) => s.id.equals(id))).getSingleOrNull();
        return s == null ? null : (await _detalles([s])).single;
      });

  Future<List<SesionDetalle>> _detalles(List<Sesion> sesiones) async {
    if (sesiones.isEmpty) return [];
    final filas =
        await (_db.select(_db.series).join([
                innerJoin(
                  _db.ejercicios,
                  _db.ejercicios.id.equalsExp(_db.series.ejercicioId),
                ),
              ])
              ..where(_db.series.sesionId.isIn(sesiones.map((s) => s.id)))
              ..orderBy([
                OrderingTerm.asc(_db.series.orden),
                OrderingTerm.asc(_db.series.id),
              ]))
            .get();

    final porSesion = <int, Map<int, EjercicioEnSesion>>{};
    for (final f in filas) {
      final serie = f.readTable(_db.series);
      final ejercicio = f.readTable(_db.ejercicios);
      porSesion
          .putIfAbsent(serie.sesionId, () => {})
          .putIfAbsent(ejercicio.id, () => EjercicioEnSesion(ejercicio, []))
          .series
          .add(serie);
    }
    return [
      for (final s in sesiones)
        SesionDetalle(s, porSesion[s.id]?.values.toList() ?? []),
    ];
  }

  /// Títulos usados recientemente ("Espalda", "Pierna"...), sin repetir.
  Future<List<String>> titulosRecientes() async {
    final sesiones =
        await (_db.select(_db.sesiones)
              ..orderBy([(s) => OrderingTerm.desc(s.fecha)])
              ..limit(50))
            .get();
    return {for (final s in sesiones) s.titulo}.toList();
  }

  Future<Sesion?> ultimaSesionCon(String titulo) =>
      (_db.select(_db.sesiones)
            ..where((s) => s.titulo.lower().equals(titulo.trim().toLowerCase()))
            ..orderBy([
              (s) => OrderingTerm.desc(s.fecha),
              (s) => OrderingTerm.desc(s.id),
            ])
            ..limit(1))
          .getSingleOrNull();

  /// Crea una sesión. Con [copiarDe] repite sus ejercicios y series.
  Future<int> crearSesion(DateTime fecha, String titulo, {int? copiarDe}) {
    return _db.transaction(() async {
      final id = await _db
          .into(_db.sesiones)
          .insert(
            SesionesCompanion.insert(fecha: fecha, titulo: titulo.trim()),
          );
      if (copiarDe != null) {
        final series = await (_db.select(
          _db.series,
        )..where((s) => s.sesionId.equals(copiarDe))).get();
        await _db.batch(
          (b) => b.insertAll(_db.series, [
            for (final s in series)
              SeriesCompanion.insert(
                sesionId: id,
                ejercicioId: s.ejercicioId,
                orden: s.orden,
                reps: s.reps,
                pesoKg: Value(s.pesoKg),
              ),
          ]),
        );
      }
      return id;
    });
  }

  Future<void> actualizarSesion(
    int id, {
    required DateTime fecha,
    required String titulo,
    String? notas,
  }) => (_db.update(_db.sesiones)..where((s) => s.id.equals(id))).write(
    SesionesCompanion(
      fecha: Value(fecha),
      titulo: Value(titulo.trim()),
      notas: Value(notas),
    ),
  );

  Future<void> eliminarSesion(int id) =>
      (_db.delete(_db.sesiones)..where((s) => s.id.equals(id))).go();

  // ---------- Series ----------

  Future<void> agregarSerie(
    int sesionId,
    int ejercicioId, {
    required int reps,
    required double pesoKg,
  }) async {
    final maxOrden = _db.series.orden.max();
    final orden =
        await (_db.selectOnly(_db.series)
              ..addColumns([maxOrden])
              ..where(_db.series.sesionId.equals(sesionId)))
            .map((r) => r.read(maxOrden))
            .getSingle();
    await _db
        .into(_db.series)
        .insert(
          SeriesCompanion.insert(
            sesionId: sesionId,
            ejercicioId: ejercicioId,
            orden: (orden ?? 0) + 1,
            reps: reps,
            pesoKg: Value(pesoKg),
          ),
        );
  }

  Future<void> actualizarSerie(
    int id, {
    required int reps,
    required double pesoKg,
  }) => (_db.update(_db.series)..where((s) => s.id.equals(id))).write(
    SeriesCompanion(reps: Value(reps), pesoKg: Value(pesoKg)),
  );

  Future<void> eliminarSerie(int id) =>
      (_db.delete(_db.series)..where((s) => s.id.equals(id))).go();

  Future<void> quitarEjercicio(int sesionId, int ejercicioId) =>
      (_db.delete(_db.series)..where(
            (s) =>
                s.sesionId.equals(sesionId) & s.ejercicioId.equals(ejercicioId),
          ))
          .go();

  /// Series de la última vez que se hizo el ejercicio (antes de [antesDe]).
  Future<List<Serie>> ultimaVez(int ejercicioId, {required int antesDe}) async {
    final sesionActual = await (_db.select(
      _db.sesiones,
    )..where((s) => s.id.equals(antesDe))).getSingle();
    final fila =
        await (_db.select(_db.series).join([
                innerJoin(
                  _db.sesiones,
                  _db.sesiones.id.equalsExp(_db.series.sesionId),
                ),
              ])
              ..where(
                _db.series.ejercicioId.equals(ejercicioId) &
                    _db.series.sesionId.equals(antesDe).not() &
                    _db.sesiones.fecha.isSmallerOrEqualValue(
                      sesionActual.fecha,
                    ),
              )
              ..orderBy([
                OrderingTerm.desc(_db.sesiones.fecha),
                OrderingTerm.desc(_db.sesiones.id),
              ])
              ..limit(1))
            .getSingleOrNull();
    if (fila == null) return [];
    final sesionId = fila.readTable(_db.series).sesionId;
    return (_db.select(_db.series)
          ..where(
            (s) =>
                s.sesionId.equals(sesionId) & s.ejercicioId.equals(ejercicioId),
          )
          ..orderBy([(s) => OrderingTerm.asc(s.orden)]))
        .get();
  }

  // ---------- Progreso ----------

  Stream<List<PuntoProgreso>> watchProgreso(int ejercicioId) {
    final query = _db.select(_db.series).join([
      innerJoin(_db.sesiones, _db.sesiones.id.equalsExp(_db.series.sesionId)),
    ])..where(_db.series.ejercicioId.equals(ejercicioId));
    return query.watch().map(
      (filas) => calcularProgreso([
        for (final f in filas)
          (f.readTable(_db.sesiones), f.readTable(_db.series)),
      ]),
    );
  }

  /// Ejercicios que tienen al menos una serie registrada.
  Stream<List<Ejercicio>> watchEjerciciosConDatos() {
    final query = _db.selectOnly(_db.series, distinct: true)
      ..addColumns([_db.series.ejercicioId]);
    return observar(_db, [_db.series, _db.ejercicios], () async {
      final ids = await query.map((r) => r.read(_db.series.ejercicioId)!).get();
      return (_db.select(_db.ejercicios)
            ..where((e) => e.id.isIn(ids))
            ..orderBy([(e) => OrderingTerm.asc(e.nombre)]))
          .get();
    });
  }

  // ---------- Ejercicios ----------

  Stream<List<Ejercicio>> watchEjercicios() =>
      (_db.select(_db.ejercicios)..orderBy([
            (e) => OrderingTerm.asc(e.grupo),
            (e) => OrderingTerm.asc(e.nombre),
          ]))
          .watch();

  Future<int> guardarEjercicio(EjerciciosCompanion datos) async {
    final id = await _db.into(_db.ejercicios).insertOnConflictUpdate(datos);
    return datos.id.present ? datos.id.value : id;
  }

  Future<void> eliminarEjercicio(int id) =>
      (_db.delete(_db.ejercicios)..where((e) => e.id.equals(id))).go();
}
