part of '../todo_main_page.dart';

class TodosListView extends StatelessWidget {
  const TodosListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<TodosBloc>(context, listen: true);
    return BlocBuilder<TodosBloc, TodosState>(
      builder: (context, state) {
        if (bloc.state.loadingTodosLists) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final todosLists = bloc.state.todosLists;

        if (todosLists.isEmpty) {
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
          itemCount: todosLists.length,
          itemBuilder: (context, index) {
            final todo = todosLists[index];
            return TodosDetailCardWidget(
              data: todo,
            );
          },
        );
      },
    );
  }
}
