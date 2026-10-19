import 'package:drift/drift.dart';

// Todos los montos se guardan como enteros en centavos.

abstract final class TipoCuenta {
  static const ahorros = 'ahorros';
  static const corriente = 'corriente';
  static const efectivo = 'efectivo';
  static const digital = 'digital';
  static const inversion = 'inversion';
}

abstract final class TipoMovimiento {
  static const gasto = 'gasto';
  static const ingreso = 'ingreso';
  static const transferencia = 'transferencia';

  /// Pago desde una cuenta a una tarjeta de crédito.
  static const pagoTarjeta = 'pago_tarjeta';
}

abstract final class TipoCategoria {
  static const gasto = 'gasto';
  static const ingreso = 'ingreso';
}

abstract final class DireccionDeuda {
  static const debo = 'debo';
  static const meDeben = 'me_deben';
}

@DataClassName('Cuenta')
class Cuentas extends Table {
  @override
  String get tableName => 'fin_cuentas';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombre => text().withLength(min: 1, max: 60)();
  TextColumn get banco => text().nullable()();
  TextColumn get tipo =>
      text().withDefault(const Constant(TipoCuenta.ahorros))();
  IntColumn get saldoInicial => integer().withDefault(const Constant(0))();
  BoolColumn get archivada => boolean().withDefault(const Constant(false))();
}

@DataClassName('Categoria')
class Categorias extends Table {
  @override
  String get tableName => 'fin_categorias';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombre => text().withLength(min: 1, max: 40)();
  TextColumn get tipo => text()();
  TextColumn get icono => text().withDefault(const Constant('otros'))();
  IntColumn get color => integer().withDefault(const Constant(0xFF757575))();

  /// Presupuesto mensual (0 = sin presupuesto).
  IntColumn get presupuesto => integer().withDefault(const Constant(0))();
}

@DataClassName('Tarjeta')
class Tarjetas extends Table {
  @override
  String get tableName => 'fin_tarjetas';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombre => text().withLength(min: 1, max: 60)();
  TextColumn get banco => text().nullable()();
  IntColumn get cupo => integer().withDefault(const Constant(0))();

  /// Deuda al momento de registrar la tarjeta en la app.
  IntColumn get deudaInicial => integer().withDefault(const Constant(0))();
  IntColumn get diaCorte => integer().nullable()();
  IntColumn get diaPago => integer().nullable()();

  /// Tasa efectiva anual en %, solo informativa.
  RealColumn get tasaEa => real().nullable()();
  BoolColumn get archivada => boolean().withDefault(const Constant(false))();
}

@DataClassName('Movimiento')
class Movimientos extends Table {
  @override
  String get tableName => 'fin_movimientos';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get tipo => text()();
  IntColumn get monto => integer()();
  DateTimeColumn get fecha => dateTime()();
  TextColumn get descripcion => text().nullable()();
  IntColumn get categoriaId => integer().nullable().references(
    Categorias,
    #id,
    onDelete: KeyAction.setNull,
  )();

  /// Cuenta de origen (gasto, transferencia, pago de tarjeta) o destino (ingreso).
  IntColumn get cuentaId => integer().nullable().references(
    Cuentas,
    #id,
    onDelete: KeyAction.cascade,
  )();
  IntColumn get cuentaDestinoId => integer().nullable().references(
    Cuentas,
    #id,
    onDelete: KeyAction.cascade,
  )();

  /// Tarjeta con la que se pagó un gasto, o tarjeta que recibe un pago.
  IntColumn get tarjetaId => integer().nullable().references(
    Tarjetas,
    #id,
    onDelete: KeyAction.cascade,
  )();
  IntColumn get cuotas => integer().withDefault(const Constant(1))();
  IntColumn get fijoId => integer().nullable().references(
    GastosFijos,
    #id,
    onDelete: KeyAction.setNull,
  )();
}

@DataClassName('GastoFijo')
class GastosFijos extends Table {
  @override
  String get tableName => 'fin_gastos_fijos';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get descripcion => text().withLength(min: 1, max: 80)();
  IntColumn get monto => integer()();
  IntColumn get dia => integer()();
  IntColumn get categoriaId => integer().nullable().references(
    Categorias,
    #id,
    onDelete: KeyAction.setNull,
  )();
  IntColumn get cuentaId => integer().nullable().references(
    Cuentas,
    #id,
    onDelete: KeyAction.setNull,
  )();
  BoolColumn get recordar => boolean().withDefault(const Constant(true))();
  BoolColumn get activo => boolean().withDefault(const Constant(true))();
}

@DataClassName('Meta')
class Metas extends Table {
  @override
  String get tableName => 'fin_metas';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombre => text().withLength(min: 1, max: 60)();
  IntColumn get objetivo => integer()();
  IntColumn get ahorrado => integer().withDefault(const Constant(0))();
  DateTimeColumn get fechaObjetivo => dateTime().nullable()();

  /// Dónde está guardado el dinero (texto libre: "Nequi", "CDT Bancolombia").
  TextColumn get dondeEsta => text().nullable()();
}

@DataClassName('Deuda')
class Deudas extends Table {
  @override
  String get tableName => 'fin_deudas';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get persona => text().withLength(min: 1, max: 60)();
  TextColumn get direccion => text()();
  IntColumn get monto => integer()();
  IntColumn get abonado => integer().withDefault(const Constant(0))();
  TextColumn get nota => text().nullable()();
  DateTimeColumn get fecha => dateTime()();
}
