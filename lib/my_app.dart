import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'src/config/routes/router.dart';
import 'src/config/theme/dark_theme.dart';
import 'src/config/theme/light_theme.dart';
import 'src/data/datasources/local/local_notifications_service.dart';
import 'src/ui/bloc/theme/theme_bloc.dart';

class MyApp extends StatefulWidget {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with RouterMixin {
  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid || Platform.isIOS) {
      AwesomeNotifications().setListeners(
        onActionReceivedMethod:
            NotificationControllerService.onActionReceivedMethod,
        onNotificationCreatedMethod:
            NotificationControllerService.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:
            NotificationControllerService.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:
            NotificationControllerService.onDismissActionReceivedMethod,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // navigatorKey: MyApp.navigatorKey,
      // onGenerateRoute: generateRoutes,
      // initialRoute: passwordsRoute,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      title: 'Lubby App',
      themeMode: context.watch<ThemeBloc>().state,
      theme: customLightTheme,
      darkTheme: customDarkTheme,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('fr', ''),
        Locale('es', ''),
      ],
    );
  }
}
