import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injector.dart';

import 'src/config/routes/router.dart';
import 'src/config/routes/routes.dart';
import 'src/core/constants/notifications_channels_constants.dart';
import 'src/data/datasources/local/services/local_notifications_service.dart';
import 'src/data/datasources/local/services/shared_preferences_service.dart';
import 'src/features/auth/data/repositories/login_repository.dart';
import 'src/features/auth/data/repositories/register_repository.dart';
import 'src/features/auth/presentation/bloc/auth_bloc.dart';
import 'src/ui/bloc/config/config_bloc.dart';
import 'src/ui/bloc/global/global_bloc.dart';
import 'src/ui/bloc/theme/theme_bloc.dart';
import 'src/config/theme/dark_theme.dart';
import 'src/config/theme/light_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDependencies();

  AwesomeNotifications().initialize(
    'resource://drawable/res_notification_app_icon',
    notificationsChannels,
  );

  // bloquear la rotacion de la pantalla
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then(
    (_) {
      runApp(const ConfigApp());
    },
  );
}

class ConfigApp extends StatelessWidget {
  const ConfigApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeBloc(injector<SharedPreferencesService>()),
        ),
        BlocProvider(create: (context) => ConfigBloc(), lazy: true),
        BlocProvider(create: (context) => GlobalBloc(), lazy: true),
        BlocProvider(
          create: (context) => AuthBloc(
            loginRepository: injector<LoginRepository>(),
            registerRepository: injector<RegisterRepository>(),
            sharedPreferencesService: injector<SharedPreferencesService>(),
          ),
          lazy: true,
        ),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: MyApp.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Lubby App',
      themeMode: context.watch<ThemeBloc>().state,
      theme: customLightTheme,
      darkTheme: customDarkTheme,
      onGenerateRoute: generateRoutes,
      initialRoute: passwordsRoute,
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
