import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/db/database.dart';
import '../../../core/formato.dart';
import '../../../core/ui/hoja_formulario.dart';
import '../data/entrenamiento_repository.dart';
import '../logic/entrenamiento_providers.dart';
import 'formularios.dart';

class SesionScreen extends ConsumerWidget {
  const SesionScreen({super.key, required this.sesionId});

  final int sesionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detalle = ref.watch(sesionProvider(sesionId)).value;
    final repo = ref.read(entrenamientoRepositoryProvider);
    if (detalle == null) return Scaffold(appBar: AppBar());
    final s = detalle.sesion;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(s.titulo),
            Text(
              fechaCorta(s.fecha),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Editar',
            icon: const Icon(Icons.edit_outlined),
            onPressed: () => _editar(context, ref, s),
          ),
          IconButton(
            tooltip: 'Eliminar sesión',
            icon: const Icon(Icons.delete_outline),
            onPressed: () async {
              if (!await confirmar(context, '¿Eliminar esta sesión?')) return;
              if (context.mounted) Navigator.of(context).pop();
              await repo.eliminarSesion(s.id);
            },
          ),
        ],
      ),
      body: detalle.ejercicios.isEmpty
          ? const Vacio(
              icono: Icons.fitness_center,
              texto: 'Agrega tu primer ejercicio',
              detalle:
                  'Luego registra cada serie con sus repeticiones y kilos.',
            )
          : ListView(
              padding: const EdgeInsets.only(bottom: 88),
              children: [
                if (s.notas != null)
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(s.notas!),
                  ),
                for (final e in detalle.ejercicios)
                  _TarjetaEjercicio(sesionId: s.id, e: e),
              ],
            ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text('Ejercicio'),
        onPressed: () async {
          final ejercicioId = await elegirEjercicio(context);
          if (ejercicioId == null || !context.mounted) return;
          final anterior = await repo.ultimaVez(ejercicioId, antesDe: s.id);
          if (!context.mounted) return;
          final serie = await pedirSerie(
            context,
            titulo: 'Primera serie',
            reps: anterior.firstOrNull?.reps ?? 10,
            pesoKg: anterior.firstOrNull?.pesoKg ?? 0,
          );
          if (serie != null) {
            await repo.agregarSerie(
              s.id,
              ejercicioId,
              reps: serie.$1,
              pesoKg: serie.$2,
            );
          }
        },
      ),
    );
  }

  Future<void> _editar(BuildContext context, WidgetRef ref, Sesion s) async {
    final titulo = TextEditingController(text: s.titulo);
    final notas = TextEditingController(text: s.notas);
    var fecha = s.fecha;
    final ok = await mostrarHoja<bool>(
      context,
      StatefulBuilder(
        builder: (context, setState) => HojaFormulario(
          titulo: 'Editar sesión',
          onGuardar: () => Navigator.of(context).pop(true),
          children: [
            Campo(controller: titulo, etiqueta: 'Qué entrenaste'),
            ChipFecha(
              fecha: fecha,
              texto: fechaCorta,
              onCambio: (f) => setState(() => fecha = f ?? fecha),
            ),
            Campo(
              controller: notas,
              etiqueta: 'Notas (cómo te sentiste, cardio…)',
              lineas: 4,
            ),
          ],
        ),
      ),
    );
    if (ok == true && titulo.text.trim().isNotEmpty) {
      await ref
          .read(entrenamientoRepositoryProvider)
          .actualizarSesion(
            s.id,
            fecha: fecha,
            titulo: titulo.text,
            notas: notas.text.trim().isEmpty ? null : notas.text.trim(),
          );
    }
    titulo.dispose();
    notas.dispose();
  }
}

class _TarjetaEjercicio extends ConsumerWidget {
  const _TarjetaEjercicio({required this.sesionId, required this.e});

  final int sesionId;
  final EjercicioEnSesion e;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tema = Theme.of(context);
    final repo = ref.read(entrenamientoRepositoryProvider);
    final anterior =
        ref.watch(ultimaVezProvider((e.ejercicio.id, sesionId))).value ?? [];
    final pesoAnterior = anterior.fold<double>(
      0,
      (m, s) => s.pesoKg > m ? s.pesoKg : m,
    );

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        e.ejercicio.nombre,
                        style: tema.textTheme.titleMedium,
                      ),
                      if (e.ejercicio.maquina != null)
                        Text(
                          e.ejercicio.maquina!,
                          style: tema.textTheme.bodySmall,
                        ),
                      if (anterior.isNotEmpty)
                        Text(
                          'Última vez: ${resumenSeries(anterior)}'
                          '${e.pesoMax > pesoAnterior && pesoAnterior > 0 ? '  ▲ subiste' : ''}',
                          style: tema.textTheme.bodySmall?.copyWith(
                            color: tema.colorScheme.primary,
                          ),
                        ),
                    ],
                  ),
                ),
                PopupMenuButton<String>(
                  onSelected: (_) =>
                      repo.quitarEjercicio(sesionId, e.ejercicio.id),
                  itemBuilder: (_) => const [
                    PopupMenuItem(
                      value: 'quitar',
                      child: Text('Quitar de la sesión'),
                    ),
                  ],
                ),
              ],
            ),
            for (final (i, serie) in e.series.indexed)
              Dismissible(
                key: ValueKey('serie-${serie.id}'),
                direction: DismissDirection.endToStart,
                onDismissed: (_) => repo.eliminarSerie(serie.id),
                background: Container(
                  color: tema.colorScheme.errorContainer,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 16),
                  child: const Icon(Icons.delete_outline),
                ),
                child: ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(radius: 14, child: Text('${i + 1}')),
                  title: Text(
                    serie.pesoKg > 0
                        ? '${serie.reps} reps × ${numero(serie.pesoKg)} kg'
                        : '${serie.reps} reps',
                    style: tema.textTheme.bodyLarge,
                  ),
                  onTap: () async {
                    final r = await pedirSerie(
                      context,
                      titulo: 'Serie ${i + 1}',
                      reps: serie.reps,
                      pesoKg: serie.pesoKg,
                    );
                    if (r != null) {
                      await repo.actualizarSerie(
                        serie.id,
                        reps: r.$1,
                        pesoKg: r.$2,
                      );
                    }
                  },
                ),
              ),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('Serie'),
                onPressed: () async {
                  final ultima = e.series.lastOrNull;
                  final r = await pedirSerie(
                    context,
                    titulo: 'Serie ${e.series.length + 1}',
                    reps: ultima?.reps ?? 10,
                    pesoKg: ultima?.pesoKg ?? 0,
                  );
                  if (r != null) {
                    await repo.agregarSerie(
                      sesionId,
                      e.ejercicio.id,
                      reps: r.$1,
                      pesoKg: r.$2,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
