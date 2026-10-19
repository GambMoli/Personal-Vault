import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:personal_vault/core/db/database.dart';
import 'package:personal_vault/modules/entrenamiento/data/entrenamiento_repository.dart';

void main() {
  late AppDatabase db;
  late EntrenamientoRepository repo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = EntrenamientoRepository(db);
  });
  tearDown(() => db.close());

  Future<int> ejercicio(String nombre) async =>
      (await db.select(db.ejercicios).get())
          .firstWhere((e) => e.nombre == nombre)
          .id;

  test('repetir la última sesión copia ejercicios y pesos', () async {
    final jalon = await ejercicio('Jalón al pecho');
    final remo = await ejercicio('Remo con barra');
    final martes = await repo.crearSesion(DateTime(2026, 10, 13), 'Espalda');
    await repo.agregarSerie(martes, jalon, reps: 12, pesoKg: 45);
    await repo.agregarSerie(martes, jalon, reps: 10, pesoKg: 50);
    await repo.agregarSerie(martes, remo, reps: 10, pesoKg: 40);

    final anterior = await repo.ultimaSesionCon('espalda');
    expect(anterior?.id, martes);

    final hoy = await repo.crearSesion(
      DateTime(2026, 10, 20),
      'Espalda',
      copiarDe: anterior!.id,
    );
    final detalle = (await repo.watchSesion(hoy).first)!;
    expect(detalle.ejercicios.map((e) => e.ejercicio.nombre), [
      'Jalón al pecho',
      'Remo con barra',
    ]);
    expect(detalle.ejercicios.first.series.map((s) => (s.reps, s.pesoKg)), [
      (12, 45.0),
      (10, 50.0),
    ]);
    expect(detalle.totalSeries, 3);
  });

  test('ultimaVez devuelve las series de la sesión anterior', () async {
    final prensa = await ejercicio('Prensa');
    final s1 = await repo.crearSesion(DateTime(2026, 10, 1), 'Pierna');
    await repo.agregarSerie(s1, prensa, reps: 10, pesoKg: 100);
    final s2 = await repo.crearSesion(DateTime(2026, 10, 8), 'Pierna');
    await repo.agregarSerie(s2, prensa, reps: 10, pesoKg: 120);
    final s3 = await repo.crearSesion(DateTime(2026, 10, 15), 'Pierna');

    expect((await repo.ultimaVez(prensa, antesDe: s3)).single.pesoKg, 120);
    expect((await repo.ultimaVez(prensa, antesDe: s2)).single.pesoKg, 100);
  });

  test('progreso: peso máximo y volumen por sesión, en orden', () async {
    final banca = await ejercicio('Press de banca');
    final s2 = await repo.crearSesion(DateTime(2026, 10, 8), 'Pecho');
    await repo.agregarSerie(s2, banca, reps: 8, pesoKg: 62.5);
    await repo.agregarSerie(s2, banca, reps: 6, pesoKg: 62.5);
    final s1 = await repo.crearSesion(DateTime(2026, 10, 1), 'Pecho');
    await repo.agregarSerie(s1, banca, reps: 10, pesoKg: 60);

    final puntos = await repo.watchProgreso(banca).first;
    expect(puntos.map((p) => p.pesoMax), [60, 62.5]);
    expect(puntos.last.volumen, 8 * 62.5 + 6 * 62.5);
    expect(puntos.last.mejorReps, 8);
  });
}
