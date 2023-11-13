import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../bloc/reminders_bloc.dart';
import '../../../../ui/widgets/menu_drawer.dart';

part 'apps_remiders_page_item.dart';
part 'custom_remiders_page_item.dart';

class RemindersMainPage extends StatelessWidget {
  const RemindersMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RemindersBloc(),
      child: const _BuildPage(),
    );
  }
}

class _BuildPage extends StatelessWidget {
  const _BuildPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<RemindersBloc>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recordatorios'),
      ),
      drawer: const Menu(),
      body: IndexedStack(
        index: bloc.state.index,
        children: const [
          CustomRemindersPageItem(),
          AppsRemindersPageItem(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Nuevo recordatorio'),
        icon: const Icon(Icons.add),
        onPressed: () {},
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: bloc.state.index,
        onTap: (index) {
          bloc.add(ChangePageEvent(index));
        },
        items: [
          SalomonBottomBarItem(
            icon: const Icon(Icons.add_alarm_outlined),
            title: const Text('Personalizados'),
            selectedColor: Theme.of(context).indicatorColor,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.apps_sharp),
            title: const Text('Otros'),
            selectedColor: Theme.of(context).indicatorColor,
          ),
        ],
      ),
    );
  }
}
