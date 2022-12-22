import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import 'package:lubby_app/src/ui/pages/todos/bloc/todos_bloc.dart';
import 'package:lubby_app/src/ui/pages/todos/views/todo/todo_page.dart';
import 'package:lubby_app/src/ui/widgets/calendar_row/date_picker_widget.dart';

import 'package:lubby_app/src/ui/widgets/menu_drawer.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../core/constants/constants.dart';
import '../../../data/datasources/local/services/todos_local_service.dart';
import '../../../data/entities/todo_entity.dart';
import '../../widgets/no_data_widget.dart';
import '../../widgets/percent_indicator_widget.dart';

part 'views/tasks_page_item.dart';
part 'views/todos_lists_page_item.dart';
part 'views/menu_page_item.dart';
part 'widgets/todos_alert_title_widget.dart';
part 'widgets/todos_data_screen_widget.dart';
part 'widgets/todos_detail_card_widget.dart';

class TodoMainPage extends StatelessWidget {
  const TodoMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodosBloc()..add(TodosLoadDataEvent()),
      child: const _BuildPage(),
    );
  }
}

class _BuildPage extends StatelessWidget {
  const _BuildPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<TodosBloc>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis tareas'),
      ),
      drawer: const Menu(),
      body: IndexedStack(
        index: bloc.state.index,
        children: const [
          TasksPageItem(),
          TodosPage(),
          MenuPageItem(),
        ],
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: bloc.state.index,
        onTap: (value) {
          bloc.add(ChangePageEvent(value));
        },
        items: [
          SalomonBottomBarItem(
            icon: const Icon(Icons.task_outlined),
            title: const Text("Tareas"),
            selectedColor: Theme.of(context).indicatorColor,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.list_alt_outlined),
            title: const Text("Listas"),
            selectedColor: Theme.of(context).indicatorColor,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.menu),
            title: const Text("Menú"),
            selectedColor: Theme.of(context).indicatorColor,
          ),
        ],
      ),
      /* bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 20,
              spreadRadius: 0.5,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: bloc.state.index,
          onTap: (value) {
            bloc.add(ChangePageEvent(value));
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.task_outlined),
              label: 'Tareas',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt_outlined),
              label: 'Listas',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: 'Menú',
            ),
          ],
        ),
      ), */
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Nueva lista de tarea'),
        icon: const Icon(Icons.add),
        onPressed: () {
          if (bloc.state.index == 0) {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (_) => const CreateTaskWidget(),
            );
          } else {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) {
                return TodosAlertTitleWidget(
                  blocContext: context,
                );
              },
            );
          }
        },
      ),
    );
  }
}
