import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:lubby_app/pages/auth/login/login_page.dart';
import 'package:lubby_app/pages/auth/register/register_page.dart';

import 'package:lubby_app/pages/auth_local/auth_local_page.dart';
import 'package:lubby_app/pages/config/config_page.dart';
import 'package:lubby_app/pages/notes/display_note.dart';
import 'package:lubby_app/pages/notes/edit_note.dart';
import 'package:lubby_app/pages/notes/new_note.dart';
import 'package:lubby_app/pages/notes/notes_page.dart';
import 'package:lubby_app/pages/passwords/display_pass.dart';
import 'package:lubby_app/pages/passwords/edit_pass.dart';
import 'package:lubby_app/pages/passwords/new_password.dart';
import 'package:lubby_app/pages/passwords/passwords_page.dart';
import 'package:lubby_app/pages/profile/profile_page.dart';
import 'package:lubby_app/pages/todo/todo_page.dart';
import 'package:lubby_app/providers/auth_provider.dart';
import 'package:lubby_app/providers/config_app_provider.dart';
import 'package:lubby_app/providers/local_auth_provider.dart';
import 'package:lubby_app/providers/notes_provider.dart';
import 'package:lubby_app/providers/passwords_provider.dart';
import 'package:lubby_app/providers/sesion_provider.dart';
import 'package:lubby_app/providers/todo_provider.dart';
import 'package:lubby_app/services/shared_preferences_service.dart';
import 'package:provider/provider.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LocalAuthProvider()),
        ChangeNotifierProvider(create: (context) => NotesProvider()),
        ChangeNotifierProvider(create: (context) => PasswordsProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => ToDoProvider()),
        ChangeNotifierProvider(create: (context) => SesionProvider()),
        ChangeNotifierProvider(create: (context) => ConfigAppProvider()),
      ],
      builder: (context, _) {
        return const MyApp();
      },
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
      themeMode: context.watch<ConfigAppProvider>().themeMode,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      routes: {
        '/auth': (_) => AuthLocalPage(),
        '/passwords': (_) => PasswordsPage(),
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
