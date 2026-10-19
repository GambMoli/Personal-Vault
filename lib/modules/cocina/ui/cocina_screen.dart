import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/db/database.dart';
import '../../../core/formato.dart';
import '../../../core/ui/hoja_formulario.dart';
import '../data/cocina_repository.dart';
import '../logic/cocina_providers.dart';

const _unidades = ['und', 'kg', 'g', 'L', 'ml', 'paquete'];

const _ubicaciones = {
  Ubicacion.nevera: ('Nevera', Icons.kitchen_outlined),
  Ubicacion.congelador: ('Congelador', Icons.ac_unit),
  Ubicacion.alacena: ('Alacena', Icons.inventory_2_outlined),
};

/// Cuánto se descuenta con el botón rápido de "usé".
double _pasoConsumo(Producto p) => switch (p.unidad) {
  'g' || 'ml' => 100,
  'kg' || 'L' => 0.25,
  _ => 1,
};

String _cantidad(Producto p) => '${numero(p.cantidad)} ${p.unidad}';

String? _textoDuracion(EstadoProducto e) {
  if (e.agotado) return 'Se acabó';
  final d = e.diasRestantes;
  if (d == null) return null;
  if (d < 1) return 'Se acaba hoy';
  if (d > 60) return 'Dura más de 2 meses';
  return 'Dura ~${d.round()} ${d.round() == 1 ? 'día' : 'días'}';
}

String? _textoVence(EstadoProducto e, DateTime ahora) {
  final d = e.diasParaVencer(ahora);
  if (d == null || e.agotado) return null;
  if (d < 0) return 'Venció';
  if (d == 0) return 'Vence hoy';
  if (d == 1) return 'Vence mañana';
  if (d <= 7) return 'Vence en $d días';
  return null;
}

class CocinaScreen extends ConsumerWidget {
  const CocinaScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cocina'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Despensa'),
              Tab(text: 'Por acabarse'),
            ],
          ),
        ),
        body: ref
            .watch(inventarioProvider)
            .when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
              data: (inventario) => TabBarView(
                children: [
                  _DespensaTab(inventario),
                  _PorAcabarseTab(inventario),
                ],
              ),
            ),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Nuevo producto',
          onPressed: () => abrirProducto(context),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class _DespensaTab extends StatelessWidget {
  const _DespensaTab(this.inventario);
  final List<EstadoProducto> inventario;

  @override
  Widget build(BuildContext context) {
    if (inventario.isEmpty) {
      return const Vacio(
        icono: Icons.kitchen_outlined,
        texto: 'Tu despensa está vacía',
        detalle: 'Agrega lo que tienes; cuando registres lo que usas, la app calcula cuánto te dura.',
      );
    }
    return ListView(
      padding: const EdgeInsets.only(bottom: 88),
      children: [
        for (final u in _ubicaciones.entries)
          if (inventario.any((e) => e.producto.ubicacion == u.key)) ...[
            Seccion(u.value.$1),
            for (final e in inventario.where(
              (e) => e.producto.ubicacion == u.key,
            ))
              _FilaProducto(e),
          ],
      ],
    );
  }
}

class _PorAcabarseTab extends ConsumerWidget {
  const _PorAcabarseTab(this.inventario);
  final List<EstadoProducto> inventario;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ahora = DateTime.now();
    final lista =
        inventario
            .where((e) => e.porAcabarse || (e.diasParaVencer(ahora) ?? 99) <= 3)
            .toList()
          ..sort(
            (a, b) => (a.agotado ? -1 : a.diasRestantes ?? 999).compareTo(
              b.agotado ? -1 : b.diasRestantes ?? 999,
            ),
          );
    if (lista.isEmpty) {
      return const Vacio(
        icono: Icons.check_circle_outline,
        texto: 'Nada se está acabando',
      );
    }
    return ListView(
      padding: const EdgeInsets.only(bottom: 88),
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: FilledButton.tonalIcon(
            icon: const Icon(Icons.add_shopping_cart),
            label: const Text('Agregar todo a la lista de mercado'),
            onPressed: () => _agregarAMercado(context, ref, [
              for (final e in lista) e.producto,
            ]),
          ),
        ),
        for (final e in lista) _FilaProducto(e, mostrarCarrito: true),
      ],
    );
  }
}

Future<void> _agregarAMercado(
  BuildContext context,
  WidgetRef ref,
  List<Producto> productos,
) async {
  final n = await ref.read(cocinaRepositoryProvider).agregarAMercado(productos);
  if (!context.mounted) return;
  avisar(context, switch (n) {
    null => 'Crea una lista de compras en Tareas primero',
    0 => 'Ya estaba en la lista de mercado',
    1 => 'Agregado a la lista de mercado',
    _ => '$n productos agregados a la lista de mercado',
  });
}

class _FilaProducto extends ConsumerWidget {
  const _FilaProducto(this.e, {this.mostrarCarrito = false});
  final EstadoProducto e;
  final bool mostrarCarrito;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tema = Theme.of(context);
    final p = e.producto;
    final ahora = DateTime.now();
    final duracion = _textoDuracion(e);
    final vence = _textoVence(e, ahora);
    final alerta = e.porAcabarse || vence != null;

    return ListTile(
      title: Text(p.nombre),
      subtitle: Wrap(
        spacing: 8,
        children: [
          Text(_cantidad(p)),
          if (duracion != null)
            Text(
              duracion,
              style: TextStyle(
                color: e.porAcabarse ? tema.colorScheme.error : null,
              ),
            ),
          if (vence != null)
            Text(vence, style: TextStyle(color: tema.colorScheme.error)),
        ],
      ),
      leading: Icon(
        alerta
            ? Icons.warning_amber_rounded
            : (_ubicaciones[p.ubicacion]?.$2 ?? Icons.inventory_2_outlined),
        color: alerta ? tema.colorScheme.error : null,
      ),
      trailing: mostrarCarrito
          ? IconButton(
              tooltip: 'Agregar a mercado',
              icon: const Icon(Icons.add_shopping_cart),
              onPressed: () => _agregarAMercado(context, ref, [p]),
            )
          : IconButton(
              tooltip: 'Usé ${numero(_pasoConsumo(p))} ${p.unidad}',
              icon: const Icon(Icons.remove_circle_outline),
              onPressed: p.cantidad <= 0
                  ? null
                  : () => ref
                        .read(cocinaRepositoryProvider)
                        .consumir(p, _pasoConsumo(p)),
            ),
      onTap: () => mostrarHoja(context, _DetalleProducto(p.id)),
    );
  }
}

// ---------------------------------------------------------------------------
// Detalle: usar, comprar, historial
// ---------------------------------------------------------------------------

class _DetalleProducto extends ConsumerWidget {
  const _DetalleProducto(this.productoId);
  final int productoId;

  Future<double?> _pedirCantidad(
    BuildContext context,
    String titulo,
    Producto p,
    double inicial,
  ) async {
    final c = TextEditingController(text: numero(inicial));
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(titulo),
        content: TextField(
          controller: c,
          autofocus: true,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(suffixText: p.unidad),
          onSubmitted: (_) => Navigator.of(context).pop(true),
        ),
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
    final v = parseNumero(c.text);
    c.dispose();
    return ok == true ? v : null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tema = Theme.of(context);
    final e = ref
        .watch(inventarioProvider)
        .value
        ?.where((e) => e.producto.id == productoId)
        .firstOrNull;
    if (e == null) return const SizedBox(height: 120);
    final p = e.producto;
    final repo = ref.read(cocinaRepositoryProvider);
    final historial =
        ref.watch(historialProductoProvider(productoId)).value ?? [];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(child: Text(p.nombre, style: tema.textTheme.titleLarge)),
              IconButton(
                tooltip: 'Editar',
                icon: const Icon(Icons.edit_outlined),
                onPressed: () => abrirProducto(context, producto: p),
              ),
            ],
          ),
          Text(_cantidad(p), style: tema.textTheme.headlineMedium),
          if (e.consumoDiario != null)
            Text(
              'Usas ~${numero(double.parse(e.consumoDiario!.toStringAsFixed(2)))} ${p.unidad} al día'
              '${_textoDuracion(e) == null ? '' : ' · ${_textoDuracion(e)!.toLowerCase()}'}',
            ),
          if (p.vence != null) Text('Vence el ${fechaCorta(p.vence!)}'),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: FilledButton.tonalIcon(
                  icon: const Icon(Icons.remove),
                  label: const Text('Usé'),
                  onPressed: p.cantidad <= 0
                      ? null
                      : () async {
                          final v = await _pedirCantidad(
                            context,
                            '¿Cuánto usaste?',
                            p,
                            _pasoConsumo(p),
                          );
                          if (v != null) await repo.consumir(p, v);
                        },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: FilledButton.tonalIcon(
                  icon: const Icon(Icons.add),
                  label: const Text('Compré'),
                  onPressed: () async {
                    final v = await _pedirCantidad(
                      context,
                      '¿Cuánto compraste?',
                      p,
                      p.compraHabitual,
                    );
                    if (v != null) await repo.comprar(p, v);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextButton.icon(
                  icon: const Icon(Icons.delete_sweep_outlined),
                  label: const Text('Se dañó'),
                  onPressed: p.cantidad <= 0
                      ? null
                      : () async {
                          final v = await _pedirCantidad(
                            context,
                            '¿Cuánto botaste?',
                            p,
                            p.cantidad,
                          );
                          if (v != null) {
                            await repo.consumir(
                              p,
                              v,
                              tipo: TipoMovCocina.desecho,
                            );
                          }
                        },
                ),
              ),
              Expanded(
                child: TextButton.icon(
                  icon: const Icon(Icons.add_shopping_cart),
                  label: const Text('A mercado'),
                  onPressed: () => _agregarAMercado(context, ref, [p]),
                ),
              ),
            ],
          ),
          if (historial.isNotEmpty) ...[
            const Seccion('Últimos movimientos'),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.sizeOf(context).height * 0.3,
              ),
              child: ListView(
                shrinkWrap: true,
                children: [
                  for (final m in historial)
                    ListTile(
                      dense: true,
                      leading: Icon(switch (m.tipo) {
                        TipoMovCocina.compra => Icons.add_circle_outline,
                        TipoMovCocina.desecho => Icons.delete_outline,
                        _ => Icons.remove_circle_outline,
                      }),
                      title: Text(
                        '${switch (m.tipo) {
                          TipoMovCocina.compra => 'Compra',
                          TipoMovCocina.desecho => 'Desecho',
                          _ => 'Uso',
                        }}: ${numero(m.cantidad)} ${p.unidad}',
                      ),
                      trailing: Text(fechaCorta(m.fecha)),
                    ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Formulario de producto
// ---------------------------------------------------------------------------

Future<void> abrirProducto(BuildContext context, {Producto? producto}) =>
    mostrarHoja(context, _FormProducto(producto));

class _FormProducto extends ConsumerStatefulWidget {
  const _FormProducto(this.producto);
  final Producto? producto;

  @override
  ConsumerState<_FormProducto> createState() => _FormProductoState();
}

class _FormProductoState extends ConsumerState<_FormProducto> {
  late final p = widget.producto;
  late final _nombre = TextEditingController(text: p?.nombre);
  late final _cantidad = TextEditingController(
    text: p == null ? '' : numero(p!.cantidad),
  );
  late final _minimo = TextEditingController(
    text: p == null || p!.stockMinimo == 0 ? '' : numero(p!.stockMinimo),
  );
  late final _habitual = TextEditingController(
    text: p == null ? '1' : numero(p!.compraHabitual),
  );
  late String _unidad = p?.unidad ?? 'und';
  late String _ubicacion = p?.ubicacion ?? Ubicacion.alacena;
  late DateTime? _vence = p?.vence;

  Future<void> _guardar() async {
    final nombre = _nombre.text.trim();
    if (nombre.isEmpty) return avisar(context, 'Ponle un nombre');
    await ref
        .read(cocinaRepositoryProvider)
        .guardarProducto(
          ProductosCompanion(
            id: p == null ? const Value.absent() : Value(p!.id),
            nombre: Value(nombre),
            unidad: Value(_unidad),
            ubicacion: Value(_ubicacion),
            cantidad: Value(parseNumero(_cantidad.text) ?? 0),
            stockMinimo: Value(parseNumero(_minimo.text) ?? 0),
            compraHabitual: Value(parseNumero(_habitual.text) ?? 1),
            vence: Value(_vence),
          ),
        );
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return HojaFormulario(
      titulo: p == null ? 'Nuevo producto' : 'Editar producto',
      onGuardar: _guardar,
      onEliminar: p == null
          ? null
          : () async {
              if (!await confirmar(context, '¿Eliminar "${p!.nombre}"?')) {
                return;
              }
              await ref.read(cocinaRepositoryProvider).eliminarProducto(p!.id);
              if (context.mounted) {
                Navigator.of(context).popUntil((r) => r.isFirst);
              }
            },
      children: [
        Campo(
          controller: _nombre,
          etiqueta: 'Producto (ej. Arroz, Huevos)',
          autofocus: p == null,
        ),
        Row(
          children: [
            Expanded(
              child: Campo(
                controller: _cantidad,
                etiqueta: p == null ? 'Cuánto tienes' : 'Cantidad actual',
                numerico: true,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: DropdownButtonFormField<String>(
                initialValue: _unidades.contains(_unidad)
                    ? _unidad
                    : _unidades.first,
                decoration: const InputDecoration(
                  labelText: 'Unidad',
                  border: OutlineInputBorder(),
                ),
                items: [
                  for (final u in _unidades)
                    DropdownMenuItem(value: u, child: Text(u)),
                ],
                onChanged: (v) => setState(() => _unidad = v ?? _unidad),
              ),
            ),
          ],
        ),
        SegmentedButton<String>(
          segments: [
            for (final u in _ubicaciones.entries)
              ButtonSegment(
                value: u.key,
                label: Text(u.value.$1),
                icon: Icon(u.value.$2),
              ),
          ],
          selected: {_ubicacion},
          onSelectionChanged: (s) => setState(() => _ubicacion = s.first),
        ),
        Row(
          children: [
            Expanded(
              child: Campo(
                controller: _habitual,
                etiqueta: 'Compras de a',
                numerico: true,
                ayuda: 'Se suma al marcarlo comprado',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Campo(
                controller: _minimo,
                etiqueta: 'Avisar bajo',
                numerico: true,
                ayuda: 'Stock mínimo',
              ),
            ),
          ],
        ),
        ChipFecha(
          fecha: _vence,
          texto: (f) => 'Vence ${fechaCorta(f)}',
          vacio: 'Sin vencimiento',
          permitirQuitar: true,
          onCambio: (f) => setState(() => _vence = f),
        ),
      ],
    );
  }
}
