import 'package:flutter/material.dart';

import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';

import 'package:lubby_app/models/todo_model.dart';
import 'package:lubby_app/providers/todo_provider.dart';
import 'package:lubby_app/widgets/show_snackbar_widget.dart';
import 'package:provider/provider.dart';

class NewToDoPage extends StatelessWidget {
  final _mainFormKey = GlobalKey<FormState>();

  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _todoProvider = Provider.of<ToDoProvider>(context);
    final size = MediaQuery.of(context).size;
    final fecha = DateTime.now();
    final fechaString =
        '${fecha.day.toString().padLeft(2, '0')}/${fecha.month.toString().padLeft(2, '0')}/${fecha.year.toString()}';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva lista de tareas'),
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Hoy',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(fechaString),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    _addTask(context, _todoProvider);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.add_circle_outline_outlined,
                        ),
                        const SizedBox(width: 5),
                        const Text(
                          'Nueva tarea',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    child: Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                            left: 8,
                            right: 8,
                            top: 8,
                            bottom: 40,
                          ),
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Theme.of(context).cardColor
                                    : Theme.of(context).primaryColor,
                          ),
                          child: Form(
                            key: _mainFormKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _tituloController,
                                  maxLines: 1,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    labelText: 'Titulo',
                                    hintText: "Tutulo para las tareas",
                                  ),
                                  validator: (value) {
                                    if (value!.trim().isEmpty) {
                                      return 'El titulo es requerido';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 8),
                                TextFormField(
                                  controller: _descriptionController,
                                  maxLines: 1,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    labelText: 'Descripcion',
                                    hintText: "Agrega una descripción",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 30,
                            // color: Theme.of(context).primaryColor,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                              color: Theme.of(context).canvasColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Text(
                      _todoProvider.items.length > 0
                          ? 'Lista de tareas'
                          : 'No tiene tareas, agregué una',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: _todoProvider.items.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Checkbox(
                                    value:
                                        _todoProvider.items[index].complete == 0
                                            ? false
                                            : true,
                                    onChanged: (value) {
                                      _todoProvider.checkTask(index, value!);
                                    },
                                  ),
                                  const SizedBox(width: 5),
                                  Text(_todoProvider.items[index].description),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                _todoProvider.removeTaskFromTasks(index);
                              },
                              icon: const Icon(Icons.close_outlined),
                            ),
                          ],
                        ),
                      );
                      /* return ListTile(
                        contentPadding: EdgeInsets.all(5),
                        title: Text(_todoProvider.items[index].description),
                        leading: const Icon(
                          Icons.check_box_outline_blank_outlined,
                          color: Colors.green,
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            _todoProvider.removeTaskFromTasks(index);
                          },
                          icon: const Icon(Icons.close_outlined),
                        ),
                      ); */
                    },
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: !_todoProvider.editing,
            child: _buttonSave(context, size.width, _todoProvider),
          )
        ],
      ),
    );
  }

  _buttonSave(BuildContext context, double width, ToDoProvider provider) {
    return ArgonButton(
      height: 50,
      width: width,
      child: const Text(
        'Crear tarea',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      borderRadius: 5.0,
      color: Theme.of(context).buttonColor,
      loader: Container(
        padding: const EdgeInsets.all(10),
        child: const CircularProgressIndicator(
          backgroundColor: Colors.red,
        ),
      ),
      onTap: (startLoading, stopLoading, btnState) async {
        if (btnState == ButtonState.Idle) {
          startLoading();

          if (_mainFormKey.currentState!.validate()) {
            if (provider.items.length > 0) {
              await provider.saveToDo(ToDoModel(
                title: _tituloController.text.toString(),
                description: _descriptionController.text.toString(),
                complete: 0,
                createdAt: DateTime.now(),
              ));
              // TODO: alerta cuando se guarda
              Navigator.pop(context);
            } else {
              showSnackBarWidget(
                  title: 'Tareas vacias',
                  message: 'La lista de tareas sigue vacia');
            }
          }

          stopLoading();
        }
      },
    );
  }

  _addTask(BuildContext context, ToDoProvider provider) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _itemController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Nuevo item'),
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
                  ToDoDetailModel detail = ToDoDetailModel(
                    description: _itemController.text.toString(),
                    complete: 0,
                    orderDetail: provider.items.length + 1,
                  );
                  provider.items.add(detail);
                  _itemController.clear();
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
