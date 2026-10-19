import '../../../core/db/database.dart';

/// Siguiente fecha de vencimiento de una tarea repetitiva.
///
/// Avanza desde [vence] según [repeticion] hasta caer en el futuro respecto a
/// [ahora] (si la tarea tiene hora) o a partir de mañana (si es solo de día),
/// para que una tarea muy atrasada no quede otra vez vencida al completarla.
/// Devuelve `null` si la tarea no se repite.
DateTime? siguienteVencimiento(
  DateTime vence,
  String repeticion, {
  required bool conHora,
  required DateTime ahora,
}) {
  if (repeticion == Repeticion.ninguna) return null;

  final limite = conHora ? ahora : DateTime(ahora.year, ahora.month, ahora.day);
  var siguiente = _avanzar(vence, repeticion, 1);
  var pasos = 1;
  while (!siguiente.isAfter(limite)) {
    pasos++;
    siguiente = _avanzar(vence, repeticion, pasos);
  }
  return siguiente;
}

DateTime _avanzar(DateTime base, String repeticion, int pasos) {
  switch (repeticion) {
    case Repeticion.diaria:
      return _conFecha(base, base.year, base.month, base.day + pasos);
    case Repeticion.semanal:
      return _conFecha(base, base.year, base.month, base.day + 7 * pasos);
    case Repeticion.mensual:
      final mesesTotales = base.month - 1 + pasos;
      final anio = base.year + mesesTotales ~/ 12;
      final mes = mesesTotales % 12 + 1;
      // Un día 31 en un mes de 30 días cae en el último día del mes.
      final ultimoDia = DateTime(anio, mes + 1, 0).day;
      final dia = base.day > ultimoDia ? ultimoDia : base.day;
      return _conFecha(base, anio, mes, dia);
    default:
      throw ArgumentError.value(repeticion, 'repeticion');
  }
}

DateTime _conFecha(DateTime base, int anio, int mes, int dia) =>
    DateTime(anio, mes, dia, base.hour, base.minute);
