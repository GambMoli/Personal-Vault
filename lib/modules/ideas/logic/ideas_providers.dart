import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/db/database.dart';
import '../../../core/providers.dart';
import '../data/ideas_repository.dart';
import '../data/sugerencias.dart';

final ideasRepositoryProvider = Provider<IdeasRepository>(
  (ref) => IdeasRepository(ref.watch(databaseProvider)),
);

final ideasProvider = StreamProvider<List<Idea>>(
  (ref) => ref.watch(ideasRepositoryProvider).watchIdeas(),
);

final ideaProvider = StreamProvider.family<Idea?, int>(
  (ref, id) => ref.watch(ideasRepositoryProvider).watchIdea(id),
);

/// Semilla para rotar las sugerencias por reglas.
final semillaSugerenciasProvider = NotifierProvider<SemillaNotifier, int>(
  SemillaNotifier.new,
);

class SemillaNotifier extends Notifier<int> {
  @override
  int build() => DateTime.now().day;

  void siguiente() => state++;
}

/// Sugerencias descartadas en esta sesión (títulos normalizados).
final descartadasProvider = NotifierProvider<DescartadasNotifier, Set<String>>(
  DescartadasNotifier.new,
);

class DescartadasNotifier extends Notifier<Set<String>> {
  @override
  Set<String> build() => {};

  void descartar(String titulo) => state = {...state, normalizar(titulo)};
}

final sugerenciasProvider = Provider<List<Sugerencia>>((ref) {
  final ideas = ref.watch(ideasProvider).value ?? [];
  return sugerirPorReglas(
    ideas,
    ahora: DateTime.now(),
    semilla: ref.watch(semillaSugerenciasProvider),
    descartadas: ref.watch(descartadasProvider),
  );
});
