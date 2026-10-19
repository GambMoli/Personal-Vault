import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/db/database.dart';
import '../logic/tareas_providers.dart';
import 'formato.dart';
import 'tarea_form.dart';

class TareaTile extends ConsumerWidget {
  const TareaTile(this.tarea, {super.key, this.nombreLista});

  final Tarea tarea;

  /// Se muestra en vistas que mezclan listas (Hoy).
  final String? nombreLista;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tema = Theme.of(context);
    final completada = tarea.completadaEn != null;
    final atrasada = estaAtrasada(tarea);
    final repo = ref.read(tareasRepositoryProvider);

    final detalles = <Widget>[
      if (tarea.cantidad != null) Text(tarea.cantidad!),
      if (tarea.vence != null)
        Text(
          formatoVence(tarea.vence!, tarea.conHora),
          style: atrasada ? TextStyle(color: tema.colorScheme.error) : null,
        ),
      if (tarea.recordar) const Icon(Icons.notifications_none, size: 14),
      if (tarea.repeticion != Repeticion.ninguna)
        const Icon(Icons.repeat, size: 14),
      if (nombreLista != null) Text(nombreLista!),
    ];

    return Dismissible(
      key: ValueKey(tarea.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: tema.colorScheme.errorContainer,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Icon(
          Icons.delete_outline,
          color: tema.colorScheme.onErrorContainer,
        ),
      ),
      onDismissed: (_) async {
        final messenger = ScaffoldMessenger.of(context);
        await repo.eliminarTarea(tarea.id);
        messenger.showSnackBar(
          SnackBar(
            content: Text('"${tarea.titulo}" eliminada'),
            action: SnackBarAction(
              label: 'Deshacer',
              onPressed: () => repo.restaurarTarea(tarea),
            ),
          ),
        );
      },
      child: ListTile(
        leading: Checkbox(
          value: completada,
          onChanged: (_) => repo.alternarCompletada(tarea),
        ),
        title: Text(
          tarea.titulo,
          style: completada
              ? TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: tema.colorScheme.outline,
                )
              : null,
        ),
        subtitle: detalles.isEmpty
            ? null
            : DefaultTextStyle.merge(
                style: tema.textTheme.bodySmall,
                child: Wrap(
                  spacing: 8,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: detalles,
                ),
              ),
        trailing: tarea.prioridad > 0 && !completada
            ? Icon(
                Icons.flag,
                color: tarea.prioridad == 2
                    ? tema.colorScheme.error
                    : tema.colorScheme.tertiary,
              )
            : null,
        onTap: () =>
            abrirFormularioTarea(context, listaId: tarea.listaId, tarea: tarea),
      ),
    );
  }
}
