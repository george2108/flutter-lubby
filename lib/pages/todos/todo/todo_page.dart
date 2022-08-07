import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lubby_app/core/enums/status_crud_enum.dart';
import 'package:lubby_app/models/todo_model.dart';
import 'package:lubby_app/pages/todos/todo/bloc/todo_bloc.dart';
import 'package:lubby_app/pages/todos/todos/todos_page.dart';
import 'package:lubby_app/widgets/button_save_widget.dart';
import 'package:lubby_app/widgets/show_snackbar_widget.dart';

part 'widgets/todo_form_title_widget.dart';

class TodoPage extends StatelessWidget {
  final ToDoModel? toDo;

  const TodoPage({
    this.toDo,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoBloc(this.toDo),
      child: BlocListener<TodoBloc, TodoState>(
        listener: (context, state) {
          if (state.status == StatusCrudEnum.created) {
            ScaffoldMessenger.of(context).showSnackBar(
              showCustomSnackBarWidget(title: 'Lista de tareas creada.'),
            );
            Navigator.pushAndRemoveUntil(
                context,
                PageRouteBuilder(
                  pageBuilder: ((_, animation, __) => FadeTransition(
                        opacity: animation,
                        child: const TodosPage(),
                      )),
                ),
                (route) => false);
          }
        },
        child: const _BuildPage(),
      ),
    );
  }
}

class _BuildPage extends StatelessWidget {
  const _BuildPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<TodoBloc>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi tarea'),
      ),
      body: Column(
        children: [
          const Padding(
            padding: const EdgeInsets.all(8.0),
            child: const TodoFormTitleWidget(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Lista de tareas (${context.watch<TodoBloc>().state.toDoDetails.length})',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    onPressed: () {
                      _addTask(context: context);
                    },
                    icon: const Icon(Icons.add_circle_outline_sharp),
                    label: const Text('Agregar tarea'),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ReorderableListView(
              physics: const BouncingScrollPhysics(),
              onReorder: (oldIndex, newIndex) {
                bloc.add(TodoReorderDetailEvent(newIndex, oldIndex));
              },
              children: List.generate(
                context.watch<TodoBloc>().state.toDoDetails.length,
                (index) {
                  return ListTile(
                    key: Key('$index'),
                    title: Text(
                      context
                          .watch<TodoBloc>()
                          .state
                          .toDoDetails[index]
                          .description,
                    ),
                    leading: IconButton(
                      icon: context
                                  .watch<TodoBloc>()
                                  .state
                                  .toDoDetails[index]
                                  .complete ==
                              1
                          ? const Icon(Icons.check_box)
                          : const Icon(Icons.check_box_outline_blank),
                      onPressed: () {
                        bloc.add(TodoMarkCheckDetailEvent(index));
                      },
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.close_rounded),
                      onPressed: () {
                        bloc.add(TodoDeleteDetailEvent(index));
                      },
                    ),
                    onTap: () {
                      _addTask(
                        context: context,
                        index: index,
                        description: BlocProvider.of<TodoBloc>(context)
                            .state
                            .toDoDetails[index]
                            .description,
                      );
                    },
                  );
                },
              ),
            ),
          ),
          ButtonSaveWidget(
            title: 'Guardar',
            action: () {
              bloc.add(TodoCreatedEvent());
            },
            loading: false,
          ),
        ],
      ),
    );
  }

  _addTask({
    required BuildContext context,
    int? index,
    String? description,
  }) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _itemController = TextEditingController(
      text: description ?? '',
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: Text(
            index != null ? 'Editar descripción de la tarea' : 'Nueva tarea',
          ),
          content: Form(
            key: _formKey,
            child: TextFormField(
              controller: _itemController,
              maxLines: 1,
              keyboardType: TextInputType.text,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(
                labelText: 'Descripción',
                hintText: "Descripción de la tarea",
              ),
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return 'La tarea sigue vacia';
                }
                return null;
              },
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
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (index != null) {
                    BlocProvider.of<TodoBloc>(context).add(
                      TodoEditDetailEvent(
                        index,
                        _itemController.text.toString(),
                      ),
                    );
                  } else {
                    BlocProvider.of<TodoBloc>(context).add(
                      TodoAddTaskEvent(_itemController.text.toString()),
                    );
                  }
                  _formKey.currentState!.reset();
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
