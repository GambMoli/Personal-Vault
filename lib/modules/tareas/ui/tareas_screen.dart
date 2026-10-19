import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/db/database.dart';
import '../logic/tareas_providers.dart';
import 'formato.dart';
import 'lista_screen.dart';
import 'tarea_form.dart';
import 'tarea_tile.dart';

class TareasScreen extends ConsumerWidget {
  const TareasScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 2,
      child: Builder(
        builder: (context) {
          final tabs = DefaultTabController.of(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text('Tareas'),
              bottom: const TabBar(
                tabs: [
                  Tab(text: 'Hoy'),
                  Tab(text: 'Listas'),
                ],
              ),
            ),
            body: const TabBarView(children: [_HoyTab(), _ListasTab()]),
            floatingActionButton: ListenableBuilder(
              listenable: tabs,
              builder: (context, _) => tabs.index == 0
                  ? FloatingActionButton(
                      tooltip: 'Nueva tarea',
                      onPressed: () => _nuevaTareaHoy(context, ref),
                      child: const Icon(Icons.add),
                    )
                  : FloatingActionButton.extended(
                      onPressed: () => mostrarDialogoLista(context, ref),
                      icon: const Icon(Icons.playlist_add),
                      label: const Text('Lista'),
                    ),
            ),
          );
        },
      ),
    );
  }

  void _nuevaTareaHoy(BuildContext context, WidgetRef ref) {
    final listas = ref.read(listasProvider).value;
    final primera =
        listas?.where((l) => l.lista.tipo == TipoLista.general).firstOrNull ??
        listas?.firstOrNull;
    if (primera == null) return;
    abrirFormularioTarea(
      context,
      listaId: primera.lista.id,
      venceInicial: DateTime.now(),
    );
  }
}

class _HoyTab extends ConsumerWidget {
  const _HoyTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watch(hoyProvider)
        .when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
          data: (tareas) {
            if (tareas.isEmpty) {
              return const _Vacio(
                icono: Icons.wb_sunny_outlined,
                texto: 'Nada pendiente para hoy',
              );
            }
            return ListView(
              padding: const EdgeInsets.only(bottom: 88),
              children: [
                for (final t in tareas)
                  TareaTile(t.tarea, nombreLista: t.lista.nombre),
              ],
            );
          },
        );
  }
}

class _ListasTab extends ConsumerWidget {
  const _ListasTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watch(listasProvider)
        .when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
          data: (listas) {
            if (listas.isEmpty) {
              return const _Vacio(
                icono: Icons.checklist,
                texto: 'Crea tu primera lista',
              );
            }
            return ListView(
              padding: const EdgeInsets.only(bottom: 88),
              children: [
                for (final l in listas)
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Color(l.lista.color),
                      foregroundColor: Colors.white,
                      child: Icon(iconoLista(l.lista.icono)),
                    ),
                    title: Text(l.lista.nombre),
                    trailing: l.pendientes > 0
                        ? Badge.count(count: l.pendientes)
                        : null,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ListaScreen(listaId: l.lista.id),
                      ),
                    ),
                  ),
              ],
            );
          },
        );
  }
}

class _Vacio extends StatelessWidget {
  const _Vacio({required this.icono, required this.texto});

  final IconData icono;
  final String texto;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icono, size: 56, color: tema.colorScheme.outline),
          const SizedBox(height: 12),
          Text(texto, style: tema.textTheme.titleMedium),
        ],
      ),
    );
  }
}

/// Diálogo para crear una lista nueva o renombrar [lista].
Future<void> mostrarDialogoLista(
  BuildContext context,
  WidgetRef ref, {
  Lista? lista,
}) async {
  final nombre = TextEditingController(text: lista?.nombre);
  var tipo = lista?.tipo ?? TipoLista.general;
  final guardar = await showDialog<bool>(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        title: Text(lista == null ? 'Nueva lista' : 'Renombrar lista'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nombre,
              autofocus: true,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(labelText: 'Nombre'),
              onSubmitted: (_) => Navigator.of(context).pop(true),
            ),
            if (lista == null) ...[
              const SizedBox(height: 16),
              SegmentedButton<String>(
                segments: const [
                  ButtonSegment(
                    value: TipoLista.general,
                    icon: Icon(Icons.checklist),
                    label: Text('Tareas'),
                  ),
                  ButtonSegment(
                    value: TipoLista.mercado,
                    icon: Icon(Icons.shopping_cart_outlined),
                    label: Text('Compras'),
                  ),
                ],
                selected: {tipo},
                onSelectionChanged: (s) => setState(() => tipo = s.first),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Guardar'),
          ),
        ],
      ),
    ),
  );
  final texto = nombre.text.trim();
  nombre.dispose();
  if (guardar != true || texto.isEmpty) return;

  final repo = ref.read(tareasRepositoryProvider);
  if (lista == null) {
    await repo.crearLista(texto, tipo: tipo);
  } else {
    await repo.renombrarLista(lista.id, texto);
  }
}
