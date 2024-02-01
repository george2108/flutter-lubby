import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../config/routes/routes.dart';
import '../../core/utils/get_contrasting_text_color.dart';
import '../../features/activities/activities/activities_page.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/config/config_page.dart';
import '../../features/diary/presentation/views/diary_main_page.dart';
import '../../features/finances/presentation/views/finances_main_page.dart';
import '../../features/habits/habits_main_page.dart';
import '../../features/qr_reader/qr_reader/qr_reader_page.dart';
import '../../features/remiders/presentation/views/reminders_main_page.dart';
import '../../features/todos/presentation/views/todo_main_page.dart';
import '../../features/notes/presentation/views/notes_main_page.dart';
import '../../features/passwords/presentation/views/passwords_main_page.dart';
import '../bloc/global/global_bloc.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const _HeaderMenuWidget(),
            _ItemMenuWidget(
              title: 'Gestor de contraseñas',
              icon: Icons.vpn_key,
              iconColor: Colors.orange,
              pageWidget: const PasswordsMainPage(),
              route: Routes().passwords,
              index: 0,
            ),
            _ItemMenuWidget(
              title: 'Notas',
              icon: Icons.note,
              iconColor: Colors.cyan,
              pageWidget: const NotesMainPage(),
              route: Routes().notes,
              index: 1,
            ),
            _ItemMenuWidget(
              title: 'Lista de tareas',
              icon: Icons.check_circle_outline,
              iconColor: Colors.green,
              pageWidget: const TodoMainPage(),
              route: Routes().notes,
              index: 2,
            ),
            _ItemMenuWidget(
              title: 'Agenda',
              icon: Icons.contacts_outlined,
              iconColor: Colors.cyanAccent,
              pageWidget: const DiaryMainPage(),
              route: Routes().notes,
              index: 3,
            ),
            _ItemMenuWidget(
              title: 'Gestor de ingresos y gastos',
              icon: Icons.attach_money,
              iconColor: Colors.green,
              pageWidget: const FinancesMainPage(),
              route: Routes().notes,
              index: 4,
            ),
            _ItemMenuWidget(
              title: 'Organizador de actividades',
              icon: Icons.table_restaurant,
              iconColor: Colors.orange,
              pageWidget: const ActivitiesPage(),
              route: Routes().notes,
              index: 5,
            ),
            _ItemMenuWidget(
              title: 'Recordatorios',
              icon: Icons.notification_add_outlined,
              iconColor: Colors.purpleAccent,
              pageWidget: const RemindersMainPage(),
              // pageWidget: LocalNotificationsExamplePage(),
              route: Routes().notes,
              index: 6,
            ),
            _ItemMenuWidget(
              title: 'Lector de QRs',
              icon: Icons.qr_code_2,
              iconColor: Colors.black,
              pageWidget: const QRReaderPage(),
              route: Routes().notes,
              index: 7,
            ),
            _ItemMenuWidget(
              title: 'Mejorar habitos',
              icon: Icons.fitness_center,
              iconColor: Colors.black,
              pageWidget: const HabitsMainPage(),
              route: Routes().notes,
              index: 8,
            ),
            const SizedBox(height: 25),
            _ItemMenuWidget(
              title: 'configuración',
              icon: Icons.settings,
              iconColor: Colors.blueAccent,
              pageWidget: const ConfigPage(),
              route: Routes().notes,
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
  final IRoute route;
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
        // Navigator.of(context).pop();
        /* Navigator.pushAndRemoveUntil(
          context,
          CupertinoPageRoute(
            builder: (_) => pageWidget ?? const PasswordsMainPage(),
            settings: RouteSettings(name: route),
          ),
          (route) => false,
        ); */
        context.go(route.path);
      },
    );
  }
}

class _HeaderMenuWidget extends StatelessWidget {
  const _HeaderMenuWidget();

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context, listen: false);

    return Container(
      color: const Color(0xFF227c9d),
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      width: double.infinity,
      child: SafeArea(
        child: Column(
          children: [
            const CircleAvatar(
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
            const SizedBox(height: 15.0),
            const Text('Luby'),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: const Text(
                'Tu asistente personal',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            if (!authBloc.state.authenticated)
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(loginRoute);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  margin: const EdgeInsets.only(top: 10),
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                  ),
                  child: const Text('iniciar sesión'),
                ),
              ),
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