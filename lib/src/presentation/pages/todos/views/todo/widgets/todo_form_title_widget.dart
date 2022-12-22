part of '../todo_page.dart';

class TodoFormTitleWidget extends StatelessWidget {
  const TodoFormTitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<TodoBloc>(context);

    return Form(
      key: bloc.state.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: bloc.state.toDoTitleController,
            maxLines: 1,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              labelText: 'Nombre',
              hintText: "Nombre de la lista de tareas",
            ),
            validator: (value) {
              if (value!.trim().isEmpty) {
                return 'El nombre es requerido';
              }
              return null;
            },
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: bloc.state.toDoDescriptionController,
            maxLines: 1,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              labelText: 'Descripción',
              hintText: "Agrega una descripción",
            ),
          ),
        ],
      ),
    );
  }
}
