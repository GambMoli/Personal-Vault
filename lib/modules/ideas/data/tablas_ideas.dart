import 'package:drift/drift.dart';

abstract final class FormatoIdea {
  static const reel = 'reel';
  static const carrusel = 'carrusel';
  static const post = 'post';
  static const historia = 'historia';
  static const todos = [reel, carrusel, post, historia];
}

/// Etapas del pipeline de contenido, en orden.
abstract final class EstadoIdea {
  static const idea = 'idea';
  static const guion = 'guion';
  static const grabando = 'grabando';
  static const editando = 'editando';
  static const publicado = 'publicado';
  static const todos = [idea, guion, grabando, editando, publicado];
}

abstract final class OrigenIdea {
  static const manual = 'manual';
  static const reglas = 'reglas';
  static const chat = 'chat';
}

@DataClassName('Idea')
class Ideas extends Table {
  @override
  String get tableName => 'ide_ideas';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get titulo => text().withLength(min: 1, max: 200)();
  TextColumn get descripcion => text().nullable()();
  TextColumn get formato =>
      text().withDefault(const Constant(FormatoIdea.reel))();

  /// Tags en minúscula separados por coma: "javascript,css".
  TextColumn get tags => text().withDefault(const Constant(''))();
  TextColumn get estado =>
      text().withDefault(const Constant(EstadoIdea.idea))();
  TextColumn get hook => text().nullable()();
  TextColumn get guion => text().nullable()();
  TextColumn get codigo => text().nullable()();
  TextColumn get caption => text().nullable()();
  DateTimeColumn get publicadaEn => dateTime().nullable()();
  IntColumn get likes => integer().nullable()();
  IntColumn get guardados => integer().nullable()();
  IntColumn get comentarios => integer().nullable()();
  IntColumn get alcance => integer().nullable()();
  TextColumn get origen =>
      text().withDefault(const Constant(OrigenIdea.manual))();
  DateTimeColumn get creadaEn => dateTime().withDefault(currentDateAndTime)();
}
