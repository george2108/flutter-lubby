import 'package:flutter/material.dart';
import 'package:lubby_app/models/todo_model.dart';
import 'package:lubby_app/pages/todos/todo/todo_page.dart';
import 'package:lubby_app/widgets/menu_drawer.dart';
import 'package:lubby_app/widgets/percent_indicator_widget.dart';

class TodosPage extends StatelessWidget {
  const TodosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis tareas'),
      ),
      drawer: Menu(),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Nueva lista de tareas'),
        icon: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: ((_, animation, __) => FadeTransition(
                    opacity: animation,
                    child: TodoPage(),
                  )),
            ),
          );
        },
      ),
    );
  }
}

class _Task extends StatelessWidget {
  final ToDoModel data;

  const _Task({
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final day = data.createdAt!.day.toString().padLeft(2, '0');
    final month = data.createdAt!.month.toString().padLeft(2, '0');
    final year = data.createdAt!.year.toString();
    final minute = data.createdAt!.minute.toString();
    final hour = data.createdAt!.hour.toString();

    return GestureDetector(
      onTap: () {
        /* Navigator.of(context).push(
          CupertinoPageRoute(builder: (_) => DisplayToDoPage(data: data)),
        ); */
      },
      child: Card(
        elevation: 5,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Creada el $day/$month/$year a las $hour:$minute',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.title,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          data.description.toString(),
                          style: Theme.of(context).textTheme.bodyText2,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  PercentIndicatorWidget(
                    size: 80,
                    currentProgress: data.percentCompleted,
                    indicatorColor: Colors.red,
                    child: Text(
                      '${data.percentCompleted.toString()} %',
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
