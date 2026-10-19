import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/db/database.dart';
import '../../../core/providers.dart';
import '../data/cocina_repository.dart';

final cocinaRepositoryProvider = Provider<CocinaRepository>(
  (ref) => CocinaRepository(
    ref.watch(databaseProvider),
    ref.watch(notificationServiceProvider),
  ),
);

final inventarioProvider = StreamProvider<List<EstadoProducto>>(
  (ref) => ref.watch(cocinaRepositoryProvider).watchInventario(),
);

final historialProductoProvider = StreamProvider.family<List<MovCocina>, int>(
  (ref, id) => ref.watch(cocinaRepositoryProvider).watchHistorial(id),
);
