import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:lubby_app/src/config/routes/routes.dart';
import 'package:lubby_app/src/core/enums/notifications_channels_name_enum.dart';
import 'package:lubby_app/src/core/utils/uniq_number_utilities.dart';
import 'package:lubby_app/src/features/example/local_notification_detail_example_page.dart';

import '../../../../../main.dart';

class LocalNotificationsService {
  Future<void> createNotification() async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueNumber(),
        channelKey: NotificationsChannelsNameEnum.basicChannel.name,
        title: '${Emojis.activites_reminder_ribbon} Recordatorio perro',
        body: 'Este es el texto que debe contener la notificacion...',
        bigPicture:
            'https://www.nintenderos.com/wp-content/uploads/2022/07/luffy-one-piece.jpg',
        notificationLayout: NotificationLayout.BigPicture,
      ),
    );
  }

  Future<void> createNotificacionRecordatorio(
    NotificationWeekAndTime notificationWeekAndTime,
  ) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueNumber(),
        channelKey: NotificationsChannelsNameEnum.scheduledChannel.name,
        title: '${Emojis.office_spiral_calendar} Recordatorio',
        body:
            'Este es el texto del recordatorio, puede usarse para recordatorios personalizados, tareas, notas, para mi agenda y para recordatorio de mis gastos e ingresos',
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'MARK_DONE',
          label: 'Marcar como hecho',
        ),
      ],
      schedule: NotificationCalendar(
        repeats: true,
        weekday: notificationWeekAndTime.dayOfTheWeek,
        hour: notificationWeekAndTime.timeOfDay.hour,
        minute: notificationWeekAndTime.timeOfDay.minute,
        second: 0,
        millisecond: 0,
      ),
    );
  }

  Future<void> cancelAllScheduledNotifications() async {
    await AwesomeNotifications().cancelAllSchedules();
  }
}

class NotificationControllerService {
  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
    ReceivedNotification receivedNotification,
  ) async {
    print('onNotificationCreatedMethod');
    print(receivedNotification);
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
    ReceivedNotification receivedNotification,
  ) async {
    print('onNotificationDisplayedMethod');
    print(receivedNotification);
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
    ReceivedAction receivedAction,
  ) async {
    print('onDismissActionReceivedMethod');
    print(receivedAction);
  }

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
    ReceivedAction receivedAction,
  ) async {
    print('onActionReceivedMethod');
    print(receivedAction);

    if (receivedAction.channelKey == 'basic_channel') {
      // Navigate into pages, avoiding to open the notification details page over another details page already opened
      MyApp.navigatorKey.currentState?.pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const LocalNotificationDetailExamplePage(),
          settings: const RouteSettings(name: reminderRoute),
        ),
        (route) => route.isFirst,
      );
    }
  }
}
