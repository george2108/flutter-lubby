import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/services.dart';
import 'dart:io';

import 'injector.dart';

import 'config_bloc_app.dart';
import 'src/core/constants/notifications_channels_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDependencies();

  if (Platform.isAndroid || Platform.isIOS) {
    AwesomeNotifications().initialize(
      'resource://drawable/res_notification_app_icon',
      notificationsChannels,
    );

    // bloquear la rotacion de la pantalla
    if (Platform.isAndroid || Platform.isIOS) {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
  }

  runApp(const ConfigBlocApp());
}
