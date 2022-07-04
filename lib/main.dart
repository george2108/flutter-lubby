import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lubby_app/pages/auth/login/login_page.dart';
import 'package:lubby_app/pages/auth/register/register_page.dart';

import 'package:lubby_app/pages/auth_local/auth_local_page.dart';
import 'package:lubby_app/pages/config/bloc/config_bloc.dart';
import 'package:lubby_app/pages/config/config_page.dart';
import 'package:lubby_app/pages/notes/display_note.dart';
import 'package:lubby_app/pages/notes/edit_note.dart';
import 'package:lubby_app/pages/notes/new_note.dart';
import 'package:lubby_app/pages/notes/notes_page.dart';
import 'package:lubby_app/pages/passwords/display_pass.dart';
import 'package:lubby_app/pages/passwords/edit_pass.dart';
import 'package:lubby_app/pages/passwords/new_password.dart';
import 'package:lubby_app/pages/profile/profile_page.dart';
import 'package:lubby_app/pages/todo/todo_page.dart';
import 'package:lubby_app/services/http_service.dart';
import 'package:lubby_app/services/password_service.dart';
import 'package:lubby_app/services/shared_preferences_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = SharedPreferencesService();
  await prefs.initPrefs();
  // bloquear la rotacion de la pantalla
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then(
    (_) {
      runApp(
        new ConfigApp(),
      );
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
          BlocProvider(create: (context) => ConfigBloc()),
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
      title: 'Material App',
      initialRoute: '/auth',
      // themeMode: context.watch<ConfigAppProvider>().themeMode,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      routes: {
        '/auth': (_) => AuthLocalPage(),
        '/newPassword': (_) => NewPassword(),
        '/editPassword': (_) => EditPassword(),
        '/showPassword': (_) => ShowPassword(),
        '/newNote': (_) => NewNote(),
        '/notes': (_) => NotesPage(),
        '/editNote': (_) => EditNote(),
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
