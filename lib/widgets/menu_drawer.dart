import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';
import 'package:lubby_app/pages/config/config_page.dart';
import 'package:lubby_app/pages/notes/notes_page.dart';
import 'package:lubby_app/pages/passwords/passwords_page.dart';
import 'package:lubby_app/pages/todo/todo_page.dart';
import 'package:lubby_app/providers/auth_provider.dart';

import 'package:lubby_app/services/shared_preferences_service.dart';
import 'package:provider/provider.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthProvider>(context);

    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                _authProvider.isLogged
                    ? _headerLogin(_authProvider)
                    : _header(),
                // _DarkThemeSwitch(),
                _DarkThemeSwitch(),
                ListTile(
                  title: const Text('Contraseñas'),
                  leading: const Icon(
                    Icons.vpn_key,
                    color: Colors.orange,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.pushAndRemoveUntil(
                        context,
                        CupertinoPageRoute(builder: (_) => PasswordsPage()),
                        (route) => false);
                  },
                ),
                ListTile(
                  title: const Text('Notas'),
                  leading: const Icon(
                    Icons.note,
                    color: Colors.cyan,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.pushAndRemoveUntil(
                        context,
                        CupertinoPageRoute(builder: (_) => NotesPage()),
                        (route) => false);
                  },
                ),
                ListTile(
                  title: const Text('Tareas'),
                  leading: const Icon(
                    Icons.check_circle_outline,
                    color: Colors.green,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.pushAndRemoveUntil(
                      context,
                      CupertinoPageRoute(builder: (_) => ToDoPage()),
                      (route) => false,
                    );
                  },
                ),
                const SizedBox(height: 25),
                ListTile(
                  title: const Text('configuración'),
                  leading: const Icon(
                    Icons.settings,
                    color: Colors.blueAccent,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.pushAndRemoveUntil(
                      context,
                      CupertinoPageRoute(builder: (_) => ConfigPage()),
                      (route) => false,
                    );
                  },
                ),
                _authProvider.isLogged
                    ? ListTile(
                        title: const Text('Cerrar sesión'),
                        leading: const Icon(
                          Icons.power_settings_new_outlined,
                          color: Colors.red,
                        ),
                        onTap: () {},
                      )
                    : Container(),
              ],
            ),
          ),
          // _buttonAuth(context, 'Iniciar sesión')
          // TODO: DESCOMENTAR porque este es el bueno
          _authProvider.isLogged
              ? Container()
              : _buttonAuth(context, 'Iniciar sesión'),
        ],
      ),
    );
  }

  _buttonAuth(BuildContext context, String title) {
    return Container(
      width: double.infinity,
      child: ArgonButton(
        height: 50,
        width: 350,
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        borderRadius: 5.0,
        color: Theme.of(context).buttonColor,
        loader: Container(
          padding: const EdgeInsets.all(10),
          child: const CircularProgressIndicator(
            backgroundColor: Colors.red,
          ),
        ),
        onTap: (startLoading, stopLoading, btnState) async {
          Navigator.of(context).pop();
          Get.toNamed('/login');
        },
      ),
    );
  }

  Widget _header() {
    return Container(
      color: const Color(0xFF227c9d),
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        children: [
          const CircleAvatar(
            child: Text(
              'L',
              style: TextStyle(
                color: Colors.purple,
                fontWeight: FontWeight.bold,
                fontSize: 45,
              ),
            ),
            radius: 50.0,
            backgroundColor: Colors.white,
          ),
          const SizedBox(height: 15.0),
          const Text('Luby')
        ],
      ),
    );
  }

  Widget _headerLogin(AuthProvider provider) {
    final user = provider.user;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
      decoration: const BoxDecoration(
        color: Color(0xFF227c9d),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          CircleAvatar(
            child: Text(
              user.nombre.substring(0, 1).toUpperCase(),
              style: const TextStyle(
                color: Colors.purple,
                fontWeight: FontWeight.bold,
                fontSize: 45,
              ),
            ),
            radius: 50.0,
            backgroundColor: Colors.white,
          ),
          const SizedBox(height: 15.0),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${user.nombre.toUpperCase()} ${user.apellidos.toUpperCase()}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Text(
                      user.email,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  Get.toNamed('/profile');
                },
                icon: const Icon(Icons.edit),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DarkThemeSwitch extends StatefulWidget {
  @override
  __DarkThemeSwitchState createState() => __DarkThemeSwitchState();
}

class __DarkThemeSwitchState extends State<_DarkThemeSwitch> {
  final prefs = SharedPreferencesService();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Text('Dark theme'),
        CupertinoSwitch(
          activeColor: Theme.of(context).accentColor,
          value: prefs.tema == 'dark' ? true : false,
          onChanged: (value) {
            print(value);
            prefs.tema = value ? 'dark' : 'light';
            value
                ? AdaptiveTheme.of(context).setDark()
                : AdaptiveTheme.of(context).setLight();
            setState(() {});
          },
        ),
      ],
    );
  }
}
