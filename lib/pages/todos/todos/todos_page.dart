import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lubby_app/models/todo_model.dart';
import 'package:lubby_app/pages/todos/todo/todo_page.dart';
import 'package:lubby_app/pages/todos/todos/bloc/todos_bloc.dart';
import 'package:lubby_app/widgets/menu_drawer.dart';
import 'package:lubby_app/widgets/no_data_widget.dart';
import 'package:lubby_app/widgets/percent_indicator_widget.dart';

part 'widgets/todos_detail_card_widget.dart';

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
        appBar: AppBar(
          title: const Text('Mis listas de tareas'),
          actions: [
            IconButton(
              icon: const Icon(Icons.help_outline_outlined),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.filter_list_outlined),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
          ],
        ),
        drawer: Menu(),
        body: BlocBuilder<TodosBloc, TodosState>(
          builder: (context, state) {
            if (state is TodosLoadedState) {
              final todos = state.todos;
              if (todos.length == 0) {
                return const NoDataWidget(
                  text: 'No tienes listas de tareas aún, crea una',
                  lottie: 'assets/todo.json',
                );
              }

              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: todos.length,
                padding: const EdgeInsets.only(
                  bottom: 100,
                  left: 10,
                  right: 10,
                  top: 10,
                ),
                itemBuilder: (context, index) {
                  return TodosDetailCardWidget(
                    data: todos[index],
                  );
                },
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
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
      ),
    );
  }
}
