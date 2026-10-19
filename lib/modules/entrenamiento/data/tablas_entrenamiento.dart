import 'package:drift/drift.dart';

abstract final class Equipo {
  static const maquina = 'maquina';
  static const mancuerna = 'mancuerna';
  static const barra = 'barra';
  static const polea = 'polea';
  static const pesoCorporal = 'peso_corporal';
}

@DataClassName('Ejercicio')
class Ejercicios extends Table {
  @override
  String get tableName => 'ent_ejercicios';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombre => text().withLength(min: 1, max: 80)();
  TextColumn get grupo => text()();
  TextColumn get equipo => text().withDefault(const Constant(Equipo.maquina))();

  /// Nombre de la máquina concreta del gimnasio, si aplica.
  TextColumn get maquina => text().nullable()();
}

@DataClassName('Sesion')
class Sesiones extends Table {
  @override
  String get tableName => 'ent_sesiones';

  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get fecha => dateTime()();

  /// Lo que se entrenó: "Espalda", "Pecho y tríceps"...
  TextColumn get titulo => text().withLength(min: 1, max: 60)();
  TextColumn get notas => text().nullable()();
}

@DataClassName('Serie')
class Series extends Table {
  @override
  String get tableName => 'ent_series';

  IntColumn get id => integer().autoIncrement()();
  IntColumn get sesionId =>
      integer().references(Sesiones, #id, onDelete: KeyAction.cascade)();
  IntColumn get ejercicioId =>
      integer().references(Ejercicios, #id, onDelete: KeyAction.cascade)();
  IntColumn get orden => integer()();
  IntColumn get reps => integer()();
  RealColumn get pesoKg => real().withDefault(const Constant(0))();
}
