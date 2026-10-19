import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/db/database.dart';
import '../../../core/ui/hoja_formulario.dart';
import '../data/prompt_chat.dart';
import '../data/sugerencias.dart';
import '../logic/ideas_providers.dart';
import 'idea_screen.dart';

class IdeasScreen extends StatelessWidget {
  const IdeasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Code con Gabo'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Mis ideas'),
              Tab(text: 'Sugerencias'),
            ],
          ),
        ),
        body: const TabBarView(children: [_IdeasTab(), _SugerenciasTab()]),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Nueva idea',
          onPressed: () =>
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => const IdeaScreen())),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Banco de ideas y pipeline
// ---------------------------------------------------------------------------

class _IdeasTab extends ConsumerStatefulWidget {
  const _IdeasTab();

  @override
  ConsumerState<_IdeasTab> createState() => _IdeasTabState();
}

class _IdeasTabState extends ConsumerState<_IdeasTab> {
  String? _estado;

  @override
  Widget build(BuildContext context) {
    final ideas = ref.watch(ideasProvider).value ?? [];
    final visibles = _estado == null
        ? ideas
        : ideas.where((i) => i.estado == _estado).toList();

    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: Row(
            children: [
              ChoiceChip(
                label: Text('Todas (${ideas.length})'),
                selected: _estado == null,
                onSelected: (_) => setState(() => _estado = null),
              ),
              for (final e in EstadoIdea.todos)
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: ChoiceChip(
                    label: Text(
                      '${nombresEstado[e]} (${ideas.where((i) => i.estado == e).length})',
                    ),
                    selected: _estado == e,
                    onSelected: (_) => setState(() => _estado = e),
                  ),
                ),
            ],
          ),
        ),
        Expanded(
          child: visibles.isEmpty
              ? const Vacio(
                  icono: Icons.lightbulb_outline,
                  texto: 'Sin ideas aquí',
                  detalle: 'Anota una idea con el botón + o revisa la pestaña Sugerencias.',
                )
              : ListView(
                  padding: const EdgeInsets.only(bottom: 88),
                  children: [for (final i in visibles) _TarjetaIdea(i)],
                ),
        ),
      ],
    );
  }
}

class _TarjetaIdea extends ConsumerWidget {
  const _TarjetaIdea(this.idea);
  final Idea idea;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tema = Theme.of(context);
    final indice = EstadoIdea.todos.indexOf(idea.estado);
    final siguiente = indice >= 0 && indice < EstadoIdea.todos.length - 1
        ? EstadoIdea.todos[indice + 1]
        : null;
    final tags = tagsDe(idea);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: InkWell(
        onTap: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => IdeaScreen(idea: idea))),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 8, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    iconosFormato[idea.formato],
                    size: 20,
                    color: tema.colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(idea.titulo, style: tema.textTheme.titleMedium),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Expanded(
                    child: Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      children: [
                        _Etiqueta(
                          nombresEstado[idea.estado] ?? idea.estado,
                          tema.colorScheme.secondaryContainer,
                        ),
                        for (final t in tags)
                          _Etiqueta(
                            '#$t',
                            tema.colorScheme.surfaceContainerHighest,
                          ),
                        if (idea.estado == EstadoIdea.publicado &&
                            (idea.guardados ?? idea.likes) != null)
                          _Etiqueta(
                            '❤ ${idea.likes ?? 0} · 🔖 ${idea.guardados ?? 0}',
                            tema.colorScheme.tertiaryContainer,
                          ),
                      ],
                    ),
                  ),
                  if (siguiente != null)
                    TextButton(
                      onPressed: () => ref
                          .read(ideasRepositoryProvider)
                          .cambiarEstado(idea, siguiente),
                      child: Text('→ ${nombresEstado[siguiente]}'),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Etiqueta extends StatelessWidget {
  const _Etiqueta(this.texto, this.color);
  final String texto;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(texto, style: Theme.of(context).textTheme.labelSmall),
    );
  }
}

// ---------------------------------------------------------------------------
// Sugerencias
// ---------------------------------------------------------------------------

class _SugerenciasTab extends ConsumerWidget {
  const _SugerenciasTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sugerencias = ref.watch(sugerenciasProvider);
    final ideas = ref.watch(ideasProvider).value ?? [];
    final tema = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.only(bottom: 88),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Card(
            color: tema.colorScheme.primaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pídeselo a tu IA (gratis)',
                    style: tema.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    '1. Comparte el prompt con tu app de Claude, ChatGPT o Gemini.\n'
                    '2. Copia lo que te responda.\n'
                    '3. Vuelve y toca "Pegar respuesta".',
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      FilledButton.icon(
                        icon: const Icon(Icons.share),
                        label: const Text('Compartir prompt'),
                        onPressed: () => SharePlus.instance.share(
                          ShareParams(text: construirPrompt(ideas)),
                        ),
                      ),
                      OutlinedButton.icon(
                        icon: const Icon(Icons.copy),
                        label: const Text('Copiar'),
                        onPressed: () async {
                          await Clipboard.setData(
                            ClipboardData(text: construirPrompt(ideas)),
                          );
                          if (context.mounted) {
                            avisar(context, 'Prompt copiado');
                          }
                        },
                      ),
                      OutlinedButton.icon(
                        icon: const Icon(Icons.content_paste),
                        label: const Text('Pegar respuesta'),
                        onPressed: () => _pegarRespuesta(context, ref),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Seccion(
          'Basadas en tu banco de ideas',
          accion: TextButton.icon(
            icon: const Icon(Icons.refresh),
            label: const Text('Otras'),
            onPressed: () =>
                ref.read(semillaSugerenciasProvider.notifier).siguiente(),
          ),
        ),
        if (sugerencias.isEmpty)
          const ListTile(
            title: Text('No hay más sugerencias por ahora. Toca "Otras".'),
          ),
        for (final s in sugerencias)
          _TarjetaSugerencia(s, origen: OrigenIdea.reglas),
      ],
    );
  }

  Future<void> _pegarRespuesta(BuildContext context, WidgetRef ref) async {
    final portapapeles = await Clipboard.getData(Clipboard.kTextPlain);
    if (!context.mounted) return;
    final texto = TextEditingController(text: portapapeles?.text ?? '');
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Respuesta del chat'),
        content: TextField(
          controller: texto,
          minLines: 6,
          maxLines: 12,
          decoration: const InputDecoration(
            hintText: 'Título | formato | tags | gancho',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Leer ideas'),
          ),
        ],
      ),
    );
    final propuestas = parsearRespuesta(texto.text);
    texto.dispose();
    if (ok != true || !context.mounted) return;
    if (propuestas.isEmpty) {
      return avisar(
        context,
        'No encontré ideas con el formato "Título | formato | tags | gancho"',
      );
    }
    await mostrarHoja(context, _ElegirPropuestas(propuestas));
  }
}

class _TarjetaSugerencia extends ConsumerWidget {
  const _TarjetaSugerencia(this.s, {required this.origen});
  final Sugerencia s;
  final String origen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tema = Theme.of(context);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 8, 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  iconosFormato[s.formato],
                  size: 20,
                  color: tema.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(s.titulo, style: tema.textTheme.titleMedium),
                ),
              ],
            ),
            if (s.razon != null)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(s.razon!, style: tema.textTheme.bodySmall),
              ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    s.tags.map((t) => '#$t').join(' '),
                    style: tema.textTheme.labelSmall,
                  ),
                ),
                TextButton(
                  onPressed: () => ref
                      .read(descartadasProvider.notifier)
                      .descartar(s.titulo),
                  child: const Text('Descartar'),
                ),
                TextButton.icon(
                  icon: const Icon(Icons.bookmark_add_outlined),
                  label: const Text('Guardar'),
                  onPressed: () async {
                    await ref
                        .read(ideasRepositoryProvider)
                        .guardarSugerencia(s, origen: origen);
                    if (context.mounted) {
                      avisar(context, 'Guardada en tus ideas');
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ElegirPropuestas extends ConsumerStatefulWidget {
  const _ElegirPropuestas(this.propuestas);
  final List<Sugerencia> propuestas;

  @override
  ConsumerState<_ElegirPropuestas> createState() => _ElegirPropuestasState();
}

class _ElegirPropuestasState extends ConsumerState<_ElegirPropuestas> {
  late final _elegidas = {for (var i = 0; i < widget.propuestas.length; i++) i};

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.8,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              '${widget.propuestas.length} ideas encontradas',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                for (final (i, s) in widget.propuestas.indexed)
                  CheckboxListTile(
                    value: _elegidas.contains(i),
                    onChanged: (v) => setState(
                      () => v == true ? _elegidas.add(i) : _elegidas.remove(i),
                    ),
                    title: Text(s.titulo),
                    subtitle: Text(
                      [
                        nombresFormato[s.formato] ?? s.formato,
                        if (s.tags.isNotEmpty)
                          s.tags.map((t) => '#$t').join(' '),
                        if (s.hook != null) '“${s.hook}”',
                      ].join(' · '),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _elegidas.isEmpty
                    ? null
                    : () async {
                        final repo = ref.read(ideasRepositoryProvider);
                        for (final i in _elegidas.toList()..sort()) {
                          await repo.guardarSugerencia(
                            widget.propuestas[i],
                            origen: OrigenIdea.chat,
                          );
                        }
                        if (!context.mounted) return;
                        Navigator.of(context).pop();
                        avisar(context, '${_elegidas.length} ideas guardadas');
                      },
                child: Text('Guardar ${_elegidas.length}'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
