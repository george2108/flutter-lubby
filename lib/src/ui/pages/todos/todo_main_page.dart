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

part 'views/tasks_view.dart';
part 'views/todos_lists_view.dart';
part 'views/todo_menu_view.dart';
part 'widgets/todos_alert_title_widget.dart';
part 'widgets/todos_detail_card_widget.dart';

class TodoMainPage extends StatelessWidget {
  const TodoMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodosBloc()
        ..add(GetTodosListsEvent())
        ..add(GetTasksEvent()),
      child: const _BuildPage(),
    );
  }
}

class _BuildPage extends StatefulWidget {
  const _BuildPage({Key? key}) : super(key: key);
  @override
  State<_BuildPage> createState() => _BuildPageState();
}

class _BuildPageState extends State<_BuildPage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis tareas'),
      ),
      drawer: const Menu(),
      body: IndexedStack(
        index: index,
        children: const [
          TasksView(),
          TodosListView(),
          ToDoMenuView(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text(index == 0 ? 'Nueva tarea' : 'Nueva lista de tarea'),
        icon: const Icon(Icons.add),
        onPressed: () async {
          if (index == 0) {
            final result = await showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (_) => const CreateTaskWidget(),
            );
            print(result);
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
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: index,
        onTap: (value) {
          setState(() {
            index = value;
          });
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
    );
  }
}
