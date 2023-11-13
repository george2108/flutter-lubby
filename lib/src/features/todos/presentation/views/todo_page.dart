import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/todo_entity.dart';
import '../bloc/todos_bloc.dart';
import '../../../../ui/widgets/show_color_picker_widget.dart';
import '../widgets/create_task_widget.dart';

class TodoPage extends StatefulWidget {
  final ToDoEntity toDo;
  final BuildContext todoContext;

  const TodoPage({
    required this.toDo,
    required this.todoContext,
    Key? key,
  }) : super(key: key);

  @override
  State<TodoPage> createState() => _TodoPageState();
}

////////////////////////////////////////////////////////////////////////////////
class _TodoPageState extends State<TodoPage> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  bool favorite = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.toDo.title);
    _descriptionController = TextEditingController(
      text: widget.toDo.description,
    );
    favorite = widget.toDo.favorite;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final blocListening = BlocProvider.of<TodosBloc>(
      widget.todoContext,
      listen: true,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi tarea'),
        actions: [
          TextButton.icon(
            icon: const Icon(Icons.check),
            label: const Text('Guardar'),
            onPressed: () {},
          ),
          _optionsPopup(blocListening),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _titleController,
                    maxLines: 1,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
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
                    controller: _descriptionController,
                    maxLines: 1,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Descripción',
                      hintText: "Agrega una descripción",
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: blocListening.state.taskDetailsLoaded.isEmpty
                ? const Center(
                    child: Text('No hay tareas aún, agrega una!'),
                  )
                : _listTasksReorderable(blocListening),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Agregar tarea'),
        icon: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (_) => const CreateTaskWidget(),
          );
        },
      ),
    );
  }

  //////////////////////////////////////////////////////////////////////////////
  ///
  /// Widget que muestra la lista de tareas
  ///
  //////////////////////////////////////////////////////////////////////////////
  Widget _listTasksReorderable(TodosBloc bloc) {
    return ReorderableListView(
      onReorder: (oldIndex, newIndex) {
        bloc.add(TodoReorderDetailEvent(newIndex, oldIndex));
      },
      children: List.generate(
        bloc.state.taskDetailsLoaded.length,
        (index) {
          return ListTile(
            key: Key('$index'),
            title: Text(
              bloc.state.taskDetailsLoaded[index].title,
            ),
            leading: IconButton(
              icon: bloc.state.taskDetailsLoaded[index].complete
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
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (_) => const CreateTaskWidget(),
              );
            },
          );
        },
      ),
    );
  }

  //////////////////////////////////////////////////////////////////////////////
  ///
  /// Widget que muestra las opciones de la lista de tareas
  ///
  //////////////////////////////////////////////////////////////////////////////
  Widget _optionsPopup(TodosBloc bloc) {
    return PopupMenuButton(
      itemBuilder: (_) => const [
        PopupMenuItem(
          value: 'color',
          child: Row(
            children: [
              Icon(Icons.color_lens_outlined),
              SizedBox(width: 5),
              Text(
                'Color de lista',
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'ayuda',
          child: Row(
            children: [
              Icon(Icons.help_outline),
              SizedBox(width: 5),
              Text('Ayuda', textAlign: TextAlign.start),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'eliminar',
          child: Row(
            children: [
              Icon(Icons.delete_outline),
              SizedBox(width: 5),
              Text('Eliminar lista'),
            ],
          ),
        ),
      ],
      onSelected: (value) async {
        switch (value) {
          case 'color':
            final pickColor = ShowColorPickerWidget(
              context: context,
              color: bloc.state.taskLoaded?.color,
            );
            final colorPicked = await pickColor.showDialogPickColor();
            if (colorPicked != null) {
              bloc.add(TodoChangeColorEvent(colorPicked));
            }
            break;
          default:
            break;
        }
      },
    );
  }
}
