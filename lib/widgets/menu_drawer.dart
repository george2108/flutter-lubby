import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';
import 'package:lubby_app/core/authentication/authentication_controller.dart';

import 'package:lubby_app/services/shared_preferences_service.dart';
import 'package:lubby_app/utils/theme.dart';

class Menu extends StatelessWidget {
  AuthenticationController _authenticationController =
      Get.find<AuthenticationController>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                _authenticationController.isLogged.value
                    ? _headerLogin()
                    : _header(),
                // _DarkThemeSwitch(),
                _DarkThemeSwitch(),
                ListTile(
                  title: Text('Contraseñas'),
                  leading: Icon(
                    Icons.vpn_key,
                    color: Colors.orange,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    Get.offNamedUntil('/passwords', (route) => false);
                  },
                ),
                ListTile(
                  title: Text('Notas'),
                  leading: Icon(
                    Icons.note,
                    color: Colors.cyan,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    Get.offNamedUntil('/notes', (route) => false);
                  },
                ),
                ListTile(
                  title: Text('Tareas'),
                  leading: Icon(
                    Icons.check_circle_outline,
                    color: Colors.green,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    Get.offNamedUntil('/todo', (route) => false);
                  },
                ),
                ListTile(
                  title: Text('configuración'),
                  leading: Icon(
                    Icons.settings,
                    color: Colors.blueAccent,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    Get.offNamedUntil('/config', (route) => false);
                  },
                ),
                _authenticationController.isLogged.value
                    ? ListTile(
                        title: Text('Cerrar sesión'),
                        leading: Icon(
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
          _authenticationController.isLogged.value
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
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        borderRadius: 5.0,
        color: Theme.of(context).buttonColor,
        loader: Container(
          padding: EdgeInsets.all(10),
          child: CircularProgressIndicator(
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
      color: Color(0xFF227c9d),
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        children: [
          CircleAvatar(
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
          SizedBox(height: 15.0),
          Text('Luby')
        ],
      ),
    );
  }

  Widget _headerLogin() {
    final user = _authenticationController.user.value;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
      decoration: BoxDecoration(
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
              style: TextStyle(
                color: Colors.purple,
                fontWeight: FontWeight.bold,
                fontSize: 45,
              ),
            ),
            radius: 50.0,
            backgroundColor: Colors.white,
          ),
          SizedBox(height: 15.0),
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
                icon: Icon(Icons.edit),
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
  late String theme;
  final themes = ThemesLubby();

  __DarkThemeSwitchState() {
    theme = prefs.tema;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text('Dark theme'),
        CupertinoSwitch(
          activeColor: Theme.of(context).accentColor,
          value: theme == 'dark' ? true : false,
          onChanged: (value) {
            print(value);
            theme = value ? 'dark' : 'light';
            print(theme);
            prefs.tema = theme;
            Get.changeTheme(!value ? ThemeData.light() : ThemeData.dark());
            setState(() {});
          },
        ),
      ],
    );
  }
}
