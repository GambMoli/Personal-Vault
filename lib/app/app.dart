import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../modules/entrenamiento/ui/entrenamiento_screen.dart';
import '../modules/finanzas/ui/finanzas_screen.dart';
import '../modules/tareas/ui/tareas_screen.dart';
import 'proximamente.dart';

class PersonalVaultApp extends StatelessWidget {
  const PersonalVaultApp({super.key});

  static const _semilla = Color(0xFF3F51B5);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Vault',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: _semilla, brightness: Brightness.light),
      darkTheme: ThemeData(
        colorSchemeSeed: _semilla,
        brightness: Brightness.dark,
      ),
      locale: const Locale('es'),
      supportedLocales: const [Locale('es')],
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      home: const HomeShell(),
    );
  }
}

class _Modulo {
  const _Modulo(this.nombre, this.icono, this.iconoActivo, this.pantalla);
  final String nombre;
  final IconData icono;
  final IconData iconoActivo;
  final Widget pantalla;
}

const _modulos = [
  _Modulo(
    'Finanzas',
    Icons.account_balance_wallet_outlined,
    Icons.account_balance_wallet,
    FinanzasScreen(),
  ),
  _Modulo(
    'Entreno',
    Icons.fitness_center_outlined,
    Icons.fitness_center,
    EntrenamientoScreen(),
  ),
  _Modulo(
    'Tareas',
    Icons.check_circle_outline,
    Icons.check_circle,
    TareasScreen(),
  ),
  _Modulo(
    'Ideas',
    Icons.lightbulb_outline,
    Icons.lightbulb,
    Proximamente('Code con Gabo', Icons.lightbulb),
  ),
  _Modulo(
    'Cocina',
    Icons.kitchen_outlined,
    Icons.kitchen,
    Proximamente('Cocina', Icons.kitchen),
  ),
];

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _actual = 2; // Tareas es el primer módulo disponible.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _actual,
        children: [for (final m in _modulos) m.pantalla],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _actual,
        onDestinationSelected: (i) => setState(() => _actual = i),
        destinations: [
          for (final m in _modulos)
            NavigationDestination(
              icon: Icon(m.icono),
              selectedIcon: Icon(m.iconoActivo),
              label: m.nombre,
            ),
        ],
      ),
    );
  }
}
