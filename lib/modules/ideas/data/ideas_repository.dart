import 'package:drift/drift.dart';

import '../../../core/db/database.dart';
import 'sugerencias.dart';

class IdeasRepository {
  IdeasRepository(this._db);

  final AppDatabase _db;

  Stream<List<Idea>> watchIdeas() =>
      (_db.select(_db.ideas)..orderBy([
            (i) => OrderingTerm.desc(i.creadaEn),
            (i) => OrderingTerm.desc(i.id),
          ]))
          .watch();

  Stream<Idea?> watchIdea(int id) => (_db.select(
    _db.ideas,
  )..where((i) => i.id.equals(id))).watchSingleOrNull();

  Future<int> guardarIdea(IdeasCompanion datos) async {
    final id = await _db.into(_db.ideas).insertOnConflictUpdate(datos);
    return datos.id.present ? datos.id.value : id;
  }

  Future<int> guardarSugerencia(Sugerencia s, {required String origen}) => _db
      .into(_db.ideas)
      .insert(
        IdeasCompanion.insert(
          titulo: s.titulo,
          formato: Value(s.formato),
          tags: Value(s.tags.join(',')),
          hook: Value(s.hook),
          descripcion: Value(s.razon),
          origen: Value(origen),
        ),
      );

  Future<void> cambiarEstado(Idea idea, String estado) =>
      (_db.update(_db.ideas)..where((i) => i.id.equals(idea.id))).write(
        IdeasCompanion(
          estado: Value(estado),
          publicadaEn:
              estado == EstadoIdea.publicado && idea.publicadaEn == null
              ? Value(DateTime.now())
              : const Value.absent(),
        ),
      );

  Future<void> eliminarIdea(int id) =>
      (_db.delete(_db.ideas)..where((i) => i.id.equals(id))).go();
}
