import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/db/database.dart';
import '../../../core/providers.dart';
import '../data/calculos.dart';
import '../data/finanzas_repository.dart';

final finanzasRepositoryProvider = Provider<FinanzasRepository>(
  (ref) => FinanzasRepository(
    ref.watch(databaseProvider),
    ref.watch(notificationServiceProvider),
  ),
);

final estadoFinanzasProvider = StreamProvider<EstadoFinanzas>(
  (ref) => ref.watch(finanzasRepositoryProvider).watchEstado(),
);

/// Primer día del mes que se está viendo en Movimientos.
final mesMovimientosProvider = NotifierProvider<MesNotifier, DateTime>(
  MesNotifier.new,
);

class MesNotifier extends Notifier<DateTime> {
  @override
  DateTime build() {
    final hoy = DateTime.now();
    return DateTime(hoy.year, hoy.month);
  }

  void mover(int meses) => state = DateTime(state.year, state.month + meses);
}

final movimientosDelMesProvider = StreamProvider<List<Movimiento>>((ref) {
  final mes = ref.watch(mesMovimientosProvider);
  return ref.watch(finanzasRepositoryProvider).watchMovimientosDelMes(mes);
});
