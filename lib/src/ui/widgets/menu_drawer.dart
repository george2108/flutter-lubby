import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lubby_app/src/config/routes/routes.dart';
import 'package:lubby_app/src/core/utils/get_contrasting_text_color.dart';
import 'package:lubby_app/src/ui/pages/diary/diary_main_page.dart';
import 'package:lubby_app/src/ui/pages/finances/finances_main_page.dart';
import 'package:lubby_app/src/ui/pages/habits/habits_main_page.dart';
import 'package:lubby_app/src/ui/pages/notes/notes_main_page.dart';
import 'package:lubby_app/src/ui/pages/passwords/passwords_main_page.dart';
import 'package:lubby_app/src/ui/pages/todos/todo_main_page.dart';

import '../bloc/global/global_bloc.dart';
import '../pages/activities/activities/activities_page.dart';
import '../pages/config/config_page.dart';
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
              pageWidget: PasswordsMainPage(),
              route: passwordsRoute,
              index: 0,
            ),
            _ItemMenuWidget(
              title: 'Notas',
              icon: Icons.note,
              iconColor: Colors.cyan,
              pageWidget: NotesMainPage(),
              route: notesRoute,
              index: 1,
            ),
            _ItemMenuWidget(
              title: 'Lista de tareas',
              icon: Icons.check_circle_outline,
              iconColor: Colors.green,
              pageWidget: TodoMainPage(),
              route: toDosRoute,
              index: 2,
            ),
            _ItemMenuWidget(
              title: 'Organizador de actividades',
              icon: Icons.table_restaurant,
              iconColor: Colors.orange,
              pageWidget: ActivitiesPage(),
              route: activitiesRoute,
              index: 3,
            ),
            _ItemMenuWidget(
              title: 'Agenda',
              icon: Icons.contacts_outlined,
              iconColor: Colors.cyanAccent,
              pageWidget: DiaryMainPage(),
              route: diaryRoute,
              index: 4,
            ),
            _ItemMenuWidget(
              title: 'Recordatorios',
              icon: Icons.notification_add_outlined,
              iconColor: Colors.purpleAccent,
              pageWidget: RemindersMainPage(),
              // pageWidget: LocalNotificationsExamplePage(),
              route: remindersRoute,
              index: 5,
            ),
            _ItemMenuWidget(
              title: 'Gestor de ingresos y gastos',
              icon: Icons.attach_money,
              iconColor: Colors.green,
              pageWidget: FinancesMainPage(),
              route: financesRoute,
              index: 6,
            ),
            _ItemMenuWidget(
              title: 'Lector de QRs',
              icon: Icons.qr_code_2,
              iconColor: Colors.black,
              pageWidget: QRReaderPage(),
              route: qrReaderRoute,
              index: 7,
            ),
            _ItemMenuWidget(
              title: 'Mejorar habitos',
              icon: Icons.fitness_center,
              iconColor: Colors.black,
              pageWidget: HabitsMainPage(),
              route: habitsRoute,
              index: 8,
            ),
            SizedBox(height: 25),
            _ItemMenuWidget(
              title: 'configuración',
              icon: Icons.settings,
              iconColor: Colors.blueAccent,
              pageWidget: ConfigPage(),
              route: configRoute,
              index: 9,
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
  final Widget? pageWidget;
  final int index;

  const _ItemMenuWidget({
    required this.title,
    required this.icon,
    required this.route,
    required this.index,
    this.iconColor,
    this.pageWidget,
  });

  @override
  Widget build(BuildContext context) {
    final globalBloc = BlocProvider.of<GlobalBloc>(context);

    return ListTile(
      minLeadingWidth: 20,
      title: Text(title),
      leading: Icon(
        icon,
        color: iconColor,
      ),
      trailing: const Icon(Icons.chevron_right),
      selectedTileColor: Theme.of(context).highlightColor,
      selectedColor: getContrastingTextColor(
        Theme.of(context).highlightColor,
      ),
      selected: index == globalBloc.state.currentIndexMenu,
      onTap: () {
        if (globalBloc.state.currentIndexMenu == index) return;

        globalBloc.add(SelectItemMenuEvent(index));
        Navigator.of(context).pop();
        Navigator.pushAndRemoveUntil(
          context,
          CupertinoPageRoute(
            builder: (_) => pageWidget ?? const PasswordsMainPage(),
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
      child: SafeArea(
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