import 'package:flutter/material.dart';

import 'package:get/route_manager.dart';

import 'package:flutter/services.dart';
import 'package:lubby_app/core/initial_binding.dart';
import 'package:lubby_app/pages/auth/login/login_binding.dart';
import 'package:lubby_app/pages/auth/login/login_page.dart';
import 'package:lubby_app/pages/auth/register/register_binding.dart';
import 'package:lubby_app/pages/auth/register/register_controller.dart';
import 'package:lubby_app/pages/auth/register/register_page.dart';

import 'package:lubby_app/pages/auth_local/auth_local_binding.dart';
import 'package:lubby_app/pages/auth_local/auth_local_page.dart';
import 'package:lubby_app/pages/config/config_page.dart';
import 'package:lubby_app/pages/notes/display_note.dart';
import 'package:lubby_app/pages/notes/edit_note.dart';
import 'package:lubby_app/pages/notes/new_note.dart';
import 'package:lubby_app/pages/notes/note_binding.dart';
import 'package:lubby_app/pages/notes/notes_page.dart';
import 'package:lubby_app/pages/passwords/display_pass.dart';
import 'package:lubby_app/pages/passwords/edit_pass.dart';
import 'package:lubby_app/pages/passwords/new_password.dart';
import 'package:lubby_app/pages/passwords/password_binding.dart';
import 'package:lubby_app/pages/passwords/passwords_page.dart';
import 'package:lubby_app/pages/profile/profile_binding.dart';
import 'package:lubby_app/pages/profile/profile_page.dart';
import 'package:lubby_app/pages/todo/todo_binding.dart';
import 'package:lubby_app/pages/todo/todo_page.dart';
import 'package:lubby_app/services/shared_preferences_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new SharedPreferencesService();
  await prefs.initPrefs();
  // bloquear la rotacion de la pantalla
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prefs = new SharedPreferencesService();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      theme: prefs.tema == 'dark' ? ThemeData.dark() : ThemeData.light(),
      initialRoute: '/auth',
      getPages: [
        // auth
        GetPage(
          name: '/auth',
          binding: AuthLocalBinding(),
          page: () => AuthLocalPage(),
        ),
        // passwords
        GetPage(
          name: '/passwords',
          page: () => PasswordsPage(),
          transition: Transition.cupertino,
          bindings: [PasswordBinding(), InitialBinding()],
        ),
        GetPage(
          name: '/newPassword',
          page: () => NewPassword(),
          transition: Transition.cupertino,
        ),
        GetPage(
          name: '/editPassword',
          page: () => EditPassword(),
          transition: Transition.cupertino,
        ),
        GetPage(
          name: '/showPassword',
          page: () => ShowPassword(),
          transition: Transition.cupertino,
        ),
        // notes
        GetPage(
          name: '/newNote',
          page: () => NewNote(),
          transition: Transition.cupertino,
        ),
        GetPage(
            name: '/notes',
            page: () => NotesPage(),
            transition: Transition.cupertino,
            binding: NoteBinding()),
        GetPage(
          name: '/editNote',
          page: () => EditNote(),
          transition: Transition.cupertino,
        ),
        GetPage(
          name: '/showNote',
          page: () => ShowNote(),
          transition: Transition.cupertino,
        ),
        // tareas
        GetPage(
          name: '/todo',
          page: () => ToDoPage(),
          transition: Transition.cupertino,
          binding: ToDoBinding(),
        ),
        /**
         * configuracion
         */
        GetPage(
          name: '/config',
          page: () => ConfigPage(),
          transition: Transition.cupertino,
        ),
        /**
         * Auth
         */
        GetPage(
          name: '/login',
          page: () => LoginPage(),
          transition: Transition.cupertino,
          binding: LoginBinding(),
        ),
        GetPage(
          name: '/register',
          page: () => RegisterPage(),
          transition: Transition.cupertino,
          binding: RegisterBinding(),
        ),
        /**
         * perfil
         */
        GetPage(
          name: '/profile',
          page: () => ProfilePage(),
          transition: Transition.cupertino,
          binding: ProfileBinding(),
        ),
      ],
    );
  }
}
