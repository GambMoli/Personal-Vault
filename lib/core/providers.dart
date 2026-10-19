import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'db/database.dart';
import 'notifications/notification_service.dart';

/// Se sobrescriben en `main.dart` (y en los tests) con las instancias reales.
final databaseProvider = Provider<AppDatabase>(
  (ref) => throw UnimplementedError('databaseProvider no inicializado'),
);

final notificationServiceProvider = Provider<NotificationService>(
  (ref) => const NoopNotificationService(),
);
