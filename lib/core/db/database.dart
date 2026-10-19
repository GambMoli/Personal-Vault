import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import '../../modules/cocina/data/tablas_cocina.dart';
import '../../modules/entrenamiento/data/tablas_entrenamiento.dart';
import '../../modules/finanzas/data/tablas_finanzas.dart';
import '../../modules/ideas/data/tablas_ideas.dart';
import 'semillas.dart';

export '../../modules/cocina/data/tablas_cocina.dart';
export '../../modules/entrenamiento/data/tablas_entrenamiento.dart';
export '../../modules/finanzas/data/tablas_finanzas.dart';
export '../../modules/ideas/data/tablas_ideas.dart';

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

  /// Producto de Cocina asociado (al marcarlo comprado se suma al inventario).
  IntColumn get productoId => integer().nullable().references(
    Productos,
    #id,
    onDelete: KeyAction.setNull,
  )();
  DateTimeColumn get completadaEn => dateTime().nullable()();
  DateTimeColumn get creadaEn => dateTime().withDefault(currentDateAndTime)();
}

@DriftDatabase(
  tables: [
    Listas,
    Tareas,
    Cuentas,
    Categorias,
    Tarjetas,
    Movimientos,
    GastosFijos,
    Metas,
    Deudas,
    Ejercicios,
    Sesiones,
    Series,
    Productos,
    MovimientosCocina,
    Ideas,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
    : super(executor ?? driftDatabase(name: 'personal_vault'));

  @override
  int get schemaVersion => 2;

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
      await sembrarModulos(this);
    },
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        // v2: módulos Finanzas, Entrenamiento, Cocina e Ideas.
        for (final tabla in <TableInfo>[
          productos,
          movimientosCocina,
          cuentas,
          categorias,
          tarjetas,
          gastosFijos,
          movimientos,
          metas,
          deudas,
          ejercicios,
          sesiones,
          series,
          ideas,
        ]) {
          await m.createTable(tabla);
        }
        await m.addColumn(tareas, tareas.productoId);
        await sembrarModulos(this);
      }
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}
