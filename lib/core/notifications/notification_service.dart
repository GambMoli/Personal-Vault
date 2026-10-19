import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

/// Recordatorios locales. La interfaz permite usar una versión vacía en tests.
abstract interface class NotificationService {
  Future<void> programar({
    required int id,
    required String titulo,
    required String cuerpo,
    required DateTime cuando,
  });
  Future<void> cancelar(int id);
  Future<void> cancelarTodas();
}

class LocalNotificationService implements NotificationService {
  LocalNotificationService._(this._plugin);

  final FlutterLocalNotificationsPlugin _plugin;
  bool _permisosPedidos = false;

  static const _detalles = NotificationDetails(
    android: AndroidNotificationDetails(
      'recordatorios',
      'Recordatorios',
      channelDescription: 'Recordatorios de tareas, pagos y vencimientos',
      importance: Importance.high,
      priority: Priority.high,
      category: AndroidNotificationCategory.reminder,
    ),
  );

  static Future<LocalNotificationService> inicializar() async {
    tz_data.initializeTimeZones();
    try {
      final zona = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(zona.identifier));
    } catch (e) {
      debugPrint('Zona horaria no disponible, usando America/Bogota: $e');
      tz.setLocalLocation(tz.getLocation('America/Bogota'));
    }

    final plugin = FlutterLocalNotificationsPlugin();
    await plugin.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      ),
    );
    return LocalNotificationService._(plugin);
  }

  AndroidFlutterLocalNotificationsPlugin? get _android => _plugin
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >();

  Future<void> _pedirPermisos() async {
    if (_permisosPedidos) return;
    _permisosPedidos = true;
    await _android?.requestNotificationsPermission();
    if (await _android?.canScheduleExactNotifications() == false) {
      await _android?.requestExactAlarmsPermission();
    }
  }

  @override
  Future<void> programar({
    required int id,
    required String titulo,
    required String cuerpo,
    required DateTime cuando,
  }) async {
    if (!cuando.isAfter(DateTime.now())) return;
    await _pedirPermisos();
    final exacta = await _android?.canScheduleExactNotifications() ?? false;
    await _plugin.zonedSchedule(
      id: id,
      title: titulo,
      body: cuerpo,
      scheduledDate: tz.TZDateTime.from(cuando, tz.local),
      notificationDetails: _detalles,
      androidScheduleMode: exacta
          ? AndroidScheduleMode.exactAllowWhileIdle
          : AndroidScheduleMode.inexactAllowWhileIdle,
    );
  }

  @override
  Future<void> cancelar(int id) => _plugin.cancel(id: id);

  @override
  Future<void> cancelarTodas() => _plugin.cancelAll();
}

/// Implementación que no hace nada (tests).
class NoopNotificationService implements NotificationService {
  const NoopNotificationService();

  @override
  Future<void> programar({
    required int id,
    required String titulo,
    required String cuerpo,
    required DateTime cuando,
  }) async {}

  @override
  Future<void> cancelar(int id) async {}

  @override
  Future<void> cancelarTodas() async {}
}
