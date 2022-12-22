import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:lubby_app/src/config/routes/routes.dart';
import 'package:lubby_app/src/presentation/pages/diary/diary_main_page.dart';
import 'package:lubby_app/src/presentation/pages/example/local_notifications_example_page.dart';
import 'package:lubby_app/src/presentation/pages/finances/finances_main_page.dart';
import 'package:lubby_app/src/presentation/pages/habits/habits_main_page.dart';
import 'package:lubby_app/src/presentation/pages/todos/todo_main_page.dart';

import '../pages/activities/activities/activities_page.dart';
import '../pages/config/config_page.dart';
import '../pages/notes/notes/notes_page.dart';
import '../pages/passwords/passwords/passwords_page.dart';
import '../pages/qr_reader/qr_reader/qr_reader_page.dart';
import '../pages/remiders/reminders_main_page.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: const [
            _HeaderMenuWidget(),
            _ItemMenuWidget(
              title: 'Gestor de contraseñas',
              icon: Icons.vpn_key,
              iconColor: Colors.orange,
              pageWidget: PasswordsPage(),
              route: passwordsRoute,
            ),
            _ItemMenuWidget(
              title: 'Notas',
              icon: Icons.note,
              iconColor: Colors.cyan,
              pageWidget: NotesPage(),
              route: notesRoute,
            ),
            _ItemMenuWidget(
              title: 'Lista de tareas',
              icon: Icons.check_circle_outline,
              iconColor: Colors.green,
              pageWidget: TodoMainPage(),
              route: toDosRoute,
            ),
            _ItemMenuWidget(
              title: 'Organizador de actividades',
              icon: Icons.table_restaurant,
              iconColor: Colors.orange,
              pageWidget: ActivitiesPage(),
              route: activitiesRoute,
            ),
            _ItemMenuWidget(
              title: 'Agenda',
              icon: Icons.contacts_outlined,
              iconColor: Colors.cyanAccent,
              pageWidget: DiaryMainPage(),
              route: diaryRoute,
            ),
            _ItemMenuWidget(
              title: 'Recordatorios',
              icon: Icons.notification_add_outlined,
              iconColor: Colors.purpleAccent,
              pageWidget: RemindersMainPage(),
              // pageWidget: LocalNotificationsExamplePage(),
              route: remindersRoute,
            ),
            _ItemMenuWidget(
              title: 'Gestor de ingresos y gastos',
              icon: Icons.attach_money,
              iconColor: Colors.green,
              pageWidget: FinancesMainPage(),
              route: financesRoute,
            ),
            _ItemMenuWidget(
              title: 'Lector de QRs',
              icon: Icons.qr_code_2,
              iconColor: Colors.black,
              pageWidget: QRReaderPage(),
              route: qrReaderRoute,
            ),
            _ItemMenuWidget(
              title: 'Mejorar habitos',
              icon: Icons.fitness_center,
              iconColor: Colors.black,
              pageWidget: HabitsMainPage(),
              route: habitsRoute,
            ),
            SizedBox(height: 25),
            _ItemMenuWidget(
              title: 'configuración',
              icon: Icons.settings,
              iconColor: Colors.blueAccent,
              pageWidget: ConfigPage(),
              route: configRoute,
            ),
          ],
        ),
      ),
    );
  }
}

class _ItemMenuWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final String route;
  final Color? iconColor;
  final VoidCallback? onTap;
  final Widget? pageWidget;

  const _ItemMenuWidget({
    required this.title,
    required this.icon,
    required this.route,
    this.iconColor,
    this.onTap,
    this.pageWidget,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minLeadingWidth: 20,
      title: Text(title),
      leading: Icon(
        icon,
        color: iconColor,
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap ??
          () {
            Navigator.of(context).pop();
            Navigator.pushAndRemoveUntil(
              context,
              CupertinoPageRoute(
                builder: (_) => pageWidget ?? const PasswordsPage(),
                settings: RouteSettings(name: route),
              ),
              (route) => false,
            );
          },
    );
  }
}

class _HeaderMenuWidget extends StatelessWidget {
  const _HeaderMenuWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF227c9d),
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      width: double.infinity,
      child: Column(
        children: const [
          CircleAvatar(
            radius: 50.0,
            backgroundColor: Colors.white,
            child: Text(
              'L',
              style: TextStyle(
                color: Colors.purple,
                fontWeight: FontWeight.bold,
                fontSize: 45,
              ),
            ),
          ),
          SizedBox(height: 15.0),
          Text('Luby')
        ],
      ),
    );
  }
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