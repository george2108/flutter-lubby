import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';

import 'package:lubby_app/models/todo_model.dart';
import 'package:lubby_app/pages/todo/todo_page.dart';
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
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Container(height: 230),
                        Container(
                          padding: const EdgeInsets.only(
                            left: 15,
                            right: 15,
                            bottom: 80,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                          ),
                          child: _buildDate(
                            fechaString,
                            context,
                            _todoProvider,
                          ),
                        ),
                        Positioned(
                          left: 25,
                          right: 25,
                          bottom: 0,
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Theme.of(context).canvasColor,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(15),
                              ),
                              boxShadow: [
                                const BoxShadow(
                                  color: Colors.black38,
                                  blurRadius: 5,
                                  offset: Offset(5, 5),
                                ),
                              ],
                            ),
                            child: Form(
                              key: _mainFormKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextFormField(
                                    controller: _tituloController,
                                    maxLines: 1,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
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
                                  const SizedBox(height: 8),
                                  TextFormField(
                                    controller: _descriptionController,
                                    maxLines: 1,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      labelText: 'Descripción',
                                      hintText: "Agrega una descripción",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // _buildDate(fechaString, context, _todoProvider),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Center(
                      child: Text(
                        _todoProvider.items.length > 0
                            ? 'Lista de tareas'
                            : 'No tiene tareas, agregué una',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
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
          _buttonSave(context, size.width, _todoProvider),
        ],
      ),
    );
  }

  Container _buildDate(
      String fechaString, BuildContext context, ToDoProvider _todoProvider) {
    return Container(
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

          try {
            if (_mainFormKey.currentState!.validate()) {
              if (provider.items.length > 0) {
                // calcular el porcentaje completado de la tarea.
                final cantidad = provider.items.length;
                final itemsCompletados =
                    provider.items.map((e) => e.complete > 0 ? 1 : 0);
                final cantidadCompletada = itemsCompletados
                    .reduce((value, element) => value + element);
                final porcentaje = cantidadCompletada > 0
                    ? (cantidadCompletada * 100 / cantidad).round()
                    : 0;
                await provider.saveToDo(ToDoModel(
                  title: _tituloController.text.toString(),
                  description: _descriptionController.text.toString(),
                  complete: 0,
                  createdAt: DateTime.now(),
                  percentCompleted: porcentaje,
                ));
                // TODO: alerta cuando se guarda
                ScaffoldMessenger.of(context).showSnackBar(
                  showCustomSnackBarWidget(
                    title: 'Lista de tareas guardada',
                    content: 'La lista de tareas se ha guardado correctamente.',
                  ),
                );
                Navigator.pushAndRemoveUntil(
                  context,
                  CupertinoPageRoute(builder: (_) => ToDoPage()),
                  (route) => false,
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  showCustomSnackBarWidget(
                    title: '¡Tareas vacías!',
                    content:
                        'La lista de tareas sigue vacía, agrega una para continuar.',
                    type: TypeSnackbar.warning,
                    duration: const Duration(seconds: 3),
                  ),
                );
              }
            }
          } catch (e) {
            print(e);
            stopLoading();
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
