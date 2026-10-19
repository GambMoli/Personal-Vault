import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/db/database.dart';
import '../logic/tareas_providers.dart';
import 'formato.dart';

/// Abre el formulario para crear (si [tarea] es null) o editar una tarea.
Future<void> abrirFormularioTarea(
  BuildContext context, {
  required int listaId,
  Tarea? tarea,
  DateTime? venceInicial,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    useSafeArea: true,
    builder: (_) =>
        _TareaForm(listaId: listaId, tarea: tarea, venceInicial: venceInicial),
  );
}

class _TareaForm extends ConsumerStatefulWidget {
  const _TareaForm({required this.listaId, this.tarea, this.venceInicial});

  final int listaId;
  final Tarea? tarea;
  final DateTime? venceInicial;

  @override
  ConsumerState<_TareaForm> createState() => _TareaFormState();
}

class _TareaFormState extends ConsumerState<_TareaForm> {
  late final _titulo = TextEditingController(text: widget.tarea?.titulo);
  late final _notas = TextEditingController(text: widget.tarea?.notas);
  late final _cantidad = TextEditingController(text: widget.tarea?.cantidad);
  late int _listaId = widget.tarea?.listaId ?? widget.listaId;
  late DateTime? _fecha = widget.tarea?.vence ?? widget.venceInicial;
  late TimeOfDay? _hora = widget.tarea?.conHora == true
      ? TimeOfDay.fromDateTime(widget.tarea!.vence!)
      : null;
  late bool _recordar = widget.tarea?.recordar ?? true;
  late int _prioridad = widget.tarea?.prioridad ?? 0;
  late String _repeticion = widget.tarea?.repeticion ?? Repeticion.ninguna;
  bool _guardando = false;

  @override
  void dispose() {
    _titulo.dispose();
    _notas.dispose();
    _cantidad.dispose();
    super.dispose();
  }

  Future<void> _elegirFecha() async {
    final hoy = DateTime.now();
    final elegida = await showDatePicker(
      context: context,
      initialDate: _fecha ?? hoy,
      firstDate: DateTime(hoy.year - 5),
      lastDate: DateTime(hoy.year + 10),
    );
    if (elegida != null) setState(() => _fecha = elegida);
  }

  Future<void> _elegirHora() async {
    final elegida = await showTimePicker(
      context: context,
      initialTime: _hora ?? const TimeOfDay(hour: 9, minute: 0),
    );
    if (elegida != null) setState(() => _hora = elegida);
  }

  Future<void> _guardar() async {
    final titulo = _titulo.text.trim();
    if (titulo.isEmpty || _guardando) return;
    setState(() => _guardando = true);

    DateTime? vence;
    if (_fecha != null) {
      vence = DateTime(
        _fecha!.year,
        _fecha!.month,
        _fecha!.day,
        _hora?.hour ?? 0,
        _hora?.minute ?? 0,
      );
    }
    String? textoONulo(TextEditingController c) =>
        c.text.trim().isEmpty ? null : c.text.trim();

    final datos = TareasCompanion(
      id: widget.tarea == null ? const Value.absent() : Value(widget.tarea!.id),
      listaId: Value(_listaId),
      titulo: Value(titulo),
      notas: Value(textoONulo(_notas)),
      cantidad: Value(textoONulo(_cantidad)),
      vence: Value(vence),
      conHora: Value(vence != null && _hora != null),
      recordar: Value(vence != null && _hora != null && _recordar),
      prioridad: Value(_prioridad),
      repeticion: Value(vence == null ? Repeticion.ninguna : _repeticion),
    );
    await ref.read(tareasRepositoryProvider).guardarTarea(datos);
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final listas = ref.watch(listasProvider).value ?? const [];
    final lista = listas
        .where((l) => l.lista.id == _listaId)
        .firstOrNull
        ?.lista;
    final esMercado = lista?.tipo == TipoLista.mercado;

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
            Text(
              widget.tarea == null ? 'Nueva tarea' : 'Editar tarea',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _titulo,
              autofocus: widget.tarea == null,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                labelText: esMercado ? 'Producto' : 'Título',
                border: const OutlineInputBorder(),
              ),
              onSubmitted: (_) => _guardar(),
            ),
            if (esMercado) ...[
              const SizedBox(height: 12),
              TextField(
                controller: _cantidad,
                decoration: const InputDecoration(
                  labelText: 'Cantidad (ej. 2 kg, 1 docena)',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
            const SizedBox(height: 12),
            TextField(
              controller: _notas,
              minLines: 1,
              maxLines: 4,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                labelText: 'Notas',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            if (listas.isNotEmpty)
              DropdownButtonFormField<int>(
                initialValue: _listaId,
                decoration: const InputDecoration(
                  labelText: 'Lista',
                  border: OutlineInputBorder(),
                ),
                items: [
                  for (final l in listas)
                    DropdownMenuItem(
                      value: l.lista.id,
                      child: Text(l.lista.nombre),
                    ),
                ],
                onChanged: (v) => setState(() => _listaId = v ?? _listaId),
              ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                InputChip(
                  avatar: const Icon(Icons.event, size: 18),
                  label: Text(
                    _fecha == null ? 'Sin fecha' : formatoVence(_fecha!, false),
                  ),
                  onPressed: _elegirFecha,
                  onDeleted: _fecha == null
                      ? null
                      : () => setState(() {
                          _fecha = null;
                          _hora = null;
                        }),
                ),
                if (_fecha != null)
                  InputChip(
                    avatar: const Icon(Icons.schedule, size: 18),
                    label: Text(
                      _hora == null ? 'Sin hora' : _hora!.format(context),
                    ),
                    onPressed: _elegirHora,
                    onDeleted: _hora == null
                        ? null
                        : () => setState(() => _hora = null),
                  ),
              ],
            ),
            if (_fecha != null && _hora != null)
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Notificarme'),
                secondary: const Icon(Icons.notifications_active_outlined),
                value: _recordar,
                onChanged: (v) => setState(() => _recordar = v),
              ),
            if (_fecha != null) ...[
              const SizedBox(height: 4),
              DropdownButtonFormField<String>(
                initialValue: _repeticion,
                decoration: const InputDecoration(
                  labelText: 'Repetir',
                  border: OutlineInputBorder(),
                ),
                items: [
                  for (final e in nombresRepeticion.entries)
                    DropdownMenuItem(value: e.key, child: Text(e.value)),
                ],
                onChanged: (v) =>
                    setState(() => _repeticion = v ?? _repeticion),
              ),
            ],
            const SizedBox(height: 12),
            SegmentedButton<int>(
              segments: [
                for (var i = 0; i < nombresPrioridad.length; i++)
                  ButtonSegment(value: i, label: Text(nombresPrioridad[i])),
              ],
              selected: {_prioridad},
              onSelectionChanged: (s) => setState(() => _prioridad = s.first),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: _guardando ? null : _guardar,
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
