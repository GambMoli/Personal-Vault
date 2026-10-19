import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/db/database.dart';
import '../../../core/formato.dart';
import '../../../core/ui/hoja_formulario.dart';
import '../logic/entrenamiento_providers.dart';
import 'sesion_screen.dart';

const gruposMusculares = [
  'Espalda',
  'Pecho',
  'Pierna',
  'Glúteo',
  'Hombro',
  'Bíceps',
  'Tríceps',
  'Core',
  'Cardio',
];

const titulosSugeridos = [
  'Espalda',
  'Pecho',
  'Pierna',
  'Hombro',
  'Brazos',
  'Full body',
  'Cardio',
];

const nombresEquipo = {
  Equipo.maquina: 'Máquina',
  Equipo.polea: 'Polea',
  Equipo.barra: 'Barra',
  Equipo.mancuerna: 'Mancuerna',
  Equipo.pesoCorporal: 'Peso corporal',
};

// ---------------------------------------------------------------------------
// Nueva sesión
// ---------------------------------------------------------------------------

Future<void> nuevaSesion(BuildContext context, WidgetRef ref) async {
  final repo = ref.read(entrenamientoRepositoryProvider);
  final recientes = await repo.titulosRecientes();
  if (!context.mounted) return;
  final resultado = await mostrarHoja<(DateTime, String, bool)>(
    context,
    _NuevaSesion(titulos: {...recientes, ...titulosSugeridos}.toList()),
  );
  if (resultado == null) return;
  final (fecha, titulo, repetir) = resultado;
  final anterior = repetir ? await repo.ultimaSesionCon(titulo) : null;
  final id = await repo.crearSesion(fecha, titulo, copiarDe: anterior?.id);
  if (context.mounted) {
    await Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => SesionScreen(sesionId: id)));
  }
}

class _NuevaSesion extends ConsumerStatefulWidget {
  const _NuevaSesion({required this.titulos});
  final List<String> titulos;

  @override
  ConsumerState<_NuevaSesion> createState() => _NuevaSesionState();
}

class _NuevaSesionState extends ConsumerState<_NuevaSesion> {
  final _titulo = TextEditingController();
  DateTime _fecha = DateTime.now();
  Sesion? _anterior;
  bool _repetir = true;

  Future<void> _buscarAnterior() async {
    final s = await ref
        .read(entrenamientoRepositoryProvider)
        .ultimaSesionCon(_titulo.text);
    if (mounted) setState(() => _anterior = s);
  }

  @override
  Widget build(BuildContext context) {
    return HojaFormulario(
      titulo: 'Entrenar',
      onGuardar: () {
        final t = _titulo.text.trim();
        if (t.isEmpty) return avisar(context, '¿Qué entrenas hoy?');
        Navigator.of(context).pop((_fecha, t, _repetir && _anterior != null));
      },
      children: [
        TextField(
          controller: _titulo,
          textCapitalization: TextCapitalization.sentences,
          decoration: const InputDecoration(
            labelText: '¿Qué entrenas? (ej. Espalda)',
            border: OutlineInputBorder(),
          ),
          onChanged: (_) => _buscarAnterior(),
        ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final t in widget.titulos.take(10))
              ActionChip(
                label: Text(t),
                onPressed: () {
                  _titulo.text = t;
                  _buscarAnterior();
                },
              ),
          ],
        ),
        ChipFecha(
          fecha: _fecha,
          texto: fechaCorta,
          onCambio: (f) => setState(() => _fecha = f ?? _fecha),
        ),
        if (_anterior != null)
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text('Repetir la última de ${_anterior!.titulo}'),
            subtitle: Text(
              'Del ${fechaCorta(_anterior!.fecha)}, con los mismos pesos',
            ),
            value: _repetir,
            onChanged: (v) => setState(() => _repetir = v),
          ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Serie (reps × kg)
// ---------------------------------------------------------------------------

/// Devuelve (reps, kg), o null si se cancela.
Future<(int, double)?> pedirSerie(
  BuildContext context, {
  int reps = 10,
  double pesoKg = 0,
  String? titulo,
}) {
  return showDialog<(int, double)>(
    context: context,
    builder: (_) => _DialogoSerie(reps: reps, pesoKg: pesoKg, titulo: titulo),
  );
}

class _DialogoSerie extends StatefulWidget {
  const _DialogoSerie({required this.reps, required this.pesoKg, this.titulo});
  final int reps;
  final double pesoKg;
  final String? titulo;

  @override
  State<_DialogoSerie> createState() => _DialogoSerieState();
}

class _DialogoSerieState extends State<_DialogoSerie> {
  late final _reps = TextEditingController(text: '${widget.reps}');
  late final _peso = TextEditingController(text: numero(widget.pesoKg));

  void _sumar(TextEditingController c, double delta, {bool entero = false}) {
    final v = (parseNumero(c.text) ?? 0) + delta;
    final limitado = v < 0 ? 0.0 : v;
    c.text = entero ? '${limitado.round()}' : numero(limitado);
  }

  Widget _campo(
    TextEditingController c,
    String etiqueta,
    double paso, {
    bool entero = false,
  }) {
    return Row(
      children: [
        IconButton.outlined(
          icon: const Icon(Icons.remove),
          onPressed: () => _sumar(c, -paso, entero: entero),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: TextField(
              controller: c,
              textAlign: TextAlign.center,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                labelText: etiqueta,
                border: const OutlineInputBorder(),
              ),
            ),
          ),
        ),
        IconButton.outlined(
          icon: const Icon(Icons.add),
          onPressed: () => _sumar(c, paso, entero: entero),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.titulo ?? 'Serie'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _campo(_reps, 'Repeticiones', 1, entero: true),
          const SizedBox(height: 12),
          _campo(_peso, 'Peso (kg)', 2.5),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: () {
            final reps = int.tryParse(_reps.text.trim()) ?? 0;
            final peso = parseNumero(_peso.text) ?? 0;
            if (reps <= 0) return;
            Navigator.of(context).pop((reps, peso));
          },
          child: const Text('Guardar'),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Ejercicio
// ---------------------------------------------------------------------------

Future<int?> abrirEjercicio(
  BuildContext context, {
  Ejercicio? ejercicio,
  String? nombreInicial,
}) => mostrarHoja<int>(context, _FormEjercicio(ejercicio, nombreInicial));

class _FormEjercicio extends ConsumerStatefulWidget {
  const _FormEjercicio(this.ejercicio, this.nombreInicial);
  final Ejercicio? ejercicio;
  final String? nombreInicial;

  @override
  ConsumerState<_FormEjercicio> createState() => _FormEjercicioState();
}

class _FormEjercicioState extends ConsumerState<_FormEjercicio> {
  late final e = widget.ejercicio;
  late final _nombre = TextEditingController(
    text: e?.nombre ?? widget.nombreInicial,
  );
  late final _maquina = TextEditingController(text: e?.maquina);
  late String _grupo = e?.grupo ?? gruposMusculares.first;
  late String _equipo = e?.equipo ?? Equipo.maquina;

  @override
  Widget build(BuildContext context) {
    final repo = ref.read(entrenamientoRepositoryProvider);
    return HojaFormulario(
      titulo: e == null ? 'Nuevo ejercicio' : 'Editar ejercicio',
      onGuardar: () async {
        final nombre = _nombre.text.trim();
        if (nombre.isEmpty) return avisar(context, 'Ponle un nombre');
        final id = await repo.guardarEjercicio(
          EjerciciosCompanion(
            id: e == null ? const Value.absent() : Value(e!.id),
            nombre: Value(nombre),
            grupo: Value(_grupo),
            equipo: Value(_equipo),
            maquina: Value(
              _maquina.text.trim().isEmpty ? null : _maquina.text.trim(),
            ),
          ),
        );
        if (context.mounted) Navigator.of(context).pop(id);
      },
      onEliminar: e == null
          ? null
          : () async {
              final ok = await confirmar(
                context,
                '¿Eliminar "${e!.nombre}"?',
                mensaje: 'Se borrarán también sus series del historial.',
              );
              if (!ok) return;
              await repo.eliminarEjercicio(e!.id);
              if (context.mounted) Navigator.of(context).pop();
            },
      children: [
        Campo(controller: _nombre, etiqueta: 'Nombre', autofocus: e == null),
        DropdownButtonFormField<String>(
          initialValue: gruposMusculares.contains(_grupo) ? _grupo : null,
          decoration: const InputDecoration(
            labelText: 'Grupo muscular',
            border: OutlineInputBorder(),
          ),
          items: [
            for (final g in gruposMusculares)
              DropdownMenuItem(value: g, child: Text(g)),
          ],
          onChanged: (v) => setState(() => _grupo = v ?? _grupo),
        ),
        Wrap(
          spacing: 8,
          children: [
            for (final eq in nombresEquipo.entries)
              ChoiceChip(
                label: Text(eq.value),
                selected: _equipo == eq.key,
                onSelected: (_) => setState(() => _equipo = eq.key),
              ),
          ],
        ),
        Campo(
          controller: _maquina,
          etiqueta: 'Máquina del gym (opcional, ej. "Polea alta #3")',
        ),
      ],
    );
  }
}

/// Selector de ejercicio con búsqueda. Devuelve el id elegido.
Future<int?> elegirEjercicio(BuildContext context) =>
    mostrarHoja<int>(context, const _SelectorEjercicio());

class _SelectorEjercicio extends ConsumerStatefulWidget {
  const _SelectorEjercicio();

  @override
  ConsumerState<_SelectorEjercicio> createState() => _SelectorEjercicioState();
}

class _SelectorEjercicioState extends ConsumerState<_SelectorEjercicio> {
  String _filtro = '';

  @override
  Widget build(BuildContext context) {
    final ejercicios = ref.watch(ejerciciosProvider).value ?? [];
    final f = _filtro.toLowerCase();
    final visibles = ejercicios
        .where(
          (e) =>
              f.isEmpty ||
              e.nombre.toLowerCase().contains(f) ||
              e.grupo.toLowerCase().contains(f),
        )
        .toList();

    final filas = <Widget>[];
    String? grupo;
    for (final e in visibles) {
      if (e.grupo != grupo) {
        grupo = e.grupo;
        filas.add(Seccion(grupo));
      }
      filas.add(
        ListTile(
          title: Text(e.nombre),
          subtitle: Text(
            [
              nombresEquipo[e.equipo] ?? e.equipo,
              if (e.maquina != null) e.maquina!,
            ].join(' · '),
          ),
          onTap: () => Navigator.of(context).pop(e.id),
        ),
      );
    }

    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.8,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              autofocus: true,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Buscar ejercicio o grupo',
                border: OutlineInputBorder(),
              ),
              onChanged: (v) => setState(() => _filtro = v.trim()),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.add),
            title: Text(
              _filtro.isEmpty ? 'Crear ejercicio nuevo' : 'Crear "$_filtro"',
            ),
            onTap: () async {
              final id = await abrirEjercicio(
                context,
                nombreInicial: _filtro.isEmpty ? null : _filtro,
              );
              if (id != null && context.mounted) Navigator.of(context).pop(id);
            },
          ),
          Expanded(child: ListView(children: filas)),
        ],
      ),
    );
  }
}

/// "3×12 · 50 kg" — resumen corto de las series de un ejercicio.
String resumenSeries(List<Serie> series) {
  if (series.isEmpty) return 'Sin series';
  final reps = series.map((s) => s.reps).toSet();
  final max = series.fold<double>(0, (m, s) => s.pesoKg > m ? s.pesoKg : m);
  final repsTexto = reps.length == 1
      ? '${series.length}×${reps.first}'
      : '${series.length} series';
  return max > 0 ? '$repsTexto · ${numero(max)} kg' : repsTexto;
}
