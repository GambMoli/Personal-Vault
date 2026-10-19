import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:personal_vault/core/db/database.dart';
import 'package:personal_vault/core/notifications/notification_service.dart';
import 'package:personal_vault/modules/cocina/data/cocina_repository.dart';
import 'package:personal_vault/modules/tareas/data/tareas_repository.dart';

MovCocina _mov(String tipo, double cantidad, DateTime fecha) => MovCocina(
  id: 0,
  productoId: 1,
  tipo: tipo,
  cantidad: cantidad,
  fecha: fecha,
);

void main() {
  group('estimarDuracion', () {
    final ahora = DateTime(2026, 10, 19, 12);

    test('sin consumos no hay estimación', () {
      final e = estimarDuracion(
        cantidad: 2,
        movimientos: [
          _mov(
            TipoMovCocina.compra,
            2,
            ahora.subtract(const Duration(days: 3)),
          ),
        ],
        ahora: ahora,
      );
      expect(e.consumoDiario, isNull);
      expect(e.diasRestantes, isNull);
    });

    test('promedia desde el primer movimiento de la ventana', () {
      // Compró hace 10 días y usó 5 kg en total → 0,5 kg/día; quedan 2 kg → 4 días.
      final e = estimarDuracion(
        cantidad: 2,
        movimientos: [
          _mov(
            TipoMovCocina.compra,
            7,
            ahora.subtract(const Duration(days: 10)),
          ),
          _mov(
            TipoMovCocina.consumo,
            3,
            ahora.subtract(const Duration(days: 6)),
          ),
          _mov(
            TipoMovCocina.consumo,
            2,
            ahora.subtract(const Duration(days: 1)),
          ),
          // Fuera de la ventana de 30 días: se ignora.
          _mov(
            TipoMovCocina.consumo,
            50,
            ahora.subtract(const Duration(days: 40)),
          ),
        ],
        ahora: ahora,
      );
      expect(e.consumoDiario, closeTo(0.5, 1e-9));
      expect(e.diasRestantes, closeTo(4, 1e-9));
    });
  });

  group('CocinaRepository', () {
    late AppDatabase db;
    late CocinaRepository repo;

    setUp(() {
      db = AppDatabase(NativeDatabase.memory());
      repo = CocinaRepository(db, const NoopNotificationService());
    });
    tearDown(() => db.close());

    Future<Producto> producto(int id) =>
        (db.select(db.productos)..where((p) => p.id.equals(id))).getSingle();

    test('consumir no baja de cero y queda en el historial', () async {
      final id = await repo.guardarProducto(
        ProductosCompanion.insert(
          nombre: 'Huevos',
          cantidad: const Value(3),
          compraHabitual: const Value(30),
        ),
      );
      await repo.consumir(await producto(id), 5);
      expect((await producto(id)).cantidad, 0);
      final tipos = (await repo.watchHistorial(id).first).map(
        (m) => (m.tipo, m.cantidad),
      );
      expect(
        tipos,
        containsAll([
          (TipoMovCocina.compra, 3.0),
          (TipoMovCocina.consumo, 3.0),
        ]),
      );
    });

    test(
      'lista de mercado: sin duplicados y comprar suma al inventario',
      () async {
        final id = await repo.guardarProducto(
          ProductosCompanion.insert(
            nombre: 'Leche',
            unidad: const Value('L'),
            compraHabitual: const Value(6),
          ),
        );
        final p = await producto(id);
        expect(await repo.agregarAMercado([p]), 1);
        expect(await repo.agregarAMercado([p]), 0);

        final tarea = await (db.select(
          db.tareas,
        )..where((t) => t.productoId.equals(id))).getSingle();
        expect(tarea.cantidad, '6 L');

        final tareas = TareasRepository(db, const NoopNotificationService());
        await tareas.alternarCompletada(tarea);
        expect((await producto(id)).cantidad, 6);

        final completada = await (db.select(
          db.tareas,
        )..where((t) => t.id.equals(tarea.id))).getSingle();
        await tareas.alternarCompletada(completada);
        expect((await producto(id)).cantidad, 0);
      },
    );

    test('por acabarse: agotado, bajo el mínimo o pocos días', () async {
      await repo.guardarProducto(
        ProductosCompanion.insert(nombre: 'Sal', cantidad: const Value(0)),
      );
      await repo.guardarProducto(
        ProductosCompanion.insert(
          nombre: 'Aceite',
          cantidad: const Value(1),
          stockMinimo: const Value(1),
        ),
      );
      await repo.guardarProducto(
        ProductosCompanion.insert(nombre: 'Arroz', cantidad: const Value(5)),
      );

      final porNombre = {
        for (final e in await repo.inventario(DateTime.now()))
          e.producto.nombre: e.porAcabarse,
      };
      expect(porNombre, {'Aceite': true, 'Arroz': false, 'Sal': true});
    });
  });
}
