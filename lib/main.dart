import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lubby_app/bloc/auth/auth_bloc.dart';
import 'package:lubby_app/bloc/config/config_bloc.dart';
import 'package:lubby_app/bloc/theme/theme_bloc.dart';
import 'package:lubby_app/pages/auth/login/login_page.dart';
import 'package:lubby_app/pages/auth/register/register_page.dart';

import 'package:lubby_app/pages/auth_local/auth_local_page.dart';
import 'package:lubby_app/pages/config/config_page.dart';
import 'package:lubby_app/pages/notes/display_note.dart';
import 'package:lubby_app/pages/passwords/passwords/passwords_page.dart';
import 'package:lubby_app/pages/profile/profile_page.dart';
import 'package:lubby_app/pages/todo/todo_page.dart';
import 'package:lubby_app/services/http_service.dart';
import 'package:lubby_app/services/password_service.dart';
import 'package:lubby_app/services/shared_preferences_service.dart';
import 'package:lubby_app/utils/dark_theme.dart';
import 'package:lubby_app/utils/light_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = SharedPreferencesService();
  await prefs.initPrefs();
  // bloquear la rotacion de la pantalla
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then(
    (_) {
      runApp(new ConfigApp());
    },
  );
}

class ConfigApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => SharedPreferencesService()),
        RepositoryProvider(create: (_) => HttpService()),
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
      initialRoute: '/auth',
      themeMode: context.watch<ThemeBloc>().state,
      theme: customLightTheme,
      darkTheme: customDarkTheme,
      routes: {
        '/auth': (_) => AuthLocalPage(),
        '/passwords': (_) => PasswordsPage(),
        '/showNote': (_) => ShowNote(),
        '/todo': (_) => ToDoPage(),
        '/config': (_) => ConfigPage(),
        '/login': (_) => LoginPage(),
        '/register': (_) => RegisterPage(),
        '/profile': (_) => ProfilePage()
      },
    );
  }
}
