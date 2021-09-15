import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:lubby_app/pages/auth_local/auth_local_binding.dart';
import 'package:lubby_app/pages/auth_local/auth_local_page.dart';
import 'package:lubby_app/pages/passwords/display_pass.dart';
import 'package:lubby_app/pages/passwords/edit_pass.dart';
import 'package:lubby_app/pages/passwords/new_password.dart';
import 'package:lubby_app/pages/passwords/password_binding.dart';
import 'package:lubby_app/pages/passwords/passwords_page.dart';
import 'package:lubby_app/providers/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new SharedPreferencesProvider();
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
    final prefs = new SharedPreferencesProvider();

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
          name: '/newPassword',
          page: () => NewPassword(),
          transition: Transition.cupertino,
        ),
        GetPage(
            name: '/passwords',
            page: () => PasswordsPage(),
            transition: Transition.cupertino,
            binding: PasswordBinding()),
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
      ],
      /*  routes: {
        // notas
        'notes': (BuildContext context) => NotesPage(),
        'newNote': (BuildContext context) => NewNote(),
        'editNote': (_) => EditNote(),

        // passwords
        'passwords': (BuildContext context) => PasswordsPage(),
        'newPassword': (BuildContext context) => NewPassword(),
        'showPassword': (BuildContext context) => ShowPassword(),
        'editPassword': (_) => EditPassword(),
      }, */
      /*   theme: ThemeData(
        primaryColor: Color(0xFF227c9d),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF17C3B2),
        ),
      ), */
    );
  }
}
