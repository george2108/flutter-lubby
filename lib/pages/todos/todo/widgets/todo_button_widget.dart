part of '../todo_page.dart';

class TodoButtonWidget extends StatelessWidget {
  const TodoButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<TodoBloc>(context, listen: false);

    return ButtonSaveWidget(
      title: bloc.state.editing ? 'Guardar lista' : 'Crear lista',
      action: () {
        if (bloc.state.editing) {
          bloc.add(TodoUpdatedEvent());
        } else {
          bloc.add(TodoCreatedEvent());
        }
      },
      loading: false,
    );
  }
}
