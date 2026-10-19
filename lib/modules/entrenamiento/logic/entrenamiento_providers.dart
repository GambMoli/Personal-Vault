import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/db/database.dart';
import '../../../core/providers.dart';
import '../data/entrenamiento_repository.dart';

final entrenamientoRepositoryProvider = Provider<EntrenamientoRepository>(
  (ref) => EntrenamientoRepository(ref.watch(databaseProvider)),
);

final historialProvider = StreamProvider<List<SesionDetalle>>(
  (ref) => ref.watch(entrenamientoRepositoryProvider).watchHistorial(),
);

final sesionProvider = StreamProvider.family<SesionDetalle?, int>(
  (ref, id) => ref.watch(entrenamientoRepositoryProvider).watchSesion(id),
);

final ejerciciosProvider = StreamProvider<List<Ejercicio>>(
  (ref) => ref.watch(entrenamientoRepositoryProvider).watchEjercicios(),
);

final ejerciciosConDatosProvider = StreamProvider<List<Ejercicio>>(
  (ref) => ref.watch(entrenamientoRepositoryProvider).watchEjerciciosConDatos(),
);

final progresoProvider = StreamProvider.family<List<PuntoProgreso>, int>(
  (ref, id) => ref.watch(entrenamientoRepositoryProvider).watchProgreso(id),
);

final ultimaVezProvider = FutureProvider.family<List<Serie>, (int, int)>(
  (ref, args) => ref
      .watch(entrenamientoRepositoryProvider)
      .ultimaVez(args.$1, antesDe: args.$2),
);
