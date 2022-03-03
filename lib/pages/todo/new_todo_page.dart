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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva tarea'),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
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
                  MaterialButton(
                    child: Text(
                      '+ Agregar tarea',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    color: Colors.red,
                    elevation: 0,
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      _addTask(context, _todoProvider);
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(
              _todoProvider.items.length > 0
                  ? 'Lista de tareas'
                  : 'No tiene tareas, agregué una',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: _todoProvider.items.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(_todoProvider.items[index].description),
                  leading: const Icon(Icons.circle, color: Colors.green),
                );
              },
            ),
          ),
          _buttonSave(context, size.width, _todoProvider),
        ],
      ),
    );
  }

  _buttonSave(BuildContext context, double width, ToDoProvider provider) {
    return ArgonButton(
      height: 50,
      width: width,
      child: const Text(
        'Guardar',
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
            }
            showSnackBarWidget(
                title: 'Tareas vacias',
                message: 'La lista de tareas sigue vacia');
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
