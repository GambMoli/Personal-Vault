import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/db/database.dart';

IconData iconoLista(String icono) => switch (icono) {
  'mercado' => Icons.shopping_cart_outlined,
  _ => Icons.checklist,
};

const nombresRepeticion = {
  Repeticion.ninguna: 'No se repite',
  Repeticion.diaria: 'Cada día',
  Repeticion.semanal: 'Cada semana',
  Repeticion.mensual: 'Cada mes',
};

const nombresPrioridad = ['Normal', 'Alta', 'Urgente'];

/// "Hoy", "Mañana", "Ayer" o "mar 15 oct", con la hora si aplica.
String formatoVence(DateTime vence, bool conHora, {DateTime? ahora}) {
  ahora ??= DateTime.now();
  final hoy = DateTime(ahora.year, ahora.month, ahora.day);
  final dia = DateTime(vence.year, vence.month, vence.day);
  final diferencia = dia.difference(hoy).inDays;
  final fecha = switch (diferencia) {
    0 => 'Hoy',
    1 => 'Mañana',
    -1 => 'Ayer',
    _ => DateFormat(
      dia.year == hoy.year ? 'EEE d MMM' : 'd MMM y',
      'es',
    ).format(vence),
  };
  return conHora ? '$fecha, ${DateFormat.Hm('es').format(vence)}' : fecha;
}

bool estaAtrasada(Tarea t, {DateTime? ahora}) {
  if (t.vence == null || t.completadaEn != null) return false;
  ahora ??= DateTime.now();
  if (t.conHora) return t.vence!.isBefore(ahora);
  return t.vence!.isBefore(DateTime(ahora.year, ahora.month, ahora.day));
}
