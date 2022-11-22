import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lubby_app/src/data/datasources/password_service.dart';
import 'package:lubby_app/src/data/datasources/shared_preferences_service.dart';
import 'package:lubby_app/src/config/routes/router.dart';
import 'package:lubby_app/src/config/routes/routes.dart';
import 'package:lubby_app/src/presentation/bloc/auth/auth_bloc.dart';
import 'package:lubby_app/src/presentation/bloc/config/config_bloc.dart';
import 'package:lubby_app/src/presentation/bloc/theme/theme_bloc.dart';
import 'package:lubby_app/src/config/theme/dark_theme.dart';
import 'package:lubby_app/src/config/theme/light_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = SharedPreferencesService();
  await prefs.initPrefs();
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
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => SharedPreferencesService()),
        RepositoryProvider(create: (_) => PasswordService()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ThemeBloc(
              RepositoryProvider.of<SharedPreferencesService>(context),
            ),
          ),
          BlocProvider(create: (context) => ConfigBloc()),
          BlocProvider(create: (context) => AuthBloc()),
        ],
        child: const MyApp(),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lubby App',
      themeMode: context.watch<ThemeBloc>().state,
      theme: customLightTheme,
      darkTheme: customDarkTheme,
      onGenerateRoute: generateRoutes,
      initialRoute: passwordsRoute,
    );
  }
}
