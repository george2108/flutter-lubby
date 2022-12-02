import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:lubby_app/src/core/enums/notifications_channels_name_enum.dart';

List<NotificationChannel> notificationsChannels = [
  NotificationChannel(
    channelKey: NotificationsChannelsNameEnum.basicChannel.name,
    channelName: 'Basic notifications',
    channelDescription: 'Canal principal de notificaciones',
    defaultColor: Colors.red,
    importance: NotificationImportance.High,
    channelShowBadge: true,
  ),
  NotificationChannel(
    channelKey: NotificationsChannelsNameEnum.scheduledChannel.name,
    channelName: 'Scheduled notifications',
    channelDescription: 'Canal principal de notificaciones programadas',
    defaultColor: Colors.red,
    importance: NotificationImportance.High,
    channelShowBadge: true,
  ),
];
