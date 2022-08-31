import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:lubby_app/pages/qr_reader/qr_reader/qr_reader_page.dart';

import 'package:lubby_app/pages/activities/activities/activities_page.dart';
import 'package:lubby_app/pages/config/config_page.dart';
import 'package:lubby_app/pages/diary/diary/diary_page.dart';
import 'package:lubby_app/pages/notes/notes/notes_page.dart';
import 'package:lubby_app/pages/passwords/passwords/passwords_page.dart';
import 'package:lubby_app/pages/remiders/remiders/reminders_page.dart';
import 'package:lubby_app/pages/todos/todos/todos_page.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                _header(),
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
                      (route) => false,
                    );
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
                      (route) => false,
                    );
                  },
                ),
                ListTile(
                  title: const Text('Lista de tareas'),
                  leading: const Icon(
                    Icons.check_circle_outline,
                    color: Colors.green,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.pushAndRemoveUntil(
                      context,
                      CupertinoPageRoute(builder: (_) => const TodosPage()),
                      (route) => false,
                    );
                  },
                ),
                ListTile(
                  title: const Text('Organizador de actividades'),
                  leading: const Icon(
                    Icons.table_restaurant,
                    color: Colors.orange,
                  ),
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      CupertinoPageRoute(
                        builder: (_) => const ActivitiesPage(),
                      ),
                      (route) => false,
                    );
                  },
                ),
                ListTile(
                  title: const Text('Agenda'),
                  leading: const Icon(
                    Icons.contacts_outlined,
                    color: Colors.cyanAccent,
                  ),
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      CupertinoPageRoute(
                        builder: (_) => const DiaryPage(),
                      ),
                      (route) => false,
                    );
                  },
                ),
                ListTile(
                  title: const Text('Recordatorios'),
                  leading: const Icon(
                    Icons.notification_add_outlined,
                    color: Colors.purpleAccent,
                  ),
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      CupertinoPageRoute(
                        builder: (_) => const RemindersPage(),
                      ),
                      (route) => false,
                    );
                  },
                ),
                ListTile(
                  title: const Text('Lector de QRs'),
                  leading: const Icon(
                    Icons.qr_code_2,
                    color: Colors.black,
                  ),
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      CupertinoPageRoute(
                        builder: (_) => const QRReaderPage(),
                      ),
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
              ],
            ),
          ),
          // _buttonAuth(context, 'Iniciar sesión')
        ],
      ),
    );
  }

  /*  _buttonAuth(BuildContext context, String title) {
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
  } */

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
}
