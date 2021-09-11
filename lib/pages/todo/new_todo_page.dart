import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:lubby_app/db/database_provider.dart';

import 'package:lubby_app/models/todo_model.dart';
import 'package:lubby_app/pages/todo/todo_page.dart';

class NewToDo extends StatefulWidget {
  @override
  _NewToDoState createState() => _NewToDoState();
}

class _NewToDoState extends State<NewToDo> {
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController itemController = TextEditingController();

  final List<ToDoDetailModel> items = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Nueva tarea'),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
            child: TextField(
              controller: tituloController,
              maxLines: 1,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                labelText: 'Titulo',
                hintText: "Tutulo para las tareas",
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: TextField(
              controller: descriptionController,
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
          ),
          SizedBox(height: 10),
          Text(
            items.length > 0
                ? 'Lista de tareas'
                : 'No tiene tareas, agregué una',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                MaterialButton(
                  child: Text(
                    '+ Agregar tarea',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  color: Colors.red,
                  elevation: 0,
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    _addTask(context);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(items[index].description),
                  leading: Icon(Icons.circle, color: Colors.green),
                );
              },
            ),
          ),
          _buttonSave(context, size.width * 0.8),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  _buttonSave(BuildContext context, double width) {
    return ArgonButton(
      height: 50,
      width: width,
      child: Text(
        'Guardar',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      borderRadius: 5.0,
      color: Theme.of(context).primaryColor,
      loader: Container(
        padding: EdgeInsets.all(10),
        child: CircularProgressIndicator(
          backgroundColor: Colors.red,
        ),
      ),
      onTap: (startLoading, stopLoading, btnState) async {
        if (btnState == ButtonState.Idle) {
          startLoading();

          await _saveToDo();

          stopLoading();
          Navigator.pushAndRemoveUntil(
            context,
            CupertinoPageRoute(
              builder: (BuildContext context) => ToDoPage(),
            ),
            (route) => false,
          );
        }
      },
    );
  }

  Future<void> _saveToDo() async {
    ToDoModel toDo = ToDoModel(
      title: tituloController.text.toString(),
      description: descriptionController.text.toString(),
      complete: 0,
      createdAt: DateTime.now(),
    );
    await DatabaseProvider.db.addNewToDo(toDo, items);
  }

  _addTask(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Nuevo item'),
          content: TextField(
            controller: itemController,
            maxLines: 1,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'Descripción',
              hintText: "Descripción de la tarea",
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Guardar'),
              onPressed: () {
                ToDoDetailModel detail = ToDoDetailModel(
                  description: itemController.text.toString(),
                  complete: 0,
                  orderDetail: this.items.length + 1,
                );
                this.items.add(detail);
                this.itemController.clear();
                setState(() {});
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
