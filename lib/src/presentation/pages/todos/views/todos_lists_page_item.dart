part of '../todo_main_page.dart';

class TodosPage extends StatelessWidget {
  const TodosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<TodosBloc>(context, listen: true);
    return BlocBuilder<TodosBloc, TodosState>(
      builder: (context, state) {
        if (bloc.state.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final todos = bloc.state.todos;

        if (todos.isEmpty) {
          return const NoDataWidget(
            text: 'No tienes listas de tareas aún, crea una',
            lottie: 'assets/todo.json',
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 5.0,
          ),
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemCount: todos.length,
          itemBuilder: (context, index) {
            final todo = todos[index];
            return TodosDetailCardWidget(
              data: todo,
            );
          },
        );
      },
    );
  }
}
