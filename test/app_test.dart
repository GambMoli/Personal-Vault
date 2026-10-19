import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:personal_vault/app/app.dart';
import 'package:personal_vault/core/db/database.dart';
import 'package:personal_vault/core/providers.dart';

/// Recorre todos los módulos y pestañas para detectar errores de layout o
/// de providers que los tests de datos no ven.
void main() {
  setUpAll(() async {
    await initializeDateFormatting('es');
    driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  });

  testWidgets('cada módulo y pestaña se dibuja sin errores', (tester) async {
    tester.view.physicalSize = const Size(1080, 2340);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);

    final db = AppDatabase(NativeDatabase.memory());
    await tester.pumpWidget(
      ProviderScope(
        overrides: [databaseProvider.overrideWithValue(db)],
        child: const PersonalVaultApp(),
      ),
    );

    Future<void> asentar() async {
      // Las consultas de drift corren fuera del reloj falso del test, y un
      // indicador de carga nunca "se asienta": se alternan ambos relojes.
      for (var i = 0; i < 6; i++) {
        await tester.runAsync(
          () => Future<void>.delayed(const Duration(milliseconds: 20)),
        );
        await tester.pump(const Duration(milliseconds: 200));
      }
    }

    await asentar();
    final modulos = {
      'Finanzas': ['Resumen', 'Movimientos', 'Cuentas', 'Metas y deudas'],
      'Entreno': ['Historial', 'Progreso', 'Ejercicios'],
      'Tareas': ['Hoy', 'Listas'],
      'Ideas': ['Mis ideas', 'Sugerencias'],
      'Cocina': ['Despensa', 'Por acabarse'],
    };
    for (final MapEntry(key: modulo, value: pestanas) in modulos.entries) {
      await tester.tap(
        find.descendant(
          of: find.byType(NavigationBar),
          matching: find.text(modulo),
        ),
      );
      await asentar();
      for (final p in pestanas) {
        await tester.ensureVisible(find.widgetWithText(Tab, p));
        await tester.pump(const Duration(milliseconds: 500));
        await tester.tap(find.widgetWithText(Tab, p));
        await asentar();
        expect(tester.takeException(), isNull, reason: '$modulo / $p');
      }
    }

    // Abre el formulario de nuevo movimiento.
    await tester.tap(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Finanzas'),
      ),
    );
    await asentar();
    await tester.tap(find.byTooltip('Nuevo movimiento'));
    await asentar();
    expect(find.text('Nuevo movimiento'), findsOneWidget);
    expect(tester.takeException(), isNull);

    // Desmonta la app para cancelar las consultas activas antes de terminar.
    await tester.pumpWidget(const SizedBox());
    await tester.pump(const Duration(seconds: 1));
  });
}
