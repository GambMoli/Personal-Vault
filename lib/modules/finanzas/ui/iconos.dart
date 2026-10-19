import 'package:flutter/material.dart';

import '../../../core/db/database.dart';

IconData iconoCategoria(String? icono) => switch (icono) {
  'mercado' => Icons.shopping_basket_outlined,
  'comida' => Icons.restaurant_outlined,
  'transporte' => Icons.directions_bus_outlined,
  'casa' => Icons.home_outlined,
  'servicios' => Icons.bolt_outlined,
  'suscripciones' => Icons.subscriptions_outlined,
  'salud' => Icons.local_hospital_outlined,
  'gimnasio' => Icons.fitness_center_outlined,
  'entretenimiento' => Icons.movie_outlined,
  'ropa' => Icons.checkroom_outlined,
  'educacion' => Icons.school_outlined,
  'salario' => Icons.work_outline,
  'freelance' => Icons.laptop_mac_outlined,
  _ => Icons.label_outline,
};

IconData iconoCuenta(String tipo) => switch (tipo) {
  TipoCuenta.efectivo => Icons.payments_outlined,
  TipoCuenta.digital => Icons.phone_android_outlined,
  TipoCuenta.inversion => Icons.trending_up,
  TipoCuenta.corriente => Icons.account_balance_outlined,
  _ => Icons.savings_outlined,
};

const nombresTipoCuenta = {
  TipoCuenta.ahorros: 'Ahorros',
  TipoCuenta.corriente: 'Corriente',
  TipoCuenta.digital: 'Billetera digital',
  TipoCuenta.efectivo: 'Efectivo',
  TipoCuenta.inversion: 'Inversión',
};

/// Avatar circular con el color e ícono de una categoría.
class AvatarCategoria extends StatelessWidget {
  const AvatarCategoria(this.categoria, {super.key, this.icono});

  final Categoria? categoria;
  final IconData? icono;

  @override
  Widget build(BuildContext context) {
    final color = Color(categoria?.color ?? 0xFF757575);
    return CircleAvatar(
      backgroundColor: color.withValues(alpha: 0.15),
      foregroundColor: color,
      child: Icon(icono ?? iconoCategoria(categoria?.icono), size: 20),
    );
  }
}
