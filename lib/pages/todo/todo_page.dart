import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';

import 'package:lubby_app/models/todo_model.dart';
import 'package:lubby_app/pages/todo/new_todo_page.dart';
import 'package:lubby_app/pages/todo/todo_controller.dart';
import 'package:lubby_app/pages/todo/type_filter_enum.dart';
import 'package:lubby_app/widgets/menu_drawer.dart';
import 'package:lubby_app/widgets/no_data_widget.dart';

class ToDoPage extends StatefulWidget {
  @override
  _ToDoPageState createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  final _toDoController = Get.find<ToDoController>();

  @override
  void initState() {
    _toDoController.getTasks(TypeFilter.enProceso);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tareas'),
        actions: [
          _TaskFilter(
            controller: _toDoController,
          ),
        ],
      ),
      drawer: Menu(),
      body: Obx(
        () => !_toDoController.loading.value
            ? _tasks()
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            CupertinoPageRoute(
              builder: (context) => NewToDo(),
            ),
          );
        },
      ),
    );
  }

  Widget _tasks() {
    return _toDoController.tasks.length > 0
        ? ListView.builder(
            padding: EdgeInsets.all(12),
            physics: BouncingScrollPhysics(),
            itemCount: _toDoController.tasks.length,
            itemBuilder: (BuildContext context, int index) {
              final task = _toDoController.tasks[index];
              return _Task(data: task, index: index);
            },
          )
        : NoDataWidget(
            text: 'No tienes tareas',
            lottie: 'assets/todo.json',
          );
  }
}

class _Task extends StatelessWidget {
  final ToDoModel data;
  final int index;

  const _Task({
    required this.data,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        /* Navigator.of(context).push(
          CupertinoPageRoute(builder: (_) => DisplayToDoPage(data: data)),
        ); */
      },
      child: FadeInUp(
        duration: Duration(milliseconds: 300),
        delay: Duration(milliseconds: (index * 20) + (50 * index)),
        child: Card(
          color: Colors.red,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      DateTime.parse(data.createdAt.toString()).toString(),
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  data.title,
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 5),
                Text(
                  data.description.toString(),
                  style: Theme.of(context).textTheme.bodyText2,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TaskFilter extends StatelessWidget {
  final ToDoController controller;

  const _TaskFilter({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DropdownButton<String>(
        value: controller.currentFilter.value,
        onChanged: (value) {
          controller.changeFilter(value.toString());
        },
        items: <String>[...controller.filters]
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
