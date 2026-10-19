import 'package:drift/drift.dart';

import 'database.dart';

/// Datos iniciales de los módulos (al crear la BD o al migrar a v2).
Future<void> sembrarModulos(AppDatabase db) async {
  await db.batch((b) {
    b.insertAll(db.categorias, [
      for (final (nombre, icono, color) in _categoriasGasto)
        CategoriasCompanion.insert(
          nombre: nombre,
          tipo: TipoCategoria.gasto,
          icono: Value(icono),
          color: Value(color),
        ),
      for (final (nombre, icono, color) in _categoriasIngreso)
        CategoriasCompanion.insert(
          nombre: nombre,
          tipo: TipoCategoria.ingreso,
          icono: Value(icono),
          color: Value(color),
        ),
    ]);
    b.insertAll(db.ejercicios, [
      for (final (nombre, grupo, equipo) in _ejercicios)
        EjerciciosCompanion.insert(
          nombre: nombre,
          grupo: grupo,
          equipo: Value(equipo),
        ),
    ]);
    b.insert(
      db.cuentas,
      CuentasCompanion.insert(
        nombre: 'Efectivo',
        tipo: const Value(TipoCuenta.efectivo),
      ),
    );
  });
}

const _categoriasGasto = [
  ('Mercado', 'mercado', 0xFF2E7D32),
  ('Comida fuera', 'comida', 0xFFEF6C00),
  ('Transporte', 'transporte', 0xFF1565C0),
  ('Arriendo', 'casa', 0xFF6D4C41),
  ('Servicios', 'servicios', 0xFF00838F),
  ('Suscripciones', 'suscripciones', 0xFF8E24AA),
  ('Salud', 'salud', 0xFFC62828),
  ('Gimnasio', 'gimnasio', 0xFF5E35B1),
  ('Entretenimiento', 'entretenimiento', 0xFFD81B60),
  ('Ropa', 'ropa', 0xFF3949AB),
  ('Educación', 'educacion', 0xFF00897B),
  ('Otros gastos', 'otros', 0xFF757575),
];

const _categoriasIngreso = [
  ('Salario', 'salario', 0xFF2E7D32),
  ('Freelance', 'freelance', 0xFF00838F),
  ('Otros ingresos', 'otros', 0xFF757575),
];

const _ejercicios = [
  ('Jalón al pecho', 'Espalda', Equipo.polea),
  ('Remo con barra', 'Espalda', Equipo.barra),
  ('Remo sentado en polea', 'Espalda', Equipo.polea),
  ('Remo con mancuerna', 'Espalda', Equipo.mancuerna),
  ('Dominadas', 'Espalda', Equipo.pesoCorporal),
  ('Peso muerto', 'Espalda', Equipo.barra),
  ('Press de banca', 'Pecho', Equipo.barra),
  ('Press inclinado con mancuernas', 'Pecho', Equipo.mancuerna),
  ('Aperturas en máquina', 'Pecho', Equipo.maquina),
  ('Cruce de poleas', 'Pecho', Equipo.polea),
  ('Fondos', 'Pecho', Equipo.pesoCorporal),
  ('Sentadilla', 'Pierna', Equipo.barra),
  ('Prensa', 'Pierna', Equipo.maquina),
  ('Extensión de cuádriceps', 'Pierna', Equipo.maquina),
  ('Curl femoral', 'Pierna', Equipo.maquina),
  ('Zancadas', 'Pierna', Equipo.mancuerna),
  ('Pantorrilla de pie', 'Pierna', Equipo.maquina),
  ('Hip thrust', 'Glúteo', Equipo.barra),
  ('Abducción en máquina', 'Glúteo', Equipo.maquina),
  ('Press militar', 'Hombro', Equipo.barra),
  ('Elevaciones laterales', 'Hombro', Equipo.mancuerna),
  ('Face pull', 'Hombro', Equipo.polea),
  ('Curl con barra', 'Bíceps', Equipo.barra),
  ('Curl martillo', 'Bíceps', Equipo.mancuerna),
  ('Extensión de tríceps en polea', 'Tríceps', Equipo.polea),
  ('Press francés', 'Tríceps', Equipo.barra),
  ('Plancha', 'Core', Equipo.pesoCorporal),
  ('Crunch en polea', 'Core', Equipo.polea),
];
