import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'database.g.dart';

/// Tipos de lista del módulo Tareas.
abstract final class TipoLista {
  static const general = 'general';
  static const mercado = 'mercado';
}

/// Frecuencias de repetición de una tarea.
abstract final class Repeticion {
  static const ninguna = 'ninguna';
  static const diaria = 'diaria';
  static const semanal = 'semanal';
  static const mensual = 'mensual';
}

@DataClassName('Lista')
class Listas extends Table {
  @override
  String get tableName => 'tar_listas';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombre => text().withLength(min: 1, max: 60)();
  TextColumn get tipo =>
      text().withDefault(const Constant(TipoLista.general))();
  TextColumn get icono => text().withDefault(const Constant('lista'))();
  IntColumn get color => integer().withDefault(const Constant(0xFF3F51B5))();
  IntColumn get orden => integer().withDefault(const Constant(0))();
  DateTimeColumn get creadaEn => dateTime().withDefault(currentDateAndTime)();
}

@DataClassName('Tarea')
class Tareas extends Table {
  @override
  String get tableName => 'tar_tareas';

  IntColumn get id => integer().autoIncrement()();
  IntColumn get listaId =>
      integer().references(Listas, #id, onDelete: KeyAction.cascade)();
  TextColumn get titulo => text().withLength(min: 1, max: 200)();
  TextColumn get notas => text().nullable()();

  /// Fecha límite. Si [conHora] es falso solo importa el día.
  DateTimeColumn get vence => dateTime().nullable()();
  BoolColumn get conHora => boolean().withDefault(const Constant(false))();

  /// Notificar en [vence] (requiere [conHora]).
  BoolColumn get recordar => boolean().withDefault(const Constant(false))();

  /// 0 = normal, 1 = alta, 2 = urgente.
  IntColumn get prioridad => integer().withDefault(const Constant(0))();
  TextColumn get repeticion =>
      text().withDefault(const Constant(Repeticion.ninguna))();

  /// Cantidad libre para listas de mercado ("2 kg", "1 docena").
  TextColumn get cantidad => text().nullable()();
  DateTimeColumn get completadaEn => dateTime().nullable()();
  DateTimeColumn get creadaEn => dateTime().withDefault(currentDateAndTime)();
}

@DriftDatabase(tables: [Listas, Tareas])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
    : super(executor ?? driftDatabase(name: 'personal_vault'));

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      await into(listas).insert(
        ListasCompanion.insert(
          nombre: 'Pendientes',
          icono: const Value('lista'),
          color: const Value(0xFF3F51B5),
        ),
      );
      await into(listas).insert(
        ListasCompanion.insert(
          nombre: 'Mercado',
          tipo: const Value(TipoLista.mercado),
          icono: const Value('mercado'),
          color: const Value(0xFF2E7D32),
          orden: const Value(1),
        ),
      );
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}
