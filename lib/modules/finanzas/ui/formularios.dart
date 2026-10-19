import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/db/database.dart';
import '../../../core/formato.dart';
import '../../../core/ui/hoja_formulario.dart';
import '../data/calculos.dart';
import '../logic/finanzas_providers.dart';
import 'iconos.dart';

const _nombresTipoMovimiento = {
  TipoMovimiento.gasto: 'Gasto',
  TipoMovimiento.ingreso: 'Ingreso',
  TipoMovimiento.transferencia: 'Transferir',
  TipoMovimiento.pagoTarjeta: 'Pagar tarjeta',
};

// ---------------------------------------------------------------------------
// Movimiento
// ---------------------------------------------------------------------------

Future<void> abrirMovimiento(BuildContext context, {Movimiento? movimiento}) =>
    mostrarHoja(context, _FormMovimiento(movimiento));

class _FormMovimiento extends ConsumerStatefulWidget {
  const _FormMovimiento(this.movimiento);
  final Movimiento? movimiento;

  @override
  ConsumerState<_FormMovimiento> createState() => _FormMovimientoState();
}

/// Origen de un gasto: una cuenta o una tarjeta ("c:3" / "t:1").
String _origen({int? cuentaId, int? tarjetaId}) => tarjetaId != null
    ? 't:$tarjetaId'
    : (cuentaId != null ? 'c:$cuentaId' : '');

class _FormMovimientoState extends ConsumerState<_FormMovimiento> {
  late final m = widget.movimiento;
  late String _tipo = m?.tipo ?? TipoMovimiento.gasto;
  late final _monto = TextEditingController(
    text: m == null ? '' : dineroEditable(m!.monto),
  );
  late final _descripcion = TextEditingController(text: m?.descripcion);
  late final _cuotas = TextEditingController(text: '${m?.cuotas ?? 1}');
  late DateTime _fecha = m?.fecha ?? DateTime.now();
  late int? _categoriaId = m?.categoriaId;
  late String _pagaCon = _origen(
    cuentaId: m?.cuentaId,
    tarjetaId: m?.tarjetaId,
  );
  late int? _cuentaId = m?.cuentaId;
  late int? _destinoId = m?.cuentaDestinoId;
  late int? _tarjetaId = m?.tarjetaId;

  @override
  void dispose() {
    _monto.dispose();
    _descripcion.dispose();
    _cuotas.dispose();
    super.dispose();
  }

  Future<void> _guardar(EstadoFinanzas estado) async {
    final monto = parseDinero(_monto.text);
    if (monto == null || monto <= 0)
      return avisar(context, 'Escribe un monto válido');

    int? cuenta;
    int? destino;
    int? tarjeta;
    switch (_tipo) {
      case TipoMovimiento.gasto:
        if (_pagaCon.startsWith('t:')) {
          tarjeta = int.parse(_pagaCon.substring(2));
        } else if (_pagaCon.startsWith('c:')) {
          cuenta = int.parse(_pagaCon.substring(2));
        }
        if (cuenta == null && tarjeta == null)
          return avisar(context, 'Elige con qué pagaste');
      case TipoMovimiento.ingreso:
        cuenta = _cuentaId;
        if (cuenta == null) return avisar(context, 'Elige la cuenta');
      case TipoMovimiento.transferencia:
        cuenta = _cuentaId;
        destino = _destinoId;
        if (cuenta == null || destino == null || cuenta == destino) {
          return avisar(context, 'Elige dos cuentas distintas');
        }
      case TipoMovimiento.pagoTarjeta:
        cuenta = _cuentaId;
        tarjeta = _tarjetaId;
        if (cuenta == null || tarjeta == null)
          return avisar(context, 'Elige cuenta y tarjeta');
    }
    final usaCategoria =
        _tipo == TipoMovimiento.gasto || _tipo == TipoMovimiento.ingreso;

    await ref
        .read(finanzasRepositoryProvider)
        .guardarMovimiento(
          MovimientosCompanion(
            id: m == null ? const Value.absent() : Value(m!.id),
            tipo: Value(_tipo),
            monto: Value(monto),
            fecha: Value(_fecha),
            descripcion: Value(
              _descripcion.text.trim().isEmpty
                  ? null
                  : _descripcion.text.trim(),
            ),
            categoriaId: Value(usaCategoria ? _categoriaId : null),
            cuentaId: Value(cuenta),
            cuentaDestinoId: Value(destino),
            tarjetaId: Value(tarjeta),
            cuotas: Value(
              tarjeta != null && _tipo == TipoMovimiento.gasto
                  ? (int.tryParse(_cuotas.text) ?? 1).clamp(1, 72)
                  : 1,
            ),
            fijoId: Value(m?.fijoId),
          ),
        );
    if (mounted) Navigator.of(context).pop();
  }

  Widget _selectorCuenta(
    String etiqueta,
    int? valor,
    List<CuentaConSaldo> cuentas,
    ValueChanged<int?> onCambio,
  ) {
    return DropdownButtonFormField<int>(
      initialValue: cuentas.any((c) => c.cuenta.id == valor) ? valor : null,
      decoration: InputDecoration(
        labelText: etiqueta,
        border: const OutlineInputBorder(),
      ),
      items: [
        for (final c in cuentas)
          DropdownMenuItem(value: c.cuenta.id, child: Text(c.cuenta.nombre)),
      ],
      onChanged: onCambio,
    );
  }

  @override
  Widget build(BuildContext context) {
    final estado = ref.watch(estadoFinanzasProvider).value;
    if (estado == null) return const SizedBox(height: 200);

    final tipoCategoria = _tipo == TipoMovimiento.ingreso
        ? TipoCategoria.ingreso
        : TipoCategoria.gasto;
    final categorias = estado.categorias
        .where((c) => c.tipo == tipoCategoria)
        .toList();
    final cuentas = estado.cuentas;

    return HojaFormulario(
      titulo: m == null ? 'Nuevo movimiento' : 'Editar movimiento',
      onGuardar: () => _guardar(estado),
      onEliminar: m == null
          ? null
          : () async {
              await ref
                  .read(finanzasRepositoryProvider)
                  .eliminarMovimiento(m!.id);
              if (context.mounted) Navigator.of(context).pop();
            },
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SegmentedButton<String>(
            showSelectedIcon: false,
            segments: [
              for (final e in _nombresTipoMovimiento.entries)
                ButtonSegment(value: e.key, label: Text(e.value)),
            ],
            selected: {_tipo},
            onSelectionChanged: (s) => setState(() {
              _tipo = s.first;
              _categoriaId = null;
            }),
          ),
        ),
        Campo(
          controller: _monto,
          etiqueta: 'Monto',
          numerico: true,
          prefijo: '\$ ',
          autofocus: m == null,
        ),
        Campo(controller: _descripcion, etiqueta: 'Descripción'),
        ChipFecha(
          fecha: _fecha,
          texto: fechaCorta,
          onCambio: (f) => setState(() => _fecha = f ?? _fecha),
        ),
        if (_tipo == TipoMovimiento.gasto) ...[
          DropdownButtonFormField<String>(
            initialValue: _pagaCon.isEmpty ? null : _pagaCon,
            decoration: const InputDecoration(
              labelText: 'Pagado con',
              border: OutlineInputBorder(),
            ),
            items: [
              for (final c in cuentas)
                DropdownMenuItem(
                  value: 'c:${c.cuenta.id}',
                  child: Text(c.cuenta.nombre),
                ),
              for (final t in estado.tarjetas)
                DropdownMenuItem(
                  value: 't:${t.tarjeta.id}',
                  child: Text('💳 ${t.tarjeta.nombre}'),
                ),
            ],
            onChanged: (v) => setState(() => _pagaCon = v ?? ''),
          ),
          if (_pagaCon.startsWith('t:'))
            Campo(
              controller: _cuotas,
              etiqueta: 'Número de cuotas',
              numerico: true,
            ),
        ],
        if (_tipo == TipoMovimiento.ingreso)
          _selectorCuenta(
            'Cuenta que recibe',
            _cuentaId,
            cuentas,
            (v) => setState(() => _cuentaId = v),
          ),
        if (_tipo == TipoMovimiento.transferencia) ...[
          _selectorCuenta(
            'Desde',
            _cuentaId,
            cuentas,
            (v) => setState(() => _cuentaId = v),
          ),
          _selectorCuenta(
            'Hacia',
            _destinoId,
            cuentas,
            (v) => setState(() => _destinoId = v),
          ),
        ],
        if (_tipo == TipoMovimiento.pagoTarjeta) ...[
          _selectorCuenta(
            'Pagar desde',
            _cuentaId,
            cuentas,
            (v) => setState(() => _cuentaId = v),
          ),
          DropdownButtonFormField<int>(
            initialValue: estado.tarjetas.any((t) => t.tarjeta.id == _tarjetaId)
                ? _tarjetaId
                : null,
            decoration: const InputDecoration(
              labelText: 'Tarjeta',
              border: OutlineInputBorder(),
            ),
            items: [
              for (final t in estado.tarjetas)
                DropdownMenuItem(
                  value: t.tarjeta.id,
                  child: Text('${t.tarjeta.nombre} (debes ${dinero(t.deuda)})'),
                ),
            ],
            onChanged: (v) => setState(() => _tarjetaId = v),
          ),
        ],
        if (_tipo == TipoMovimiento.gasto || _tipo == TipoMovimiento.ingreso)
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final c in categorias)
                ChoiceChip(
                  avatar: Icon(iconoCategoria(c.icono), size: 18),
                  label: Text(c.nombre),
                  selected: _categoriaId == c.id,
                  onSelected: (s) =>
                      setState(() => _categoriaId = s ? c.id : null),
                ),
            ],
          ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Cuenta
// ---------------------------------------------------------------------------

Future<void> abrirCuenta(BuildContext context, {CuentaConSaldo? cuenta}) =>
    mostrarHoja(context, _FormCuenta(cuenta));

class _FormCuenta extends ConsumerStatefulWidget {
  const _FormCuenta(this.actual);
  final CuentaConSaldo? actual;

  @override
  ConsumerState<_FormCuenta> createState() => _FormCuentaState();
}

class _FormCuentaState extends ConsumerState<_FormCuenta> {
  late final c = widget.actual?.cuenta;
  late final _nombre = TextEditingController(text: c?.nombre);
  late final _banco = TextEditingController(text: c?.banco);
  // Se edita el saldo actual; el saldo inicial se recalcula a partir de él.
  late final _saldo = TextEditingController(
    text: widget.actual == null ? '' : dineroEditable(widget.actual!.saldo),
  );
  late String _tipo = c?.tipo ?? TipoCuenta.ahorros;

  Future<void> _guardar() async {
    final nombre = _nombre.text.trim();
    if (nombre.isEmpty) return avisar(context, 'Ponle un nombre');
    final saldo = parseDinero(_saldo.text) ?? 0;
    final movimientosNetos = widget.actual == null
        ? 0
        : widget.actual!.saldo - c!.saldoInicial;
    await ref
        .read(finanzasRepositoryProvider)
        .guardarCuenta(
          CuentasCompanion(
            id: c == null ? const Value.absent() : Value(c!.id),
            nombre: Value(nombre),
            banco: Value(
              _banco.text.trim().isEmpty ? null : _banco.text.trim(),
            ),
            tipo: Value(_tipo),
            saldoInicial: Value(saldo - movimientosNetos),
            archivada: const Value(false),
          ),
        );
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return HojaFormulario(
      titulo: c == null ? 'Nueva cuenta' : 'Editar cuenta',
      onGuardar: _guardar,
      onEliminar: c == null
          ? null
          : () async {
              final ok = await confirmar(
                context,
                '¿Eliminar "${c!.nombre}"?',
                mensaje: 'Se borrarán también sus movimientos.',
              );
              if (!ok) return;
              await ref.read(finanzasRepositoryProvider).eliminarCuenta(c!.id);
              if (context.mounted) Navigator.of(context).pop();
            },
      children: [
        Campo(
          controller: _nombre,
          etiqueta: 'Nombre (ej. Nómina, Nequi)',
          autofocus: c == null,
        ),
        Campo(controller: _banco, etiqueta: 'Banco'),
        DropdownButtonFormField<String>(
          initialValue: _tipo,
          decoration: const InputDecoration(
            labelText: 'Tipo',
            border: OutlineInputBorder(),
          ),
          items: [
            for (final e in nombresTipoCuenta.entries)
              DropdownMenuItem(value: e.key, child: Text(e.value)),
          ],
          onChanged: (v) => setState(() => _tipo = v ?? _tipo),
        ),
        Campo(
          controller: _saldo,
          etiqueta: 'Saldo actual',
          numerico: true,
          prefijo: '\$ ',
          ayuda: c == null
              ? null
              : 'Si lo cambias, se ajusta para cuadrar con tu banco',
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Tarjeta de crédito
// ---------------------------------------------------------------------------

Future<void> abrirTarjeta(BuildContext context, {TarjetaConDeuda? tarjeta}) =>
    mostrarHoja(context, _FormTarjeta(tarjeta));

class _FormTarjeta extends ConsumerStatefulWidget {
  const _FormTarjeta(this.actual);
  final TarjetaConDeuda? actual;

  @override
  ConsumerState<_FormTarjeta> createState() => _FormTarjetaState();
}

class _FormTarjetaState extends ConsumerState<_FormTarjeta> {
  late final t = widget.actual?.tarjeta;
  late final _nombre = TextEditingController(text: t?.nombre);
  late final _banco = TextEditingController(text: t?.banco);
  late final _cupo = TextEditingController(
    text: t == null ? '' : dineroEditable(t!.cupo),
  );
  late final _deuda = TextEditingController(
    text: widget.actual == null ? '' : dineroEditable(widget.actual!.deuda),
  );
  late final _corte = TextEditingController(text: t?.diaCorte?.toString());
  late final _pago = TextEditingController(text: t?.diaPago?.toString());
  late final _tasa = TextEditingController(
    text: t?.tasaEa == null ? '' : numero(t!.tasaEa!),
  );

  int? _dia(TextEditingController c) {
    final d = int.tryParse(c.text.trim());
    return d == null || d < 1 || d > 31 ? null : d;
  }

  Future<void> _guardar() async {
    final nombre = _nombre.text.trim();
    if (nombre.isEmpty) return avisar(context, 'Ponle un nombre');
    final deuda = parseDinero(_deuda.text) ?? 0;
    final movimientosNetos = widget.actual == null
        ? 0
        : widget.actual!.deuda - t!.deudaInicial;
    await ref
        .read(finanzasRepositoryProvider)
        .guardarTarjeta(
          TarjetasCompanion(
            id: t == null ? const Value.absent() : Value(t!.id),
            nombre: Value(nombre),
            banco: Value(
              _banco.text.trim().isEmpty ? null : _banco.text.trim(),
            ),
            cupo: Value(parseDinero(_cupo.text) ?? 0),
            deudaInicial: Value(deuda - movimientosNetos),
            diaCorte: Value(_dia(_corte)),
            diaPago: Value(_dia(_pago)),
            tasaEa: Value(parseNumero(_tasa.text)),
            archivada: const Value(false),
          ),
        );
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return HojaFormulario(
      titulo: t == null ? 'Nueva tarjeta de crédito' : 'Editar tarjeta',
      onGuardar: _guardar,
      onEliminar: t == null
          ? null
          : () async {
              final ok = await confirmar(
                context,
                '¿Eliminar "${t!.nombre}"?',
                mensaje: 'Se borrarán también sus compras y pagos.',
              );
              if (!ok) return;
              await ref.read(finanzasRepositoryProvider).eliminarTarjeta(t!.id);
              if (context.mounted) Navigator.of(context).pop();
            },
      children: [
        Campo(
          controller: _nombre,
          etiqueta: 'Nombre (ej. Visa Oro)',
          autofocus: t == null,
        ),
        Campo(controller: _banco, etiqueta: 'Banco'),
        Campo(
          controller: _cupo,
          etiqueta: 'Cupo total',
          numerico: true,
          prefijo: '\$ ',
        ),
        Campo(
          controller: _deuda,
          etiqueta: 'Deuda actual',
          numerico: true,
          prefijo: '\$ ',
          ayuda: 'Lo que debes hoy según el extracto',
        ),
        Row(
          children: [
            Expanded(
              child: Campo(
                controller: _corte,
                etiqueta: 'Día de corte',
                numerico: true,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Campo(
                controller: _pago,
                etiqueta: 'Día de pago',
                numerico: true,
              ),
            ),
          ],
        ),
        Campo(controller: _tasa, etiqueta: 'Tasa E.A. (%)', numerico: true),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Gasto fijo
// ---------------------------------------------------------------------------

Future<void> abrirFijo(BuildContext context, {GastoFijo? fijo}) =>
    mostrarHoja(context, _FormFijo(fijo));

class _FormFijo extends ConsumerStatefulWidget {
  const _FormFijo(this.fijo);
  final GastoFijo? fijo;

  @override
  ConsumerState<_FormFijo> createState() => _FormFijoState();
}

class _FormFijoState extends ConsumerState<_FormFijo> {
  late final f = widget.fijo;
  late final _descripcion = TextEditingController(text: f?.descripcion);
  late final _monto = TextEditingController(
    text: f == null ? '' : dineroEditable(f!.monto),
  );
  late final _dia = TextEditingController(text: f?.dia.toString());
  late int? _categoriaId = f?.categoriaId;
  late int? _cuentaId = f?.cuentaId;
  late bool _recordar = f?.recordar ?? true;

  Future<void> _guardar() async {
    final descripcion = _descripcion.text.trim();
    final monto = parseDinero(_monto.text);
    final dia = int.tryParse(_dia.text.trim());
    if (descripcion.isEmpty ||
        monto == null ||
        monto <= 0 ||
        dia == null ||
        dia < 1 ||
        dia > 31) {
      return avisar(context, 'Completa descripción, monto y día (1–31)');
    }
    await ref
        .read(finanzasRepositoryProvider)
        .guardarFijo(
          GastosFijosCompanion(
            id: f == null ? const Value.absent() : Value(f!.id),
            descripcion: Value(descripcion),
            monto: Value(monto),
            dia: Value(dia),
            categoriaId: Value(_categoriaId),
            cuentaId: Value(_cuentaId),
            recordar: Value(_recordar),
            activo: const Value(true),
          ),
        );
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final estado = ref.watch(estadoFinanzasProvider).value;
    final categorias =
        estado?.categorias
            .where((c) => c.tipo == TipoCategoria.gasto)
            .toList() ??
        [];
    final cuentas = estado?.cuentas ?? [];
    return HojaFormulario(
      titulo: f == null ? 'Nuevo gasto fijo' : 'Editar gasto fijo',
      onGuardar: _guardar,
      onEliminar: f == null
          ? null
          : () async {
              await ref.read(finanzasRepositoryProvider).eliminarFijo(f!.id);
              if (context.mounted) Navigator.of(context).pop();
            },
      children: [
        Campo(
          controller: _descripcion,
          etiqueta: 'Descripción (ej. Arriendo, Netflix)',
          autofocus: f == null,
        ),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Campo(
                controller: _monto,
                etiqueta: 'Monto',
                numerico: true,
                prefijo: '\$ ',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Campo(
                controller: _dia,
                etiqueta: 'Día del mes',
                numerico: true,
              ),
            ),
          ],
        ),
        DropdownButtonFormField<int>(
          initialValue: categorias.any((c) => c.id == _categoriaId)
              ? _categoriaId
              : null,
          decoration: const InputDecoration(
            labelText: 'Categoría',
            border: OutlineInputBorder(),
          ),
          items: [
            for (final c in categorias)
              DropdownMenuItem(value: c.id, child: Text(c.nombre)),
          ],
          onChanged: (v) => setState(() => _categoriaId = v),
        ),
        DropdownButtonFormField<int>(
          initialValue: cuentas.any((c) => c.cuenta.id == _cuentaId)
              ? _cuentaId
              : null,
          decoration: const InputDecoration(
            labelText: 'Se paga desde',
            border: OutlineInputBorder(),
          ),
          items: [
            for (final c in cuentas)
              DropdownMenuItem(
                value: c.cuenta.id,
                child: Text(c.cuenta.nombre),
              ),
          ],
          onChanged: (v) => setState(() => _cuentaId = v),
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Recordarme ese día'),
          value: _recordar,
          onChanged: (v) => setState(() => _recordar = v),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Meta de ahorro
// ---------------------------------------------------------------------------

Future<void> abrirMeta(BuildContext context, {Meta? meta}) =>
    mostrarHoja(context, _FormMeta(meta));

class _FormMeta extends ConsumerStatefulWidget {
  const _FormMeta(this.meta);
  final Meta? meta;

  @override
  ConsumerState<_FormMeta> createState() => _FormMetaState();
}

class _FormMetaState extends ConsumerState<_FormMeta> {
  late final mt = widget.meta;
  late final _nombre = TextEditingController(text: mt?.nombre);
  late final _objetivo = TextEditingController(
    text: mt == null ? '' : dineroEditable(mt!.objetivo),
  );
  late final _ahorrado = TextEditingController(
    text: mt == null ? '' : dineroEditable(mt!.ahorrado),
  );
  late final _donde = TextEditingController(text: mt?.dondeEsta);
  late DateTime? _fecha = mt?.fechaObjetivo;

  Future<void> _guardar() async {
    final nombre = _nombre.text.trim();
    final objetivo = parseDinero(_objetivo.text);
    if (nombre.isEmpty || objetivo == null || objetivo <= 0) {
      return avisar(context, 'Completa nombre y monto objetivo');
    }
    await ref
        .read(finanzasRepositoryProvider)
        .guardarMeta(
          MetasCompanion(
            id: mt == null ? const Value.absent() : Value(mt!.id),
            nombre: Value(nombre),
            objetivo: Value(objetivo),
            ahorrado: Value(parseDinero(_ahorrado.text) ?? 0),
            fechaObjetivo: Value(_fecha),
            dondeEsta: Value(
              _donde.text.trim().isEmpty ? null : _donde.text.trim(),
            ),
          ),
        );
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return HojaFormulario(
      titulo: mt == null ? 'Nueva meta' : 'Editar meta',
      onGuardar: _guardar,
      onEliminar: mt == null
          ? null
          : () async {
              await ref.read(finanzasRepositoryProvider).eliminarMeta(mt!.id);
              if (context.mounted) Navigator.of(context).pop();
            },
      children: [
        Campo(
          controller: _nombre,
          etiqueta: 'Meta (ej. Viaje, Fondo de emergencia)',
          autofocus: mt == null,
        ),
        Campo(
          controller: _objetivo,
          etiqueta: 'Monto objetivo',
          numerico: true,
          prefijo: '\$ ',
        ),
        Campo(
          controller: _ahorrado,
          etiqueta: 'Ya ahorrado',
          numerico: true,
          prefijo: '\$ ',
        ),
        Campo(
          controller: _donde,
          etiqueta: '¿Dónde está el dinero? (banco, CDT…)',
        ),
        ChipFecha(
          fecha: _fecha,
          texto: fechaCorta,
          vacio: 'Sin fecha límite',
          permitirQuitar: true,
          onCambio: (f) => setState(() => _fecha = f),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Deuda / préstamo
// ---------------------------------------------------------------------------

Future<void> abrirDeuda(BuildContext context, {Deuda? deuda}) =>
    mostrarHoja(context, _FormDeuda(deuda));

class _FormDeuda extends ConsumerStatefulWidget {
  const _FormDeuda(this.deuda);
  final Deuda? deuda;

  @override
  ConsumerState<_FormDeuda> createState() => _FormDeudaState();
}

class _FormDeudaState extends ConsumerState<_FormDeuda> {
  late final d = widget.deuda;
  late final _persona = TextEditingController(text: d?.persona);
  late final _monto = TextEditingController(
    text: d == null ? '' : dineroEditable(d!.monto),
  );
  late final _nota = TextEditingController(text: d?.nota);
  late String _direccion = d?.direccion ?? DireccionDeuda.debo;
  late DateTime _fecha = d?.fecha ?? DateTime.now();

  Future<void> _guardar() async {
    final persona = _persona.text.trim();
    final monto = parseDinero(_monto.text);
    if (persona.isEmpty || monto == null || monto <= 0)
      return avisar(context, 'Completa persona y monto');
    await ref
        .read(finanzasRepositoryProvider)
        .guardarDeuda(
          DeudasCompanion(
            id: d == null ? const Value.absent() : Value(d!.id),
            persona: Value(persona),
            direccion: Value(_direccion),
            monto: Value(monto),
            abonado: Value(d?.abonado ?? 0),
            nota: Value(_nota.text.trim().isEmpty ? null : _nota.text.trim()),
            fecha: Value(_fecha),
          ),
        );
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return HojaFormulario(
      titulo: d == null ? 'Nueva deuda o préstamo' : 'Editar deuda',
      onGuardar: _guardar,
      onEliminar: d == null
          ? null
          : () async {
              await ref.read(finanzasRepositoryProvider).eliminarDeuda(d!.id);
              if (context.mounted) Navigator.of(context).pop();
            },
      children: [
        SegmentedButton<String>(
          segments: const [
            ButtonSegment(value: DireccionDeuda.debo, label: Text('Yo debo')),
            ButtonSegment(
              value: DireccionDeuda.meDeben,
              label: Text('Me deben'),
            ),
          ],
          selected: {_direccion},
          onSelectionChanged: (s) => setState(() => _direccion = s.first),
        ),
        Campo(
          controller: _persona,
          etiqueta: 'Persona o entidad',
          autofocus: d == null,
        ),
        Campo(
          controller: _monto,
          etiqueta: 'Monto total',
          numerico: true,
          prefijo: '\$ ',
        ),
        Campo(controller: _nota, etiqueta: 'Nota'),
        ChipFecha(
          fecha: _fecha,
          texto: fechaCorta,
          onCambio: (f) => setState(() => _fecha = f ?? _fecha),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Diálogo de monto (aportar, abonar, presupuesto)
// ---------------------------------------------------------------------------

Future<int?> pedirMonto(
  BuildContext context,
  String titulo, {
  int? inicial,
  String? ayuda,
}) async {
  final c = TextEditingController(
    text: inicial == null || inicial == 0 ? '' : dineroEditable(inicial),
  );
  final ok = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(titulo),
      content: TextField(
        controller: c,
        autofocus: true,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(prefixText: '\$ ', helperText: ayuda),
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
  final valor = parseDinero(c.text);
  c.dispose();
  return ok == true ? (valor ?? 0) : null;
}
