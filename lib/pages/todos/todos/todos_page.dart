import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lubby_app/models/todo_model.dart';
import 'package:lubby_app/pages/todos/todo/todo_page.dart';
import 'package:lubby_app/pages/todos/todos/bloc/todos_bloc.dart';
import 'package:lubby_app/widgets/menu_drawer.dart';
import 'package:lubby_app/widgets/no_data_widget.dart';
import 'package:lubby_app/widgets/percent_indicator_widget.dart';
import 'package:lubby_app/widgets/sliver_no_data_screen_widget.dart';

part 'widgets/todos_detail_card_widget.dart';
part 'widgets/todos_data_screen_widget.dart';

class TodosPage extends StatelessWidget {
  const TodosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodosBloc()
        ..add(
          TodosLoadDataEvent(),
        ),
      child: Scaffold(
        drawer: Menu(),
        body: BlocBuilder<TodosBloc, TodosState>(
          builder: (context, state) {
            if (state.loading) {
              return const SliverNoDataScreenWidget(
                appBarTitle: 'Mis listas de tareas',
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            final todos = state.todos;
            if (todos.length == 0) {
              return const SliverNoDataScreenWidget(
                appBarTitle: 'Mis listas de tareas',
                child: NoDataWidget(
                  text: 'No tienes listas de tareas aún, crea una',
                  lottie: 'assets/todo.json',
                ),
              );
            }

            return NotificationListener<UserScrollNotification>(
              onNotification: ((notification) {
                if (notification.direction == ScrollDirection.forward) {
                  context.read<TodosBloc>().add(TodosShowFabEvent(true));
                } else if (notification.direction == ScrollDirection.reverse) {
                  context.read<TodosBloc>().add(TodosShowFabEvent(false));
                }

                return true;
              }),
              child: TodosDataScreenWidget(todos: todos),
            );
          },
        ),
        floatingActionButton: BlocBuilder<TodosBloc, TodosState>(
          builder: (context, state) {
            return AnimatedSlide(
              duration: const Duration(milliseconds: 300),
              curve: Curves.decelerate,
              offset: state.showFab ? Offset.zero : const Offset(0, 2),
              child: FloatingActionButton.extended(
                label: const Text('Nueva lista de tareas'),
                icon: const Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: ((_, animation, __) => FadeTransition(
                            opacity: animation,
                            child: const TodoPage(),
                          )),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
