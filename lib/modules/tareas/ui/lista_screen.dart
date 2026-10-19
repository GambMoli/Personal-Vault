import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/db/database.dart';
import '../logic/tareas_providers.dart';
import 'tarea_form.dart';
import 'tarea_tile.dart';
import 'tareas_screen.dart';

enum _Accion { renombrar, limpiar, eliminar }

class ListaScreen extends ConsumerWidget {
  const ListaScreen({super.key, required this.listaId});

  final int listaId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lista = ref.watch(listaProvider(listaId)).value;
    final tareas = ref.watch(tareasDeListaProvider(listaId));

    return Scaffold(
      appBar: AppBar(
        title: Text(lista?.nombre ?? ''),
        actions: [
          if (lista != null)
            PopupMenuButton<_Accion>(
              onSelected: (a) => _accion(context, ref, lista, a),
              itemBuilder: (_) => [
                const PopupMenuItem(
                  value: _Accion.renombrar,
                  child: Text('Renombrar'),
                ),
                PopupMenuItem(
                  value: _Accion.limpiar,
                  child: Text(
                    lista.tipo == TipoLista.mercado
                        ? 'Quitar comprados'
                        : 'Quitar completadas',
                  ),
                ),
                const PopupMenuItem(
                  value: _Accion.eliminar,
                  child: Text('Eliminar lista'),
                ),
              ],
            ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: tareas.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
              data: (tareas) => _ListaTareas(tareas),
            ),
          ),
          if (lista != null) _AgregarRapido(lista),
        ],
      ),
    );
  }

  Future<void> _accion(
    BuildContext context,
    WidgetRef ref,
    Lista lista,
    _Accion accion,
  ) async {
    final repo = ref.read(tareasRepositoryProvider);
    switch (accion) {
      case _Accion.renombrar:
        await mostrarDialogoLista(context, ref, lista: lista);
      case _Accion.limpiar:
        await repo.limpiarCompletadas(lista.id);
      case _Accion.eliminar:
        final confirmar = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('¿Eliminar "${lista.nombre}"?'),
            content: const Text('Se borrarán también todas sus tareas.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancelar'),
              ),
              FilledButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Eliminar'),
              ),
            ],
          ),
        );
        if (confirmar == true && context.mounted) {
          Navigator.of(context).pop();
          await repo.eliminarLista(lista.id);
        }
    }
  }
}

class _ListaTareas extends StatelessWidget {
  const _ListaTareas(this.tareas);

  final List<Tarea> tareas;

  @override
  Widget build(BuildContext context) {
    final pendientes = tareas.where((t) => t.completadaEn == null).toList();
    final completadas = tareas.where((t) => t.completadaEn != null).toList();

    if (tareas.isEmpty) {
      return Center(
        child: Text(
          'Lista vacía',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      );
    }
    return ListView(
      children: [
        for (final t in pendientes) TareaTile(t),
        if (completadas.isNotEmpty)
          ExpansionTile(
            title: Text('Completadas (${completadas.length})'),
            children: [for (final t in completadas) TareaTile(t)],
          ),
      ],
    );
  }
}

/// Campo inferior para agregar tareas o productos sin abrir el formulario.
class _AgregarRapido extends ConsumerStatefulWidget {
  const _AgregarRapido(this.lista);

  final Lista lista;

  @override
  ConsumerState<_AgregarRapido> createState() => _AgregarRapidoState();
}

class _AgregarRapidoState extends ConsumerState<_AgregarRapido> {
  final _texto = TextEditingController();
  final _foco = FocusNode();

  @override
  void dispose() {
    _texto.dispose();
    _foco.dispose();
    super.dispose();
  }

  Future<void> _agregar() async {
    final titulo = _texto.text.trim();
    if (titulo.isEmpty) return;
    _texto.clear();
    _foco.requestFocus();
    await ref
        .read(tareasRepositoryProvider)
        .guardarTarea(
          TareasCompanion(
            listaId: Value(widget.lista.id),
            titulo: Value(titulo),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final esMercado = widget.lista.tipo == TipoLista.mercado;
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 4, 4, 8),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _texto,
                focusNode: _foco,
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  hintText: esMercado ? 'Agregar producto' : 'Agregar tarea',
                  border: const OutlineInputBorder(),
                  isDense: true,
                ),
                onSubmitted: (_) => _agregar(),
              ),
            ),
            IconButton(
              tooltip: 'Más opciones',
              icon: const Icon(Icons.tune),
              onPressed: () =>
                  abrirFormularioTarea(context, listaId: widget.lista.id),
            ),
            IconButton.filled(
              tooltip: 'Agregar',
              icon: const Icon(Icons.add),
              onPressed: _agregar,
            ),
          ],
        ),
      ),
    );
  }
}
