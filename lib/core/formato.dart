import 'package:intl/intl.dart';

final _miles = NumberFormat.decimalPattern('es');

/// Centavos → "$ 1.250.000" (con ",50" solo si hay centavos).
String dinero(int centavos, {bool signo = false}) {
  final negativo = centavos < 0;
  final abs = centavos.abs();
  final pesos = _miles.format(abs ~/ 100);
  final resto = abs % 100;
  final texto = resto == 0
      ? pesos
      : '$pesos,${resto.toString().padLeft(2, '0')}';
  final prefijo = negativo ? '-' : (signo && centavos > 0 ? '+' : '');
  return '$prefijo\$ $texto';
}

/// Texto escrito por el usuario → centavos. Acepta "1.250.000", "1250000",
/// "1250000,5" y "12.5". Devuelve null si no es un número válido.
int? parseDinero(String texto) {
  var t = texto.replaceAll(RegExp(r'[\s$]'), '');
  if (t.isEmpty) return null;
  if (t.contains(',')) {
    t = t.replaceAll('.', '').replaceAll(',', '.');
  } else if (RegExp(r'^\d{1,3}(\.\d{3})+$').hasMatch(t)) {
    t = t.replaceAll('.', '');
  }
  final valor = double.tryParse(t);
  if (valor == null || valor < 0) return null;
  return (valor * 100).round();
}

/// Centavos → texto editable ("1250000" o "1250000,50").
String dineroEditable(int centavos) {
  final pesos = centavos ~/ 100;
  final resto = centavos % 100;
  return resto == 0 ? '$pesos' : '$pesos,${resto.toString().padLeft(2, '0')}';
}

/// Número decimal corto: 2 → "2", 2.5 → "2,5".
String numero(double valor) {
  if (valor == valor.roundToDouble()) return valor.toInt().toString();
  return NumberFormat('0.##', 'es').format(valor);
}

double? parseNumero(String texto) =>
    double.tryParse(texto.trim().replaceAll(',', '.'));

String fechaCorta(DateTime fecha) =>
    DateFormat('EEE d MMM', 'es').format(fecha);

String mesAnio(DateTime fecha) {
  final t = DateFormat('MMMM y', 'es').format(fecha);
  return t[0].toUpperCase() + t.substring(1);
}

/// Próxima fecha (a las [hora]) en que cae el día [dia] del mes, ajustado al
/// último día en meses más cortos. Estrictamente posterior a [ahora].
DateTime proximoDiaDelMes(int dia, DateTime ahora, {int hora = 9}) {
  DateTime enMes(int anio, int mes) {
    final ultimo = DateTime(anio, mes + 1, 0).day;
    return DateTime(anio, mes, dia > ultimo ? ultimo : dia, hora);
  }

  final esteMes = enMes(ahora.year, ahora.month);
  return esteMes.isAfter(ahora) ? esteMes : enMes(ahora.year, ahora.month + 1);
}
