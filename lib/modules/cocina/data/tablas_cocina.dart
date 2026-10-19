import 'package:drift/drift.dart';

abstract final class Ubicacion {
  static const nevera = 'nevera';
  static const congelador = 'congelador';
  static const alacena = 'alacena';
}

abstract final class TipoMovCocina {
  static const compra = 'compra';
  static const consumo = 'consumo';
  static const desecho = 'desecho';
}

@DataClassName('Producto')
class Productos extends Table {
  @override
  String get tableName => 'coc_productos';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombre => text().withLength(min: 1, max: 60)();

  /// "kg", "g", "L", "ml", "und".
  TextColumn get unidad => text().withDefault(const Constant('und'))();
  TextColumn get ubicacion =>
      text().withDefault(const Constant(Ubicacion.alacena))();

  /// Cantidad que hay ahora mismo.
  RealColumn get cantidad => real().withDefault(const Constant(0))();

  /// Por debajo de esto se sugiere comprar.
  RealColumn get stockMinimo => real().withDefault(const Constant(0))();

  /// Lo que se compra normalmente de una vez (se suma al marcarlo comprado).
  RealColumn get compraHabitual => real().withDefault(const Constant(1))();
  DateTimeColumn get vence => dateTime().nullable()();
}

@DataClassName('MovCocina')
class MovimientosCocina extends Table {
  @override
  String get tableName => 'coc_movimientos';

  IntColumn get id => integer().autoIncrement()();
  IntColumn get productoId =>
      integer().references(Productos, #id, onDelete: KeyAction.cascade)();
  TextColumn get tipo => text()();
  RealColumn get cantidad => real()();
  DateTimeColumn get fecha => dateTime()();
}
