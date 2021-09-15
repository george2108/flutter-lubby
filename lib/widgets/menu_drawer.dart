import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';

import 'package:lubby_app/pages/notes/notes_page.dart';
import 'package:lubby_app/pages/todo/todo_page.dart';
import 'package:lubby_app/providers/shared_preferences.dart';
import 'package:lubby_app/utils/theme.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Header(),
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
              Navigator.pushAndRemoveUntil(
                context,
                CupertinoPageRoute(
                    builder: (BuildContext context) => NotesPage()),
                (route) => false,
              );
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
              Navigator.pushAndRemoveUntil(
                context,
                CupertinoPageRoute(
                    builder: (BuildContext context) => ToDoPage()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF227c9d),
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
                'https://pbs.twimg.com/profile_images/1018943227791982592/URnaMrya.jpg'),
            radius: 50.0,
          ),
          SizedBox(height: 15.0),
          Text('Luby')
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
  final prefs = SharedPreferencesProvider();
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
            theme = value ? 'dark' : 'light';
            prefs.tema = value ? 'dark' : 'light';
            Get.changeTheme(!value ? ThemeData.light() : themes.darkThemeLubby);
            setState(() {});
          },
        ),
      ],
    );
  }
}
