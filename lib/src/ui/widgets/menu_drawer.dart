import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../config/routes/routes.dart';
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
import '../bloc/navigation/navigation_bloc.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return const Drawer(
      child: MenuDrawerContent(),
    );
  }
}

class MenuDrawerContent extends StatelessWidget {
  const MenuDrawerContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const _HeaderMenuWidget(),
          _ItemMenuWidget(
            title: 'Gestor de contraseñas',
            icon: Icons.vpn_key,
            pageWidget: const PasswordsMainPage(),
            route: Routes().passwords,
            navigationString: Routes().passwords.name,
          ),
          _ItemMenuWidget(
            title: 'Notas',
            icon: Icons.note,
            pageWidget: const NotesMainPage(),
            route: Routes().notes,
            navigationString: Routes().notes.name,
          ),
          _ItemMenuWidget(
            title: 'Lista de tareas',
            icon: Icons.check_circle_outline,
            pageWidget: const TodoMainPage(),
            route: Routes().toDos,
            navigationString: Routes().toDos.name,
          ),
          _ItemMenuWidget(
            title: 'Agenda',
            icon: Icons.contacts_outlined,
            pageWidget: const DiaryMainPage(),
            route: Routes().diary,
            navigationString: Routes().diary.name,
          ),
          _ItemMenuWidget(
            title: 'Gestor de ingresos y gastos',
            icon: Icons.attach_money,
            pageWidget: const FinancesMainPage(),
            route: Routes().finances,
            navigationString: Routes().finances.name,
          ),
          _ItemMenuWidget(
            title: 'Organizador de actividades',
            icon: Icons.table_restaurant,
            pageWidget: const ActivitiesPage(),
            route: Routes().activities,
            navigationString: Routes().activities.name,
          ),
          _ItemMenuWidget(
            title: 'Recordatorios',
            icon: Icons.notification_add_outlined,
            pageWidget: const RemindersMainPage(),
            // pageWidget: LocalNotificationsExamplePage(),
            route: Routes().reminders,
            navigationString: Routes().reminders.name,
          ),
          _ItemMenuWidget(
            title: 'Lector de QRs',
            icon: Icons.qr_code_2,
            pageWidget: const QRReaderPage(),
            route: Routes().qrReader,
            navigationString: Routes().qrReader.name,
          ),
          _ItemMenuWidget(
            title: 'Mejorar habitos',
            icon: Icons.fitness_center,
            pageWidget: const HabitsMainPage(),
            route: Routes().habits,
            navigationString: Routes().habits.name,
          ),
          const SizedBox(height: 25),
          _ItemMenuWidget(
            title: 'configuración',
            icon: Icons.settings,
            pageWidget: const ConfigPage(),
            route: Routes().config,
            navigationString: Routes().config.name,
          ),
        ],
      ),
    );
  }
}

BorderRadius borderRadius = BorderRadius.circular(10);

class _ItemMenuWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final IRoute route;
  final Widget? pageWidget;
  final String navigationString;

  final double margin = 6;

  const _ItemMenuWidget({
    required this.title,
    required this.icon,
    required this.route,
    required this.navigationString,
    this.pageWidget,
  });

  @override
  Widget build(BuildContext context) {
    final navigationBloc = BlocProvider.of<NavigationBloc>(
      context,
      listen: false,
    );

    return BlocBuilder<NavigationBloc, String>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: margin,
            vertical: margin / 2,
          ),
          child: InkWell(
            borderRadius: borderRadius,
            onTap: () {
              if (state == navigationString) return;

              navigationBloc.add(ChangeNavigationEvent(item: navigationString));

              context.go(route.path);
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: state == navigationString
                    ? Theme.of(context).highlightColor
                    : Colors.transparent,
                borderRadius: borderRadius,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(icon),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Icon(Icons.chevron_right)
                ],
              ),
            ),
          ),
        );
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.password),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.notifications),
                      ),
                      PopupMenuButton(
                        child: const Icon(Icons.account_circle_outlined),
                        itemBuilder: (_) => [
                          const PopupMenuItem(child: Text('settings')),
                        ],
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.account_circle_outlined),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
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
            if (authBloc.state.user?.email != null)
              Text(authBloc.state.user?.email ?? ''),
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
                  context.push(Routes().login.path);
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