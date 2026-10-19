import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/db/database.dart';
import '../../../core/formato.dart';
import '../../../core/ui/hoja_formulario.dart';
import '../data/calculos.dart';
import '../logic/finanzas_providers.dart';
import 'formularios.dart';
import 'iconos.dart';

class FinanzasScreen extends StatelessWidget {
  const FinanzasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Finanzas'),
          bottom: const TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            tabs: [
              Tab(text: 'Resumen'),
              Tab(text: 'Movimientos'),
              Tab(text: 'Cuentas'),
              Tab(text: 'Metas y deudas'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _ResumenTab(),
            _MovimientosTab(),
            _CuentasTab(),
            _MetasTab(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Nuevo movimiento',
          onPressed: () => abrirMovimiento(context),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

/// Construye el contenido cuando el estado de finanzas está listo.
class _ConEstado extends ConsumerWidget {
  const _ConEstado(this.builder);
  final Widget Function(BuildContext, EstadoFinanzas) builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watch(estadoFinanzasProvider)
        .when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
          data: (estado) => builder(context, estado),
        );
  }
}

// ---------------------------------------------------------------------------
// Resumen
// ---------------------------------------------------------------------------

class _ResumenTab extends ConsumerWidget {
  const _ResumenTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _ConEstado((context, e) {
      final tema = Theme.of(context);
      final repo = ref.read(finanzasRepositoryProvider);
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
                    Text('Libre este mes', style: tema.textTheme.labelLarge),
                    Text(dinero(e.libre), style: tema.textTheme.headlineMedium),
                    const SizedBox(height: 8),
                    _Fila('En cuentas', dinero(e.disponible)),
                    _Fila('Gastos fijos por pagar', dinero(-e.fijosPendientes)),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: _Dato(
                    'Ingresos del mes',
                    dinero(e.ingresosMes),
                    Colors.green,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _Dato(
                    'Gastos del mes',
                    dinero(e.gastosMes),
                    tema.colorScheme.error,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Patrimonio neto', style: tema.textTheme.labelLarge),
                    Text(
                      dinero(e.patrimonio),
                      style: tema.textTheme.titleLarge,
                    ),
                    const SizedBox(height: 4),
                    if (e.deudaTarjetas > 0)
                      _Fila('Deuda en tarjetas', dinero(-e.deudaTarjetas)),
                    if (e.debo > 0) _Fila('Lo que debo', dinero(-e.debo)),
                    if (e.meDeben > 0)
                      _Fila('Lo que me deben', dinero(e.meDeben)),
                  ],
                ),
              ),
            ),
          ),
          Seccion(
            'Gastos fijos de ${mesAnio(DateTime.now()).toLowerCase()}',
            accion: IconButton(
              tooltip: 'Nuevo gasto fijo',
              icon: const Icon(Icons.add),
              onPressed: () => abrirFijo(context),
            ),
          ),
          if (e.fijos.isEmpty)
            const ListTile(
              dense: true,
              title: Text(
                'Agrega arriendo, servicios, suscripciones… para saber cuánto te queda libre.',
              ),
            ),
          for (final f in e.fijos)
            ListTile(
              leading: Icon(
                f.pagado ? Icons.check_circle : Icons.radio_button_unchecked,
                color: f.pagado ? Colors.green : null,
              ),
              title: Text(f.fijo.descripcion),
              subtitle: Text('Día ${f.fijo.dia} · ${dinero(f.fijo.monto)}'),
              trailing: f.pagado
                  ? null
                  : TextButton(
                      onPressed: () async {
                        await repo.registrarFijo(f.fijo);
                        if (context.mounted)
                          avisar(context, '${f.fijo.descripcion} registrado');
                      },
                      child: const Text('Pagado'),
                    ),
              onTap: () => abrirFijo(context, fijo: f.fijo),
            ),
          if (e.tarjetas.any((t) => t.deuda > 0)) ...[
            const Seccion('Tarjetas'),
            for (final t in e.tarjetas.where((t) => t.deuda > 0))
              ListTile(
                leading: const Icon(Icons.credit_card),
                title: Text(t.tarjeta.nombre),
                subtitle: Text(
                  t.tarjeta.diaPago == null
                      ? 'Debes ${dinero(t.deuda)}'
                      : 'Debes ${dinero(t.deuda)} · paga el ${t.tarjeta.diaPago}',
                ),
              ),
          ],
          Seccion('Gastos por categoría'),
          if (e.gastosPorCategoria.isEmpty)
            const ListTile(
              dense: true,
              title: Text('Aún no hay gastos este mes.'),
            ),
          for (final g in e.gastosPorCategoria) _BarraCategoria(g),
        ],
      );
    });
  }
}

class _Fila extends StatelessWidget {
  const _Fila(this.etiqueta, this.valor);
  final String etiqueta;
  final String valor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(etiqueta)),
        Text(valor, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }
}

class _Dato extends StatelessWidget {
  const _Dato(this.etiqueta, this.valor, this.color);
  final String etiqueta;
  final String valor;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(etiqueta, style: Theme.of(context).textTheme.labelMedium),
            FittedBox(
              child: Text(
                valor,
                style: Theme.of(context).textTheme.titleMedium
                    ?.copyWith(color: color),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BarraCategoria extends ConsumerWidget {
  const _BarraCategoria(this.g);
  final GastoCategoria g;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tema = Theme.of(context);
    final c = g.categoria;
    final presupuesto = c?.presupuesto ?? 0;
    final progreso = presupuesto > 0 ? g.gastado / presupuesto : null;
    final color = progreso == null
        ? Color(c?.color ?? 0xFF757575)
        : progreso >= 1
        ? tema.colorScheme.error
        : progreso >= 0.8
        ? Colors.orange
        : Colors.green;

    return ListTile(
      leading: AvatarCategoria(c),
      title: Row(
        children: [
          Expanded(child: Text(c?.nombre ?? 'Sin categoría')),
          Text(dinero(g.gastado)),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: progreso?.clamp(0, 1) ?? 1,
            color: color,
          ),
          if (presupuesto > 0)
            Text(
              'Presupuesto ${dinero(presupuesto)} · quedan ${dinero(presupuesto - g.gastado)}',
            ),
        ],
      ),
      onTap: c == null
          ? null
          : () async {
              final monto = await pedirMonto(
                context,
                'Presupuesto mensual: ${c.nombre}',
                inicial: presupuesto,
                ayuda: 'Deja vacío para quitarlo',
              );
              if (monto != null) {
                await ref
                    .read(finanzasRepositoryProvider)
                    .fijarPresupuesto(c.id, monto);
              }
            },
    );
  }
}

// ---------------------------------------------------------------------------
// Movimientos
// ---------------------------------------------------------------------------

class _MovimientosTab extends ConsumerWidget {
  const _MovimientosTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mes = ref.watch(mesMovimientosProvider);
    final movimientos = ref.watch(movimientosDelMesProvider);
    final estado = ref.watch(estadoFinanzasProvider).value;

    return Column(
      children: [
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: () =>
                  ref.read(mesMovimientosProvider.notifier).mover(-1),
            ),
            Expanded(child: Text(mesAnio(mes), textAlign: TextAlign.center)),
            IconButton(
              icon: const Icon(Icons.chevron_right),
              onPressed: () =>
                  ref.read(mesMovimientosProvider.notifier).mover(1),
            ),
          ],
        ),
        Expanded(
          child: movimientos.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Error: $e')),
            data: (lista) {
              if (lista.isEmpty || estado == null) {
                return const Vacio(
                  icono: Icons.receipt_long_outlined,
                  texto: 'Sin movimientos este mes',
                );
              }
              final filas = <Widget>[];
              DateTime? dia;
              for (final m in lista) {
                final d = DateTime(m.fecha.year, m.fecha.month, m.fecha.day);
                if (d != dia) {
                  dia = d;
                  filas.add(Seccion(fechaCorta(d)));
                }
                filas.add(_FilaMovimiento(m, estado));
              }
              return ListView(
                padding: const EdgeInsets.only(bottom: 88),
                children: filas,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _FilaMovimiento extends ConsumerWidget {
  const _FilaMovimiento(this.m, this.estado);
  final Movimiento m;
  final EstadoFinanzas estado;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String cuenta(int? id) =>
        estado.cuentas
            .where((c) => c.cuenta.id == id)
            .firstOrNull
            ?.cuenta
            .nombre ??
        '—';
    String tarjeta(int? id) =>
        estado.tarjetas
            .where((t) => t.tarjeta.id == id)
            .firstOrNull
            ?.tarjeta
            .nombre ??
        '—';
    final categoria = estado.categorias
        .where((c) => c.id == m.categoriaId)
        .firstOrNull;

    final (titulo, detalle, monto, icono) = switch (m.tipo) {
      TipoMovimiento.ingreso => (
        m.descripcion ?? categoria?.nombre ?? 'Ingreso',
        cuenta(m.cuentaId),
        m.monto,
        null,
      ),
      TipoMovimiento.transferencia => (
        m.descripcion ?? 'Transferencia',
        '${cuenta(m.cuentaId)} → ${cuenta(m.cuentaDestinoId)}',
        0,
        Icons.swap_horiz,
      ),
      TipoMovimiento.pagoTarjeta => (
        m.descripcion ?? 'Pago de tarjeta',
        '${cuenta(m.cuentaId)} → ${tarjeta(m.tarjetaId)}',
        -m.monto,
        Icons.credit_score_outlined,
      ),
      _ => (
        m.descripcion ?? categoria?.nombre ?? 'Gasto',
        m.tarjetaId != null
            ? '💳 ${tarjeta(m.tarjetaId)}${m.cuotas > 1 ? ' · ${m.cuotas} cuotas' : ''}'
            : cuenta(m.cuentaId),
        -m.monto,
        null,
      ),
    };
    final tema = Theme.of(context);
    final repo = ref.read(finanzasRepositoryProvider);

    return Dismissible(
      key: ValueKey('mov-${m.id}'),
      direction: DismissDirection.endToStart,
      background: Container(
        color: tema.colorScheme.errorContainer,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: const Icon(Icons.delete_outline),
      ),
      onDismissed: (_) async {
        final messenger = ScaffoldMessenger.of(context);
        await repo.eliminarMovimiento(m.id);
        messenger.showSnackBar(
          SnackBar(
            content: const Text('Movimiento eliminado'),
            action: SnackBarAction(
              label: 'Deshacer',
              onPressed: () => repo.restaurarMovimiento(m),
            ),
          ),
        );
      },
      child: ListTile(
        leading: AvatarCategoria(categoria, icono: icono),
        title: Text(titulo),
        subtitle: Text(detalle),
        trailing: Text(
          m.tipo == TipoMovimiento.transferencia
              ? dinero(m.monto)
              : dinero(monto, signo: true),
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: monto > 0
                ? Colors.green
                : (monto < 0 ? tema.colorScheme.error : null),
          ),
        ),
        onTap: () => abrirMovimiento(context, movimiento: m),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Cuentas y tarjetas
// ---------------------------------------------------------------------------

class _CuentasTab extends StatelessWidget {
  const _CuentasTab();

  @override
  Widget build(BuildContext context) {
    return _ConEstado((context, e) {
      final tema = Theme.of(context);
      return ListView(
        padding: const EdgeInsets.only(bottom: 88),
        children: [
          Seccion(
            'Cuentas · ${dinero(e.disponible)}',
            accion: IconButton(
              tooltip: 'Nueva cuenta',
              icon: const Icon(Icons.add),
              onPressed: () => abrirCuenta(context),
            ),
          ),
          for (final c in e.cuentas)
            ListTile(
              leading: CircleAvatar(child: Icon(iconoCuenta(c.cuenta.tipo))),
              title: Text(c.cuenta.nombre),
              subtitle: Text(
                [
                  if (c.cuenta.banco != null) c.cuenta.banco!,
                  nombresTipoCuenta[c.cuenta.tipo] ?? '',
                ].join(' · '),
              ),
              trailing: Text(
                dinero(c.saldo),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: c.saldo < 0 ? tema.colorScheme.error : null,
                ),
              ),
              onTap: () => abrirCuenta(context, cuenta: c),
            ),
          Seccion(
            'Tarjetas de crédito · debes ${dinero(e.deudaTarjetas)}',
            accion: IconButton(
              tooltip: 'Nueva tarjeta',
              icon: const Icon(Icons.add),
              onPressed: () => abrirTarjeta(context),
            ),
          ),
          if (e.tarjetas.isEmpty)
            const ListTile(
              dense: true,
              title: Text('Sin tarjetas registradas.'),
            ),
          for (final t in e.tarjetas)
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.credit_card)),
              title: Text(t.tarjeta.nombre),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (t.tarjeta.cupo > 0) ...[
                    const SizedBox(height: 4),
                    LinearProgressIndicator(
                      value: (t.deuda / t.tarjeta.cupo).clamp(0, 1),
                    ),
                    Text(
                      'Disponible ${dinero(t.disponible)} de ${dinero(t.tarjeta.cupo)}',
                    ),
                  ],
                  if (t.tarjeta.diaCorte != null || t.tarjeta.diaPago != null)
                    Text(
                      [
                        if (t.tarjeta.diaCorte != null)
                          'Corte día ${t.tarjeta.diaCorte}',
                        if (t.tarjeta.diaPago != null)
                          'Pago día ${t.tarjeta.diaPago}',
                      ].join(' · '),
                    ),
                ],
              ),
              trailing: Text(
                dinero(t.deuda),
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              onTap: () => abrirTarjeta(context, tarjeta: t),
            ),
          Seccion(
            'Gastos fijos · ${dinero(e.fijos.fold(0, (s, f) => s + f.fijo.monto))}/mes',
            accion: IconButton(
              tooltip: 'Nuevo gasto fijo',
              icon: const Icon(Icons.add),
              onPressed: () => abrirFijo(context),
            ),
          ),
          for (final f in e.fijos)
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.event_repeat)),
              title: Text(f.fijo.descripcion),
              subtitle: Text('Cada día ${f.fijo.dia}'),
              trailing: Text(dinero(f.fijo.monto)),
              onTap: () => abrirFijo(context, fijo: f.fijo),
            ),
        ],
      );
    });
  }
}

// ---------------------------------------------------------------------------
// Metas y deudas
// ---------------------------------------------------------------------------

class _MetasTab extends ConsumerWidget {
  const _MetasTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.read(finanzasRepositoryProvider);
    return _ConEstado((context, e) {
      final ahora = DateTime.now();
      return ListView(
        padding: const EdgeInsets.only(bottom: 88),
        children: [
          Seccion(
            'Metas de ahorro',
            accion: IconButton(
              tooltip: 'Nueva meta',
              icon: const Icon(Icons.add),
              onPressed: () => abrirMeta(context),
            ),
          ),
          if (e.metas.isEmpty)
            const ListTile(
              dense: true,
              title: Text('Crea una meta: viaje, moto, fondo de emergencia…'),
            ),
          for (final m in e.metas)
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: InkWell(
                onTap: () => abrirMeta(context, meta: m),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              m.nombre,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          Text(
                            '${(m.ahorrado * 100 / m.objetivo).clamp(0, 100).toStringAsFixed(0)} %',
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: (m.ahorrado / m.objetivo).clamp(0, 1),
                      ),
                      const SizedBox(height: 8),
                      Text('${dinero(m.ahorrado)} de ${dinero(m.objetivo)}'),
                      if (m.dondeEsta != null) Text('En: ${m.dondeEsta}'),
                      if (m.fechaObjetivo != null && m.ahorrado < m.objetivo)
                        Text(_ritmo(m, ahora)),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton.icon(
                          icon: const Icon(Icons.add),
                          label: const Text('Aportar'),
                          onPressed: () async {
                            final monto = await pedirMonto(
                              context,
                              'Aportar a ${m.nombre}',
                            );
                            if (monto != null && monto > 0)
                              await repo.aportarMeta(m, monto);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          Seccion(
            'Deudas y préstamos',
            accion: IconButton(
              tooltip: 'Nueva deuda',
              icon: const Icon(Icons.add),
              onPressed: () => abrirDeuda(context),
            ),
          ),
          if (e.deudas.isEmpty)
            const ListTile(
              dense: true,
              title: Text('Lo que debes y lo que te deben.'),
            ),
          for (final d in e.deudas)
            ListTile(
              leading: CircleAvatar(
                child: Icon(
                  d.direccion == DireccionDeuda.debo
                      ? Icons.call_made
                      : Icons.call_received,
                ),
              ),
              title: Text(d.persona),
              subtitle: Text(
                [
                  d.direccion == DireccionDeuda.debo ? 'Le debo' : 'Me debe',
                  if (d.abonado > 0)
                    'abonado ${dinero(d.abonado)} de ${dinero(d.monto)}',
                  if (d.nota != null) d.nota!,
                ].join(' · '),
              ),
              trailing: d.abonado >= d.monto
                  ? const Icon(Icons.check_circle, color: Colors.green)
                  : TextButton(
                      child: Text(dinero(d.monto - d.abonado)),
                      onPressed: () async {
                        final monto = await pedirMonto(
                          context,
                          'Abono: ${d.persona}',
                        );
                        if (monto != null && monto > 0)
                          await repo.abonarDeuda(d, monto);
                      },
                    ),
              onTap: () => abrirDeuda(context, deuda: d),
            ),
        ],
      );
    });
  }

  /// "Ahorra $ X al mes para llegar" según los meses que faltan.
  String _ritmo(Meta m, DateTime ahora) {
    final f = m.fechaObjetivo!;
    final meses = (f.year - ahora.year) * 12 + f.month - ahora.month;
    final falta = m.objetivo - m.ahorrado;
    if (meses <= 0) return 'Fecha límite cumplida · faltan ${dinero(falta)}';
    return 'Ahorra ${dinero((falta / meses).ceil())} al mes hasta ${mesAnio(f).toLowerCase()}';
  }
}
