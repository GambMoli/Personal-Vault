import '../../../core/db/database.dart';

class CuentaConSaldo {
  const CuentaConSaldo(this.cuenta, this.saldo);
  final Cuenta cuenta;
  final int saldo;
}

class TarjetaConDeuda {
  const TarjetaConDeuda(this.tarjeta, this.deuda);
  final Tarjeta tarjeta;
  final int deuda;

  int get disponible => tarjeta.cupo - deuda;
}

class GastoCategoria {
  const GastoCategoria(this.categoria, this.gastado);
  final Categoria? categoria;
  final int gastado;
}

class FijoDelMes {
  const FijoDelMes(this.fijo, this.pagado);
  final GastoFijo fijo;
  final bool pagado;
}

/// Todo lo que muestra el resumen de Finanzas, calculado de una vez.
class EstadoFinanzas {
  const EstadoFinanzas({
    required this.cuentas,
    required this.tarjetas,
    required this.categorias,
    required this.fijos,
    required this.metas,
    required this.deudas,
    required this.ingresosMes,
    required this.gastosMes,
    required this.gastosPorCategoria,
  });

  final List<CuentaConSaldo> cuentas;
  final List<TarjetaConDeuda> tarjetas;
  final List<Categoria> categorias;
  final List<FijoDelMes> fijos;
  final List<Meta> metas;
  final List<Deuda> deudas;
  final int ingresosMes;
  final int gastosMes;
  final List<GastoCategoria> gastosPorCategoria;

  int get disponible => cuentas.fold(0, (s, c) => s + c.saldo);
  int get deudaTarjetas => tarjetas.fold(0, (s, t) => s + t.deuda);
  int get fijosPendientes =>
      fijos.where((f) => !f.pagado).fold(0, (s, f) => s + f.fijo.monto);

  /// Lo que queda después de pagar los gastos fijos que faltan este mes.
  int get libre => disponible - fijosPendientes;

  int _pendiente(String direccion) => deudas
      .where((d) => d.direccion == direccion)
      .fold(0, (s, d) => s + (d.monto - d.abonado).clamp(0, d.monto));
  int get meDeben => _pendiente(DireccionDeuda.meDeben);
  int get debo => _pendiente(DireccionDeuda.debo);

  int get patrimonio => disponible + meDeben - deudaTarjetas - debo;
}

bool mismoMes(DateTime a, DateTime b) => a.year == b.year && a.month == b.month;

EstadoFinanzas calcularEstado({
  required List<Cuenta> cuentas,
  required List<Tarjeta> tarjetas,
  required List<Categoria> categorias,
  required List<GastoFijo> fijos,
  required List<Meta> metas,
  required List<Deuda> deudas,
  required List<Movimiento> movimientos,
  required DateTime ahora,
}) {
  final saldos = {for (final c in cuentas) c.id: c.saldoInicial};
  final deudasTarjeta = {for (final t in tarjetas) t.id: t.deudaInicial};
  final porCategoria = <int?, int>{};
  final fijosPagados = <int>{};
  var ingresosMes = 0;
  var gastosMes = 0;

  void sumar(Map<int, int> mapa, int? id, int monto) {
    if (id != null && mapa.containsKey(id)) mapa[id] = mapa[id]! + monto;
  }

  for (final m in movimientos) {
    final esteMes = mismoMes(m.fecha, ahora);
    switch (m.tipo) {
      case TipoMovimiento.ingreso:
        sumar(saldos, m.cuentaId, m.monto);
        if (esteMes) ingresosMes += m.monto;
      case TipoMovimiento.gasto:
        sumar(saldos, m.cuentaId, -m.monto);
        sumar(deudasTarjeta, m.tarjetaId, m.monto);
        if (esteMes) {
          gastosMes += m.monto;
          porCategoria[m.categoriaId] =
              (porCategoria[m.categoriaId] ?? 0) + m.monto;
          if (m.fijoId != null) fijosPagados.add(m.fijoId!);
        }
      case TipoMovimiento.transferencia:
        sumar(saldos, m.cuentaId, -m.monto);
        sumar(saldos, m.cuentaDestinoId, m.monto);
      case TipoMovimiento.pagoTarjeta:
        sumar(saldos, m.cuentaId, -m.monto);
        sumar(deudasTarjeta, m.tarjetaId, -m.monto);
    }
  }

  final categoriasPorId = {for (final c in categorias) c.id: c};
  final gastosPorCategoria = [
    for (final e in porCategoria.entries)
      GastoCategoria(categoriasPorId[e.key], e.value),
  ]..sort((a, b) => b.gastado.compareTo(a.gastado));
  // Las categorías con presupuesto aparecen aunque no tengan gastos.
  for (final c in categorias) {
    if (c.presupuesto > 0 && !porCategoria.containsKey(c.id)) {
      gastosPorCategoria.add(GastoCategoria(c, 0));
    }
  }

  return EstadoFinanzas(
    cuentas: [
      for (final c in cuentas)
        if (!c.archivada) CuentaConSaldo(c, saldos[c.id]!),
    ],
    tarjetas: [
      for (final t in tarjetas)
        if (!t.archivada) TarjetaConDeuda(t, deudasTarjeta[t.id]!),
    ],
    categorias: categorias,
    fijos: [
      for (final f in fijos..sort((a, b) => a.dia.compareTo(b.dia)))
        if (f.activo) FijoDelMes(f, fijosPagados.contains(f.id)),
    ],
    metas: metas,
    deudas: deudas,
    ingresosMes: ingresosMes,
    gastosMes: gastosMes,
    gastosPorCategoria: gastosPorCategoria,
  );
}
