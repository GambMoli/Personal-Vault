import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/db/database.dart';
import '../../../core/providers.dart';
import '../data/tareas_repository.dart';

final tareasRepositoryProvider = Provider<TareasRepository>(
  (ref) => TareasRepository(
    ref.watch(databaseProvider),
    ref.watch(notificationServiceProvider),
  ),
);

final listasProvider = StreamProvider<List<ListaConPendientes>>(
  (ref) => ref.watch(tareasRepositoryProvider).watchListas(),
);

final listaProvider = StreamProvider.family<Lista, int>(
  (ref, id) => ref.watch(tareasRepositoryProvider).watchLista(id),
);

final tareasDeListaProvider = StreamProvider.family<List<Tarea>, int>(
  (ref, listaId) =>
      ref.watch(tareasRepositoryProvider).watchTareasDeLista(listaId),
);

final hoyProvider = StreamProvider<List<TareaConLista>>(
  (ref) => ref.watch(tareasRepositoryProvider).watchHoy(DateTime.now()),
);
