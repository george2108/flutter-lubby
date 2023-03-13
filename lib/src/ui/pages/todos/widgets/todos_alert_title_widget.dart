part of '../todo_main_page.dart';

class TodosAlertTitleWidget extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final BuildContext blocContext;

  TodosAlertTitleWidget({
    required this.blocContext,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Agregar nueva lista de tareas',
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: titleController,
              maxLines: 1,
              keyboardType: TextInputType.text,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(
                labelText: 'Titulo',
                hintText: "Titulo de la lista de tareas",
              ),
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return 'El titulo sigue vacio';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: descriptionController,
              maxLines: 1,
              keyboardType: TextInputType.text,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(
                labelText: 'Descripción',
                hintText: "Descripción de la lista de tareas",
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Cancelar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Guardar'),
          onPressed: () async {
            if (!_formKey.currentState!.validate()) {
              return;
            }

            final todoModel = ToDoEntity(
              title: titleController.text.trim(),
              description: descriptionController.text.trim(),
              complete: false,
              createdAt: DateTime.now(),
              percentCompleted: 0,
              totalItems: 0,
              favorite: false,
              color: kDefaultColorPick,
            );

            final inserted = await TodosLocalService.provider.addNewToDo(
              todoModel,
            );

            if (inserted < 1) {
              return;
            }

            // ignore: use_build_context_synchronously
            Navigator.of(context).pop();

            // ignore: use_build_context_synchronously
            blocContext.read<TodosBloc>().add(GetTodosListsEvent());

            // ignore: use_build_context_synchronously
            Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: ((_, animation, __) => FadeTransition(
                      opacity: animation,
                      child: TodoPage(
                        toDo: todoModel.copyWith(id: inserted),
                        todoContext: blocContext,
                      ),
                    )),
              ),
            );
          },
        ),
      ],
    );
  }
}
