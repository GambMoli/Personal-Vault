import 'package:flutter/material.dart';

/// Hoja inferior con título, campos y botón Guardar, usada por los formularios.
Future<T?> mostrarHoja<T>(BuildContext context, Widget hoja) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    useSafeArea: true,
    builder: (_) => hoja,
  );
}

class HojaFormulario extends StatelessWidget {
  const HojaFormulario({
    super.key,
    required this.titulo,
    required this.children,
    required this.onGuardar,
    this.onEliminar,
  });

  final String titulo;
  final List<Widget> children;
  final VoidCallback? onGuardar;
  final VoidCallback? onEliminar;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        16,
        0,
        16,
        16 + MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    titulo,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                if (onEliminar != null)
                  IconButton(
                    tooltip: 'Eliminar',
                    icon: const Icon(Icons.delete_outline),
                    onPressed: onEliminar,
                  ),
              ],
            ),
            const SizedBox(height: 12),
            for (final c in children) ...[c, const SizedBox(height: 12)],
            FilledButton(onPressed: onGuardar, child: const Text('Guardar')),
          ],
        ),
      ),
    );
  }
}

/// TextField con borde, el estilo común de los formularios.
class Campo extends StatelessWidget {
  const Campo({
    super.key,
    required this.controller,
    required this.etiqueta,
    this.numerico = false,
    this.autofocus = false,
    this.lineas = 1,
    this.ayuda,
    this.prefijo,
  });

  final TextEditingController controller;
  final String etiqueta;
  final bool numerico;
  final bool autofocus;
  final int lineas;
  final String? ayuda;
  final String? prefijo;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      autofocus: autofocus,
      minLines: 1,
      maxLines: lineas,
      keyboardType: numerico
          ? const TextInputType.numberWithOptions(decimal: true)
          : (lineas > 1 ? TextInputType.multiline : TextInputType.text),
      textCapitalization: numerico
          ? TextCapitalization.none
          : TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: etiqueta,
        helperText: ayuda,
        prefixText: prefijo,
        border: const OutlineInputBorder(),
      ),
    );
  }
}

/// Selector de fecha como chip.
class ChipFecha extends StatelessWidget {
  const ChipFecha({
    super.key,
    required this.fecha,
    required this.texto,
    required this.onCambio,
    this.vacio = 'Sin fecha',
    this.permitirQuitar = false,
  });

  final DateTime? fecha;
  final String Function(DateTime) texto;
  final ValueChanged<DateTime?> onCambio;
  final String vacio;
  final bool permitirQuitar;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: InputChip(
        avatar: const Icon(Icons.event, size: 18),
        label: Text(fecha == null ? vacio : texto(fecha!)),
        onPressed: () async {
          final hoy = DateTime.now();
          final elegida = await showDatePicker(
            context: context,
            initialDate: fecha ?? hoy,
            firstDate: DateTime(hoy.year - 10),
            lastDate: DateTime(hoy.year + 20),
          );
          if (elegida != null) onCambio(elegida);
        },
        onDeleted: permitirQuitar && fecha != null
            ? () => onCambio(null)
            : null,
      ),
    );
  }
}

Future<bool> confirmar(
  BuildContext context,
  String titulo, {
  String? mensaje,
}) async {
  final r = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(titulo),
      content: mensaje == null ? null : Text(mensaje),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Aceptar'),
        ),
      ],
    ),
  );
  return r == true;
}

void avisar(BuildContext context, String mensaje) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(mensaje)));
}

/// Título de sección dentro de listas.
class Seccion extends StatelessWidget {
  const Seccion(this.titulo, {super.key, this.accion});

  final String titulo;
  final Widget? accion;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 8, 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              titulo,
              style: Theme.of(context).textTheme.titleSmall
                  ?.copyWith(color: Theme.of(context).colorScheme.primary),
            ),
          ),
          ?accion,
        ],
      ),
    );
  }
}

class Vacio extends StatelessWidget {
  const Vacio({
    super.key,
    required this.icono,
    required this.texto,
    this.detalle,
  });

  final IconData icono;
  final String texto;
  final String? detalle;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icono, size: 56, color: tema.colorScheme.outline),
            const SizedBox(height: 12),
            Text(
              texto,
              style: tema.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            if (detalle != null) ...[
              const SizedBox(height: 4),
              Text(
                detalle!,
                style: tema.textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
