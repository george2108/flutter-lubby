import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:lubby_app/db/database_provider.dart';
import 'package:lubby_app/pages/todo/display_todo_page.dart';

import 'package:lubby_app/pages/todo/new_todo_page.dart';
import 'package:lubby_app/widgets/menu_drawer.dart';

class ToDoPage extends StatelessWidget {
  Future<Map<String, dynamic>> getTasks() async {
    final toDos = await DatabaseProvider.db.getAllTasks();
    return toDos;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tareas'),
      ),
      drawer: Menu(),
      body: FutureBuilder(
        future: getTasks(),
        builder: (context, AsyncSnapshot<Map<String, dynamic>> toDoData) {
          if (toDoData.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            final dataIncomplete = toDoData.data!["incomplete"];
            // final dataComplete = toDoData.data!["complete"] ?? [];

            if (dataIncomplete!.length < 1) {
              return Center(
                child: Text('No tienes tareas en proceso, crea una'),
              );
            } else {
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    ListView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: dataIncomplete.length,
                      itemBuilder: (context, index) {
                        return _Task(data: dataIncomplete[index]);
                      },
                    ),
                    SizedBox(height: 15),
                    ExpansionTile(
                      title: Row(
                        children: [
                          Icon(
                            Icons.check_circle_outline,
                            color: Colors.green,
                            size: 35,
                          ),
                          Text(
                            'Tareas completadas',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      children: [
                        ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: dataIncomplete.length,
                          itemBuilder: (context, index) {
                            return _Task(data: dataIncomplete[index]);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
          }
        },
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
}

class _Task extends StatelessWidget {
  const _Task({
    required this.data,
  });

  final Map data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          CupertinoPageRoute(builder: (_) => DisplayToDoPage(data: data)),
        );
      },
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
                    DateTime.parse(data['createdAt']).toString(),
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                data['title'],
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: 5),
              Text(
                data['description'],
                style: Theme.of(context).textTheme.bodyText2,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
