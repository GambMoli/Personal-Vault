import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:personal_vault/core/db/database.dart';
import 'package:personal_vault/core/formato.dart';
import 'package:personal_vault/core/notifications/notification_service.dart';
import 'package:personal_vault/modules/finanzas/data/finanzas_repository.dart';

void main() {
  group('formato de dinero', () {
    test('parseDinero entiende formatos colombianos', () {
      expect(parseDinero('1.250.000'), 125000000);
      expect(parseDinero('1250000'), 125000000);
      expect(parseDinero('\$ 45.900,50'), 4590050);
      expect(parseDinero('12.5'), 1250);
      expect(parseDinero('abc'), isNull);
      expect(parseDinero(''), isNull);
    });

    test('dinero muestra miles con punto', () {
      expect(dinero(125000000), '\$ 1.250.000');
      expect(dinero(-4590050), '-\$ 45.900,50');
      expect(dinero(100, signo: true), '+\$ 1');
    });

    test('proximoDiaDelMes ajusta meses cortos', () {
      expect(
        proximoDiaDelMes(31, DateTime(2026, 2, 10)),
        DateTime(2026, 2, 28, 9),
      );
      expect(
        proximoDiaDelMes(5, DateTime(2026, 10, 19)),
        DateTime(2026, 11, 5, 9),
      );
      expect(
        proximoDiaDelMes(19, DateTime(2026, 10, 19, 8)),
        DateTime(2026, 10, 19, 9),
      );
    });
  });

  group('FinanzasRepository', () {
    late AppDatabase db;
    late FinanzasRepository repo;
    final ahora = DateTime(2026, 10, 19, 12);

    setUp(() {
      db = AppDatabase(NativeDatabase.memory());
      repo = FinanzasRepository(db, const NoopNotificationService());
    });
    tearDown(() => db.close());

    Future<int> cuenta(String nombre, int saldo) => db
        .into(db.cuentas)
        .insert(
          CuentasCompanion.insert(nombre: nombre, saldoInicial: Value(saldo)),
        );

    Future<void> mov(
      String tipo,
      int monto, {
      int? cuenta,
      int? destino,
      int? tarjeta,
      int? fijo,
      int? categoria,
      DateTime? fecha,
    }) => repo.guardarMovimiento(
      MovimientosCompanion.insert(
        tipo: tipo,
        monto: monto,
        fecha: fecha ?? ahora,
        cuentaId: Value(cuenta),
        cuentaDestinoId: Value(destino),
        tarjetaId: Value(tarjeta),
        fijoId: Value(fijo),
        categoriaId: Value(categoria),
      ),
    );

    test('saldos, tarjetas, gastos fijos y patrimonio', () async {
      final efectivo = (await db.select(db.cuentas).getSingle()).id; // sembrada
      final nomina = await cuenta('Nómina', 1000000);
      final visa = await db
          .into(db.tarjetas)
          .insert(
            TarjetasCompanion.insert(
              nombre: 'Visa',
              cupo: const Value(5000000),
              deudaInicial: const Value(200000),
            ),
          );
      final arriendo = await db
          .into(db.gastosFijos)
          .insert(
            GastosFijosCompanion.insert(
              descripcion: 'Arriendo',
              monto: 300000,
              dia: 5,
            ),
          );
      await db
          .into(db.gastosFijos)
          .insert(
            GastosFijosCompanion.insert(
              descripcion: 'Internet',
              monto: 80000,
              dia: 20,
            ),
          );
      final mercado = (await db.select(db.categorias).get())
          .firstWhere((c) => c.nombre == 'Mercado')
          .id;

      await mov(TipoMovimiento.ingreso, 500000, cuenta: nomina);
      await mov(TipoMovimiento.gasto, 300000, cuenta: nomina, fijo: arriendo);
      await mov(
        TipoMovimiento.gasto,
        150000,
        tarjeta: visa,
        categoria: mercado,
      );
      await mov(
        TipoMovimiento.transferencia,
        100000,
        cuenta: nomina,
        destino: efectivo,
      );
      await mov(
        TipoMovimiento.pagoTarjeta,
        50000,
        cuenta: nomina,
        tarjeta: visa,
      );
      // Gasto de otro mes: afecta el saldo pero no el resumen del mes.
      await mov(
        TipoMovimiento.gasto,
        10000,
        cuenta: efectivo,
        fecha: DateTime(2026, 9, 1),
      );
      await db
          .into(db.deudas)
          .insert(
            DeudasCompanion.insert(
              persona: 'Juan',
              direccion: DireccionDeuda.meDeben,
              monto: 40000,
              abonado: const Value(10000),
              fecha: ahora,
            ),
          );

      final e = await repo.estado(ahora);
      final saldos = {for (final c in e.cuentas) c.cuenta.nombre: c.saldo};
      expect(saldos, {'Efectivo': 90000, 'Nómina': 1050000});
      expect(e.tarjetas.single.deuda, 300000);
      expect(e.ingresosMes, 500000);
      expect(e.gastosMes, 450000);
      expect(e.fijos.map((f) => (f.fijo.descripcion, f.pagado)), [
        ('Arriendo', true),
        ('Internet', false),
      ]);
      expect(e.fijosPendientes, 80000);
      expect(e.libre, 1140000 - 80000);
      expect(e.meDeben, 30000);
      expect(e.patrimonio, 1140000 + 30000 - 300000);
      expect(
        e.gastosPorCategoria
            .firstWhere((g) => g.categoria?.id == mercado)
            .gastado,
        150000,
      );
    });

    test('registrarFijo marca el gasto fijo como pagado', () async {
      final f = await db
          .into(db.gastosFijos)
          .insertReturning(
            GastosFijosCompanion.insert(
              descripcion: 'Netflix',
              monto: 30000,
              dia: 1,
            ),
          );
      await repo.registrarFijo(f, fecha: ahora);
      final e = await repo.estado(ahora);
      expect(e.fijos.single.pagado, isTrue);
      expect(e.gastosMes, 30000);
    });
  });

  test('migración v1 → v2 conserva las tareas y siembra los módulos', () async {
    final db = AppDatabase(
      NativeDatabase.memory(
        setup: (raw) {
          raw.execute(
            '''CREATE TABLE "tar_listas" ("id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        "nombre" TEXT NOT NULL, "tipo" TEXT NOT NULL DEFAULT 'general',
        "icono" TEXT NOT NULL DEFAULT 'lista', "color" INTEGER NOT NULL DEFAULT 4282339765,
        "orden" INTEGER NOT NULL DEFAULT 0,
        "creada_en" INTEGER NOT NULL DEFAULT (CAST(strftime('%s', CURRENT_TIMESTAMP) AS INTEGER)))''',
          );
          raw.execute(
            '''CREATE TABLE "tar_tareas" ("id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        "lista_id" INTEGER NOT NULL REFERENCES tar_listas (id) ON DELETE CASCADE,
        "titulo" TEXT NOT NULL, "notas" TEXT NULL, "vence" INTEGER NULL,
        "con_hora" INTEGER NOT NULL DEFAULT 0, "recordar" INTEGER NOT NULL DEFAULT 0,
        "prioridad" INTEGER NOT NULL DEFAULT 0, "repeticion" TEXT NOT NULL DEFAULT 'ninguna',
        "cantidad" TEXT NULL, "completada_en" INTEGER NULL,
        "creada_en" INTEGER NOT NULL DEFAULT (CAST(strftime('%s', CURRENT_TIMESTAMP) AS INTEGER)))''',
          );
          raw.execute("INSERT INTO tar_listas (nombre) VALUES ('Pendientes')");
          raw.execute(
            "INSERT INTO tar_tareas (lista_id, titulo) VALUES (1, 'Tarea vieja')",
          );
          raw.execute('PRAGMA user_version = 1');
        },
      ),
    );
    addTearDown(db.close);

    final tareas = await db.select(db.tareas).get();
    expect(tareas.single.titulo, 'Tarea vieja');
    expect(tareas.single.productoId, isNull);
    expect(await db.select(db.categorias).get(), isNotEmpty);
    expect(await db.select(db.ejercicios).get(), isNotEmpty);
    expect((await db.select(db.listas).get()).length, 1);
  });
}
