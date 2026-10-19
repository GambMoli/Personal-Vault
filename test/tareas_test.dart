import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:personal_vault/core/db/database.dart';
import 'package:personal_vault/core/notifications/notification_service.dart';
import 'package:personal_vault/modules/tareas/data/recurrencia.dart';
import 'package:personal_vault/modules/tareas/data/tareas_repository.dart';

class _NotificacionesFalsas implements NotificationService {
  final programadas = <int, DateTime>{};

  @override
  Future<void> programar({
    required int id,
    required String titulo,
    required String cuerpo,
    required DateTime cuando,
  }) async => programadas[id] = cuando;

  @override
  Future<void> cancelar(int id) async => programadas.remove(id);

  @override
  Future<void> cancelarTodas() async => programadas.clear();
}

void main() {
  group('siguienteVencimiento', () {
    final ahora = DateTime(2026, 10, 19, 10);

    test('no se repite', () {
      expect(
        siguienteVencimiento(
          ahora,
          Repeticion.ninguna,
          conHora: true,
          ahora: ahora,
        ),
        isNull,
      );
    });

    test('diaria a tiempo avanza un día y conserva la hora', () {
      expect(
        siguienteVencimiento(
          DateTime(2026, 10, 19, 8, 30),
          Repeticion.diaria,
          conHora: true,
          ahora: ahora,
        ),
        DateTime(2026, 10, 20, 8, 30),
      );
    });

    test('semanal atrasada salta hasta el futuro', () {
      expect(
        siguienteVencimiento(
          DateTime(2026, 9, 28),
          Repeticion.semanal,
          conHora: false,
          ahora: ahora,
        ),
        DateTime(2026, 10, 26),
      );
    });

    test('mensual del 31 cae en el último día del mes', () {
      expect(
        siguienteVencimiento(
          DateTime(2026, 1, 31),
          Repeticion.mensual,
          conHora: false,
          ahora: DateTime(2026, 2, 1),
        ),
        DateTime(2026, 2, 28),
      );
      expect(
        siguienteVencimiento(
          DateTime(2026, 12, 15),
          Repeticion.mensual,
          conHora: false,
          ahora: DateTime(2026, 12, 15),
        ),
        DateTime(2027, 1, 15),
      );
    });
  });

  group('TareasRepository', () {
    late AppDatabase db;
    late _NotificacionesFalsas notificaciones;
    late TareasRepository repo;

    setUp(() {
      db = AppDatabase(NativeDatabase.memory());
      notificaciones = _NotificacionesFalsas();
      repo = TareasRepository(db, notificaciones);
    });
    tearDown(() => db.close());

    test('crea las listas Pendientes y Mercado al iniciar', () async {
      final listas = await repo.watchListas().first;
      expect(listas.map((l) => l.lista.nombre), ['Pendientes', 'Mercado']);
      expect(listas[1].lista.tipo, TipoLista.mercado);
    });

    test('cuenta pendientes y programa recordatorios', () async {
      final lista = (await repo.watchListas().first).first.lista;
      // La BD guarda segundos, así que se descartan los milisegundos.
      final enDosHoras = DateTime.now().add(const Duration(hours: 2));
      final cuando = DateTime(
        enDosHoras.year,
        enDosHoras.month,
        enDosHoras.day,
        enDosHoras.hour,
        enDosHoras.minute,
      );
      final id = await repo.guardarTarea(
        TareasCompanion(
          listaId: Value(lista.id),
          titulo: const Value('Pagar tarjeta'),
          vence: Value(cuando),
          conHora: const Value(true),
          recordar: const Value(true),
        ),
      );
      await repo.guardarTarea(
        TareasCompanion(
          listaId: Value(lista.id),
          titulo: const Value('Sin recordatorio'),
        ),
      );

      expect(notificaciones.programadas, {id: cuando});
      expect((await repo.watchListas().first).first.pendientes, 2);

      final tarea = (await repo.watchTareasDeLista(lista.id).first).firstWhere(
        (t) => t.id == id,
      );
      await repo.alternarCompletada(tarea);
      expect(notificaciones.programadas, isEmpty);
      expect((await repo.watchListas().first).first.pendientes, 1);
    });

    test(
      'completar una tarea repetitiva la mueve a la siguiente fecha',
      () async {
        final lista = (await repo.watchListas().first).first.lista;
        final id = await repo.guardarTarea(
          TareasCompanion(
            listaId: Value(lista.id),
            titulo: const Value('Sacar la basura'),
            vence: Value(DateTime(2026, 10, 19)),
            repeticion: const Value(Repeticion.semanal),
          ),
        );
        final tarea = (await repo.watchTareasDeLista(lista.id).first).single;
        await repo.alternarCompletada(tarea, ahora: DateTime(2026, 10, 19, 12));

        final despues = (await repo.watchTareasDeLista(lista.id).first).single;
        expect(despues.id, id);
        expect(despues.completadaEn, isNull);
        expect(despues.vence, DateTime(2026, 10, 26));
      },
    );

    test('Hoy incluye atrasadas y de hoy, no futuras ni completadas', () async {
      final lista = (await repo.watchListas().first).first.lista;
      final hoy = DateTime(2026, 10, 19);
      Future<void> crear(String titulo, DateTime vence) => repo.guardarTarea(
        TareasCompanion(
          listaId: Value(lista.id),
          titulo: Value(titulo),
          vence: Value(vence),
        ),
      );
      await crear('Atrasada', DateTime(2026, 10, 17));
      await crear('Hoy', DateTime(2026, 10, 19, 18));
      await crear('Mañana', DateTime(2026, 10, 20));

      final titulos = (await repo.watchHoy(hoy).first).map(
        (t) => t.tarea.titulo,
      );
      expect(titulos, ['Atrasada', 'Hoy']);
    });

    test('eliminar una lista borra sus tareas', () async {
      final id = await repo.crearLista('Viaje', tipo: TipoLista.general);
      await repo.guardarTarea(
        TareasCompanion(listaId: Value(id), titulo: const Value('Pasaporte')),
      );
      await repo.eliminarLista(id);
      expect(await db.select(db.tareas).get(), isEmpty);
    });
  });
}
