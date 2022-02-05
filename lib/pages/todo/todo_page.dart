import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:animate_do/animate_do.dart';

import 'package:lubby_app/models/todo_model.dart';
import 'package:lubby_app/pages/todo/new_todo_page.dart';
import 'package:lubby_app/pages/todo/type_filter_enum.dart';
import 'package:lubby_app/providers/todo_provider.dart';
import 'package:lubby_app/widgets/menu_drawer.dart';
import 'package:lubby_app/widgets/no_data_widget.dart';
import 'package:provider/provider.dart';

class ToDoPage extends StatefulWidget {
  @override
  _ToDoPageState createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  @override
  Widget build(BuildContext context) {
    final _todoProvider = Provider.of<ToDoProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Tareas'),
        actions: [
          DropdownButton<String>(
            value: _todoProvider.currentFilter,
            onChanged: (value) {
              _todoProvider.changeFilter(value.toString());
            },
            items: _todoProvider.filters
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
      drawer: Menu(),
      body: FutureBuilder(
        future: _todoProvider.getTasks(TypeFilter.enProceso),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (_todoProvider.tasks.length < 1) {
            return NoDataWidget(
              text: 'No tienes tareas',
              lottie: 'assets/todo.json',
            );
          } else {
            return Padding(
              padding: EdgeInsets.all(8.0),
              child: ListView.builder(
                padding: EdgeInsets.all(12),
                physics: BouncingScrollPhysics(),
                itemCount: _todoProvider.tasks.length,
                itemBuilder: (BuildContext context, int index) {
                  final task = _todoProvider.tasks[index];
                  return _Task(data: task, index: index);
                },
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            CupertinoPageRoute(
              builder: (context) => NewToDoPage(),
            ),
          );
        },
      ),
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
