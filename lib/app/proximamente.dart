import 'package:flutter/material.dart';

/// Pantalla temporal para los módulos que aún no están construidos.
class Proximamente extends StatelessWidget {
  const Proximamente(this.titulo, this.icono, {super.key});

  final String titulo;
  final IconData icono;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(titulo)),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icono, size: 72, color: tema.colorScheme.primary),
            const SizedBox(height: 16),
            Text('Próximamente', style: tema.textTheme.titleLarge),
            const SizedBox(height: 4),
            Text(
              'Este módulo está en el roadmap.',
              style: tema.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
