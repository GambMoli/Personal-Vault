import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/db/database.dart';
import '../../../core/formato.dart';
import '../../../core/ui/hoja_formulario.dart';
import '../data/sugerencias.dart';
import '../logic/ideas_providers.dart';

const nombresEstado = {
  EstadoIdea.idea: 'Idea',
  EstadoIdea.guion: 'Guion',
  EstadoIdea.grabando: 'Grabando',
  EstadoIdea.editando: 'Editando',
  EstadoIdea.publicado: 'Publicado',
};

const iconosFormato = {
  FormatoIdea.reel: Icons.movie_outlined,
  FormatoIdea.carrusel: Icons.view_carousel_outlined,
  FormatoIdea.post: Icons.image_outlined,
  FormatoIdea.historia: Icons.amp_stories_outlined,
};

/// Editor completo de una idea. Con [idea] null crea una nueva.
class IdeaScreen extends ConsumerStatefulWidget {
  const IdeaScreen({super.key, this.idea});

  final Idea? idea;

  @override
  ConsumerState<IdeaScreen> createState() => _IdeaScreenState();
}

class _IdeaScreenState extends ConsumerState<IdeaScreen> {
  late final i = widget.idea;
  late final _titulo = TextEditingController(text: i?.titulo);
  late final _descripcion = TextEditingController(text: i?.descripcion);
  late final _tags = TextEditingController(
    text: i?.tags.split(',').where((t) => t.isNotEmpty).join(', '),
  );
  late final _hook = TextEditingController(text: i?.hook);
  late final _guion = TextEditingController(text: i?.guion);
  late final _codigo = TextEditingController(text: i?.codigo);
  late final _caption = TextEditingController(text: i?.caption);
  late final _likes = TextEditingController(text: i?.likes?.toString());
  late final _guardados = TextEditingController(text: i?.guardados?.toString());
  late final _comentarios = TextEditingController(
    text: i?.comentarios?.toString(),
  );
  late final _alcance = TextEditingController(text: i?.alcance?.toString());
  late String _formato = i?.formato ?? FormatoIdea.reel;
  late String _estado = i?.estado ?? EstadoIdea.idea;
  late DateTime? _publicada = i?.publicadaEn;

  @override
  void dispose() {
    for (final c in [
      _titulo,
      _descripcion,
      _tags,
      _hook,
      _guion,
      _codigo,
      _caption,
      _likes,
      _guardados,
      _comentarios,
      _alcance,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  String? _texto(TextEditingController c) =>
      c.text.trim().isEmpty ? null : c.text.trim();
  int? _entero(TextEditingController c) =>
      int.tryParse(c.text.trim().replaceAll('.', ''));

  Future<void> _guardar() async {
    final titulo = _titulo.text.trim();
    if (titulo.isEmpty) return avisar(context, 'Ponle un título');
    await ref
        .read(ideasRepositoryProvider)
        .guardarIdea(
          IdeasCompanion(
            id: i == null ? const Value.absent() : Value(i!.id),
            titulo: Value(titulo),
            descripcion: Value(_texto(_descripcion)),
            formato: Value(_formato),
            tags: Value(separarTags(_tags.text).join(',')),
            estado: Value(_estado),
            hook: Value(_texto(_hook)),
            guion: Value(_texto(_guion)),
            codigo: Value(_texto(_codigo)),
            caption: Value(_texto(_caption)),
            publicadaEn: Value(
              _estado == EstadoIdea.publicado
                  ? (_publicada ?? DateTime.now())
                  : _publicada,
            ),
            likes: Value(_entero(_likes)),
            guardados: Value(_entero(_guardados)),
            comentarios: Value(_entero(_comentarios)),
            alcance: Value(_entero(_alcance)),
            origen: Value(i?.origen ?? OrigenIdea.manual),
            creadaEn: i == null ? const Value.absent() : Value(i!.creadaEn),
          ),
        );
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    const espacio = SizedBox(height: 12);
    return Scaffold(
      appBar: AppBar(
        title: Text(i == null ? 'Nueva idea' : 'Idea'),
        actions: [
          if (i != null)
            IconButton(
              tooltip: 'Eliminar',
              icon: const Icon(Icons.delete_outline),
              onPressed: () async {
                if (!await confirmar(context, '¿Eliminar esta idea?')) return;
                await ref.read(ideasRepositoryProvider).eliminarIdea(i!.id);
                if (context.mounted) Navigator.of(context).pop();
              },
            ),
          IconButton(
            tooltip: 'Guardar',
            icon: const Icon(Icons.check),
            onPressed: _guardar,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Campo(
            controller: _titulo,
            etiqueta: 'Título',
            autofocus: i == null,
            lineas: 2,
          ),
          espacio,
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SegmentedButton<String>(
              segments: [
                for (final f in FormatoIdea.todos)
                  ButtonSegment(
                    value: f,
                    icon: Icon(iconosFormato[f]),
                    label: Text(nombresFormato[f]!),
                  ),
              ],
              selected: {_formato},
              onSelectionChanged: (s) => setState(() => _formato = s.first),
            ),
          ),
          espacio,
          Campo(
            controller: _tags,
            etiqueta: 'Temas (separados por coma)',
            ayuda: 'ej. javascript, css, carrera dev',
          ),
          espacio,
          Text('Etapa', style: Theme.of(context).textTheme.labelLarge),
          Wrap(
            spacing: 8,
            children: [
              for (final e in EstadoIdea.todos)
                ChoiceChip(
                  label: Text(nombresEstado[e]!),
                  selected: _estado == e,
                  onSelected: (_) => setState(() => _estado = e),
                ),
            ],
          ),
          espacio,
          Campo(
            controller: _descripcion,
            etiqueta: 'Descripción / notas',
            lineas: 4,
          ),
          espacio,
          Campo(
            controller: _hook,
            etiqueta: 'Gancho (primeros 3 segundos)',
            lineas: 2,
          ),
          espacio,
          Campo(controller: _guion, etiqueta: 'Guion', lineas: 10),
          espacio,
          TextField(
            controller: _codigo,
            minLines: 3,
            maxLines: 15,
            keyboardType: TextInputType.multiline,
            style: const TextStyle(fontFamily: 'monospace'),
            decoration: const InputDecoration(
              labelText: 'Código de ejemplo',
              border: OutlineInputBorder(),
            ),
          ),
          espacio,
          Campo(
            controller: _caption,
            etiqueta: 'Caption y hashtags',
            lineas: 6,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              icon: const Icon(Icons.copy),
              label: const Text('Copiar caption'),
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: _caption.text));
                if (context.mounted) avisar(context, 'Caption copiado');
              },
            ),
          ),
          if (_estado == EstadoIdea.publicado) ...[
            const Seccion('Resultados'),
            ChipFecha(
              fecha: _publicada ?? DateTime.now(),
              texto: (f) => 'Publicado ${fechaCorta(f)}',
              onCambio: (f) => setState(() => _publicada = f ?? _publicada),
            ),
            espacio,
            Row(
              children: [
                Expanded(
                  child: Campo(
                    controller: _likes,
                    etiqueta: 'Likes',
                    numerico: true,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Campo(
                    controller: _guardados,
                    etiqueta: 'Guardados',
                    numerico: true,
                  ),
                ),
              ],
            ),
            espacio,
            Row(
              children: [
                Expanded(
                  child: Campo(
                    controller: _comentarios,
                    etiqueta: 'Comentarios',
                    numerico: true,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Campo(
                    controller: _alcance,
                    etiqueta: 'Alcance',
                    numerico: true,
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: 24),
          FilledButton(onPressed: _guardar, child: const Text('Guardar')),
        ],
      ),
    );
  }
}
