import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/db/database.dart';
import '../../../core/formato.dart';
import '../../../core/ui/hoja_formulario.dart';
import '../data/entrenamiento_repository.dart';
import '../logic/entrenamiento_providers.dart';
import 'formularios.dart';
import 'sesion_screen.dart';

class EntrenamientoScreen extends ConsumerWidget {
  const EntrenamientoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 3,
      child: Builder(
        builder: (context) {
          final tabs = DefaultTabController.of(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text('Entrenamiento'),
              bottom: const TabBar(
                tabs: [
                  Tab(text: 'Historial'),
                  Tab(text: 'Progreso'),
                  Tab(text: 'Ejercicios'),
                ],
              ),
            ),
            body: const TabBarView(
              children: [_HistorialTab(), _ProgresoTab(), _EjerciciosTab()],
            ),
            floatingActionButton: ListenableBuilder(
              listenable: tabs,
              builder: (context, _) => switch (tabs.index) {
                0 => FloatingActionButton.extended(
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Entrenar'),
                  onPressed: () => nuevaSesion(context, ref),
                ),
                2 => FloatingActionButton(
                  tooltip: 'Nuevo ejercicio',
                  onPressed: () => abrirEjercicio(context),
                  child: const Icon(Icons.add),
                ),
                _ => const SizedBox.shrink(),
              },
            ),
          );
        },
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Historial
// ---------------------------------------------------------------------------

class _HistorialTab extends ConsumerWidget {
  const _HistorialTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watch(historialProvider)
        .when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
          data: (sesiones) {
            if (sesiones.isEmpty) {
              return const Vacio(
                icono: Icons.fitness_center,
                texto: 'Aún no hay entrenamientos',
                detalle: 'Toca "Entrenar" para registrar el de hoy.',
              );
            }
            return ListView(
              padding: const EdgeInsets.only(bottom: 88),
              children: [
                _Constancia(sesiones),
                for (final s in sesiones) _TarjetaSesion(s),
              ],
            );
          },
        );
  }
}

class _Constancia extends StatelessWidget {
  const _Constancia(this.sesiones);
  final List<SesionDetalle> sesiones;

  @override
  Widget build(BuildContext context) {
    final hoy = DateTime.now();
    final inicioSemana = DateTime(
      hoy.year,
      hoy.month,
      hoy.day - (hoy.weekday - 1),
    );
    final dias = {
      for (final s in sesiones)
        DateTime(s.sesion.fecha.year, s.sesion.fecha.month, s.sesion.fecha.day),
    };
    final semana = dias.where((d) => !d.isBefore(inicioSemana)).length;
    final mes = dias
        .where((d) => d.year == hoy.year && d.month == hoy.month)
        .length;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        children: [
          Expanded(child: _Numero('$semana', 'días esta semana')),
          Expanded(child: _Numero('$mes', 'días este mes')),
        ],
      ),
    );
  }
}

class _Numero extends StatelessWidget {
  const _Numero(this.valor, this.etiqueta);
  final String valor;
  final String etiqueta;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    return Column(
      children: [
        Text(
          valor,
          style: tema.textTheme.headlineMedium?.copyWith(
            color: tema.colorScheme.primary,
          ),
        ),
        Text(etiqueta, style: tema.textTheme.bodySmall),
      ],
    );
  }
}

class _TarjetaSesion extends StatelessWidget {
  const _TarjetaSesion(this.d);
  final SesionDetalle d;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final dia = DateFormat("EEEE d 'de' MMMM", 'es').format(d.sesion.fecha);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => SesionScreen(sesionId: d.sesion.id),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${dia[0].toUpperCase()}${dia.substring(1)} — ${d.sesion.titulo}',
                style: tema.textTheme.titleMedium,
              ),
              const SizedBox(height: 4),
              if (d.ejercicios.isEmpty)
                Text('Sin ejercicios', style: tema.textTheme.bodySmall),
              for (final e in d.ejercicios)
                Text(
                  '${e.ejercicio.nombre}: ${resumenSeries(e.series)}',
                  style: tema.textTheme.bodyMedium,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Progreso
// ---------------------------------------------------------------------------

class _ProgresoTab extends ConsumerStatefulWidget {
  const _ProgresoTab();

  @override
  ConsumerState<_ProgresoTab> createState() => _ProgresoTabState();
}

class _ProgresoTabState extends ConsumerState<_ProgresoTab> {
  int? _ejercicioId;

  @override
  Widget build(BuildContext context) {
    final ejercicios = ref.watch(ejerciciosConDatosProvider).value ?? [];
    if (ejercicios.isEmpty) {
      return const Vacio(
        icono: Icons.show_chart,
        texto: 'Registra series para ver tu progreso',
      );
    }
    final seleccionado =
        ejercicios.where((e) => e.id == _ejercicioId).firstOrNull ??
        ejercicios.first;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        DropdownButtonFormField<int>(
          initialValue: seleccionado.id,
          decoration: const InputDecoration(
            labelText: 'Ejercicio',
            border: OutlineInputBorder(),
          ),
          items: [
            for (final e in ejercicios)
              DropdownMenuItem(value: e.id, child: Text(e.nombre)),
          ],
          onChanged: (v) => setState(() => _ejercicioId = v),
        ),
        const SizedBox(height: 16),
        ref
            .watch(progresoProvider(seleccionado.id))
            .when(
              loading: () => const SizedBox(height: 240),
              error: (e, _) => Text('Error: $e'),
              data: (puntos) => _Grafica(seleccionado, puntos),
            ),
      ],
    );
  }
}

class _Grafica extends StatelessWidget {
  const _Grafica(this.ejercicio, this.puntos);
  final Ejercicio ejercicio;
  final List<PuntoProgreso> puntos;

  @override
  Widget build(BuildContext context) {
    if (puntos.isEmpty) return const SizedBox.shrink();
    final tema = Theme.of(context);
    final record = puntos.reduce((a, b) => b.pesoMax > a.pesoMax ? b : a);
    final primero = puntos.first;
    final ultimo = puntos.last;
    final cambio = ultimo.pesoMax - primero.pesoMax;
    final formatoEje = DateFormat('d/M', 'es');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: _Numero(
                '${numero(record.pesoMax)} kg',
                'récord (${record.mejorReps} reps)',
              ),
            ),
            Expanded(
              child: _Numero('${numero(ultimo.pesoMax)} kg', 'última vez'),
            ),
            Expanded(
              child: _Numero(
                '${cambio >= 0 ? '+' : ''}${numero(cambio)} kg',
                'desde el inicio',
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        SizedBox(
          height: 240,
          child: LineChart(
            LineChartData(
              minY: 0,
              gridData: const FlGridData(drawVerticalLine: false),
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(
                topTitles: const AxisTitles(),
                rightTitles: const AxisTitles(),
                leftTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: true, reservedSize: 40),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: (puntos.length / 4).ceilToDouble().clamp(
                      1,
                      double.infinity,
                    ),
                    getTitlesWidget: (valor, meta) {
                      final i = valor.round();
                      if (i < 0 ||
                          i >= puntos.length ||
                          valor != i.toDouble()) {
                        return const SizedBox.shrink();
                      }
                      return SideTitleWidget(
                        meta: meta,
                        child: Text(
                          formatoEje.format(puntos[i].fecha),
                          style: tema.textTheme.bodySmall,
                        ),
                      );
                    },
                  ),
                ),
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: [
                    for (final (i, p) in puntos.indexed)
                      FlSpot(i.toDouble(), p.pesoMax),
                  ],
                  color: tema.colorScheme.primary,
                  barWidth: 3,
                  isCurved: puntos.length > 2,
                  preventCurveOverShooting: true,
                  dotData: const FlDotData(show: true),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Peso máximo por sesión (kg)',
          textAlign: TextAlign.center,
          style: tema.textTheme.bodySmall,
        ),
        const SizedBox(height: 16),
        for (final p in puntos.reversed)
          ListTile(
            dense: true,
            title: Text(fechaCorta(p.fecha)),
            subtitle: Text('Volumen ${numero(p.volumen)} kg'),
            trailing: Text(
              '${p.mejorReps} × ${numero(p.pesoMax)} kg',
              style: p == record
                  ? TextStyle(
                      color: tema.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    )
                  : null,
            ),
          ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Catálogo de ejercicios
// ---------------------------------------------------------------------------

class _EjerciciosTab extends ConsumerWidget {
  const _EjerciciosTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ejercicios = ref.watch(ejerciciosProvider).value ?? [];
    final filas = <Widget>[];
    String? grupo;
    for (final e in ejercicios) {
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
          onTap: () => abrirEjercicio(context, ejercicio: e),
        ),
      );
    }
    return ListView(
      padding: const EdgeInsets.only(bottom: 88),
      children: filas,
    );
  }
}
