import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lubby_app/src/data/entities/todo_entity.dart';
import 'package:lubby_app/src/ui/widgets/show_color_picker_widget.dart';
import '../bloc/todos_bloc.dart';
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
  bool favorite = false;

  @override
  void initState() {
    super.initState();
    favorite = widget.toDo.favorite;
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<TodosBloc>(widget.todoContext, listen: false);
    final blocListening =
        BlocProvider.of<TodosBloc>(widget.todoContext, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi tarea'),
        actions: [
          PopupMenuButton(
            itemBuilder: (_) => [
              PopupMenuItem(
                value: 'color',
                child: Row(
                  children: const [
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
                  children: const [
                    Icon(Icons.help_outline),
                    SizedBox(width: 5),
                    Text('Ayuda', textAlign: TextAlign.start),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'eliminar',
                child: Row(
                  children: const [
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
                    color: blocListening.state.taskLoaded?.color,
                  );
                  final colorPicked = await pickColor.showDialogPickColor();
                  if (colorPicked != null) {
                    blocListening.add(TodoChangeColorEvent(colorPicked));
                  }
                  break;
                default:
                  break;
              }
            },
          ),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Lista de tareas (${blocListening.state.taskDetailsLoaded.length})',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    icon: const Icon(Icons.add_circle_outline_sharp),
                    label: const Text('Agregar tarea'),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (_) => const CreateTaskWidget(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ReorderableListView(
              physics: const BouncingScrollPhysics(),
              onReorder: (oldIndex, newIndex) {
                blocListening.add(TodoReorderDetailEvent(newIndex, oldIndex));
              },
              children: List.generate(
                widget.todoContext
                    .watch<TodosBloc>()
                    .state
                    .taskDetailsLoaded
                    .length,
                (index) {
                  return ListTile(
                    key: Key('$index'),
                    title: Text(
                      context
                          .watch<TodosBloc>()
                          .state
                          .taskDetailsLoaded[index]
                          .title,
                    ),
                    leading: IconButton(
                      icon: context
                                  .watch<TodosBloc>()
                                  .state
                                  .taskDetailsLoaded[index]
                                  .complete ==
                              1
                          ? const Icon(Icons.check_box)
                          : const Icon(Icons.check_box_outline_blank),
                      onPressed: () {
                        blocListening.add(TodoMarkCheckDetailEvent(index));
                      },
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.close_rounded),
                      onPressed: () {
                        blocListening.add(TodoDeleteDetailEvent(index));
                      },
                    ),
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (_) => const CreateTaskWidget(),
                      );
                      /*  _addTask(
                        context: context,
                        index: index,
                        description: BlocProvider.of<TodoBloc>(context)
                            .state
                            .toDoDetails[index]
                            .description,
                      ); */
                    },
                  );
                },
              ),
            ),
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
    final formKey = GlobalKey<FormState>();
    final TextEditingController itemController = TextEditingController(
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
            key: formKey,
            child: TextFormField(
              controller: itemController,
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
                if (formKey.currentState!.validate()) {
                  if (index != null) {
                    BlocProvider.of<TodosBloc>(context).add(
                      TodoEditDetailEvent(
                        index,
                        itemController.text.toString(),
                      ),
                    );
                  } else {
                    BlocProvider.of<TodosBloc>(context).add(
                      TodoAddTaskEvent(itemController.text.toString()),
                    );
                  }
                  formKey.currentState!.reset();
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
