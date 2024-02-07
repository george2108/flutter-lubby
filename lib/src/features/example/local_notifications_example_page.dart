import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

import '../../core/utils/uniq_number_utilities.dart';
import '../../data/datasources/local/local_notifications_service.dart';
import 'local_notification_detail_example_page.dart';
import '../../ui/widgets/menu_drawer/menu_drawer.dart';

class LocalNotificationsExamplePage extends StatefulWidget {
  const LocalNotificationsExamplePage({super.key});
  @override
  State<LocalNotificationsExamplePage> createState() =>
      _LocalNotificationsExamplePageState();
}

class _LocalNotificationsExamplePageState
    extends State<LocalNotificationsExamplePage> {
  final notificationsService = LocalNotificationsService();

  @override
  void initState() {
    super.initState();

    AwesomeNotifications().isNotificationAllowed().then(
      (isAllowed) {
        if (!isAllowed) {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('Permitir mostrar notificaciones'),
              content: const Text('Nos gustaría enviarte notificaciones'),
              actions: [
                TextButton(
                  child: const Text('No permitir'),
                  onPressed: () {
                    Navigator.maybePop(context);
                  },
                ),
                TextButton(
                  child: const Text(
                    'Permitir',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    AwesomeNotifications()
                        .requestPermissionToSendNotifications()
                        .then((_) {
                      Navigator.maybePop(context);
                    });
                  },
                ),
              ],
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificaciones de ejemplo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.route),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const LocalNotificationDetailExamplePage(),
                ),
              );
            },
          ),
        ],
      ),
      drawer: const Menu(),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          ElevatedButton(
            onPressed: notificationsService.createNotification,
            child: const Text('Lanzar notificacion'),
          ),
          ElevatedButton(
            child: const Text('Programar notificación'),
            onPressed: () async {
              NotificationWeekAndTime? notificationSchedule =
                  await picksSchedule(context);
              if (notificationSchedule != null) {
                notificationsService.createNotificacionRecordatorio(
                  notificationSchedule,
                );
              }
            },
          ),
          ElevatedButton(
            onPressed: notificationsService.cancelAllScheduledNotifications,
            child: const Text('Cancelar notificacion programadas'),
          ),
        ],
      ),
    );
  }
}
