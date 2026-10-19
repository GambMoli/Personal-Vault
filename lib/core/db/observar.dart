import 'package:drift/drift.dart';

/// Emite [calcular] al suscribirse y cada vez que cambia alguna de [tablas].
///
/// Útil para vistas que combinan varias tablas (resúmenes, dashboards).
Stream<T> observar<T>(
  DatabaseConnectionUser db,
  List<ResultSetImplementation> tablas,
  Future<T> Function() calcular,
) async* {
  yield await calcular();
  await for (final _ in db.tableUpdates(TableUpdateQuery.onAllTables(tablas))) {
    yield await calcular();
  }
}
