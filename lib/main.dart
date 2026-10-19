import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app/app.dart';
import 'core/db/database.dart';
import 'core/notifications/notification_service.dart';
import 'core/providers.dart';
import 'modules/tareas/data/tareas_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('es');

  final db = AppDatabase();
  final notificaciones = await LocalNotificationService.inicializar();
  // Por si el sistema borró las alarmas (reinstalación, actualización...).
  await TareasRepository(db, notificaciones).reprogramarTodos();

  runApp(
    ProviderScope(
      overrides: [
        databaseProvider.overrideWithValue(db),
        notificationServiceProvider.overrideWithValue(notificaciones),
      ],
      child: const PersonalVaultApp(),
    ),
  );
}
