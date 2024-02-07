import 'package:flutter/material.dart';

import '../../../config/routes/routes.dart';
import '../../../features/activities/activities/activities_page.dart';
import '../../../features/config/config_page.dart';
import '../../../features/diary/presentation/views/diary_main_page.dart';
import '../../../features/finances/presentation/views/finances_main_page.dart';
import '../../../features/habits/habits_main_page.dart';
import '../../../features/qr_reader/qr_reader/qr_reader_page.dart';
import '../../../features/remiders/presentation/views/reminders_main_page.dart';
import '../../../features/todos/presentation/views/todo_main_page.dart';
import '../../../features/notes/presentation/views/notes_main_page.dart';
import '../../../features/passwords/presentation/views/passwords_main_page.dart';
import 'header_menu_drawer_widget.dart';
import 'item_menu_drawer_widget.dart';

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
          const HeaderMenuDrawerWidget(),
          ItemMenuDrawerWidget(
            title: 'Gestor de contraseñas',
            icon: Icons.vpn_key,
            pageWidget: const PasswordsMainPage(),
            route: Routes().passwords,
            navigationString: Routes().passwords.name,
          ),
          ItemMenuDrawerWidget(
            title: 'Notas',
            icon: Icons.note,
            pageWidget: const NotesMainPage(),
            route: Routes().notes,
            navigationString: Routes().notes.name,
          ),
          ItemMenuDrawerWidget(
            title: 'Lista de tareas',
            icon: Icons.check_circle_outline,
            pageWidget: const TodoMainPage(),
            route: Routes().toDos,
            navigationString: Routes().toDos.name,
          ),
          ItemMenuDrawerWidget(
            title: 'Agenda',
            icon: Icons.contacts_outlined,
            pageWidget: const DiaryMainPage(),
            route: Routes().diary,
            navigationString: Routes().diary.name,
          ),
          ItemMenuDrawerWidget(
            title: 'Gestor de ingresos y gastos',
            icon: Icons.attach_money,
            pageWidget: const FinancesMainPage(),
            route: Routes().finances,
            navigationString: Routes().finances.name,
          ),
          ItemMenuDrawerWidget(
            title: 'Organizador de actividades',
            icon: Icons.table_restaurant,
            pageWidget: const ActivitiesPage(),
            route: Routes().activities,
            navigationString: Routes().activities.name,
          ),
          ItemMenuDrawerWidget(
            title: 'Recordatorios',
            icon: Icons.notification_add_outlined,
            pageWidget: const RemindersMainPage(),
            // pageWidget: LocalNotificationsExamplePage(),
            route: Routes().reminders,
            navigationString: Routes().reminders.name,
          ),
          ItemMenuDrawerWidget(
            title: 'Lector de QRs',
            icon: Icons.qr_code_2,
            pageWidget: const QRReaderPage(),
            route: Routes().qrReader,
            navigationString: Routes().qrReader.name,
          ),
          ItemMenuDrawerWidget(
            title: 'Mejorar habitos',
            icon: Icons.fitness_center,
            pageWidget: const HabitsMainPage(),
            route: Routes().habits,
            navigationString: Routes().habits.name,
          ),
          const SizedBox(height: 25),
          ItemMenuDrawerWidget(
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