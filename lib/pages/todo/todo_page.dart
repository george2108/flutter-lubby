import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:lubby_app/models/todo_model.dart';
import 'package:lubby_app/pages/todo/new_todo_page.dart';
import 'package:lubby_app/pages/todo/type_filter_enum.dart';
import 'package:lubby_app/providers/todo_provider.dart';
import 'package:lubby_app/utils/dates_utils.dart';
import 'package:lubby_app/widgets/animate_widgets_widget.dart';
import 'package:lubby_app/widgets/menu_drawer.dart';
import 'package:lubby_app/widgets/no_data_widget.dart';
import 'package:lubby_app/widgets/percent_indicator_widget.dart';
import 'package:provider/provider.dart';

class ToDoPage extends StatefulWidget {
  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _todoProvider = Provider.of<ToDoProvider>(context);
    final fecha = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tareas'),
        elevation: 0,
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
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 15.0,
            ),
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Theme.of(context).cardColor
                  : Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  child: Text('a'),
                ),
                const SizedBox(width: 15),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${fecha.day.toString().padLeft(2, '0')}/${fecha.month.toString().padLeft(2, '0')}/${fecha.year}',
                    ),
                    const SizedBox(height: 5.0),
                    const Text('Tareas pendientes: 15'),
                  ],
                )
              ],
            ),
          ),
          Container(
            child: TabBar(
              physics: const BouncingScrollPhysics(),
              controller: tabController,
              labelColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
              unselectedLabelColor:
                  Theme.of(context).brightness == Brightness.dark
                      ? Colors.white60
                      : Colors.black54,
              tabs: [
                const Tab(text: 'Esta semana'),
                const Tab(text: 'Este mes'),
                const Tab(text: 'Todas'),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.maxFinite,
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: tabController,
                children: [
                  Tasks(index: 0),
                  Tasks(index: 1),
                  Tasks(index: 2),
                ],
              ),
            ),
          ),
        ],
      ),
      /* appBar: AppBar(
        title: const Text('Tareas'),
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
            return const Center(child: CircularProgressIndicator());
          }

          if (_todoProvider.tasks.length < 1) {
            return const NoDataWidget(
              text: 'No tienes tareas',
              lottie: 'assets/todo.json',
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                physics: const BouncingScrollPhysics(),
                itemCount: _todoProvider.tasks.length,
                itemBuilder: (BuildContext context, int index) {
                  final task = _todoProvider.tasks[index];
                  return _Task(data: task, index: index);
                },
              ),
            );
          }
        },
      ), */
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text('Nueva lista de tareas'),
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

class Tasks extends StatelessWidget {
  final int index;

  Tasks({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _todoProvider = Provider.of<ToDoProvider>(context);

    DateTime fechaInicio = DateTime.now();
    DateTime fechaFin = DateTime.now();

    if (index == 0) {
      final datesUtils = DatesUtils();
      fechaInicio = datesUtils.findFirstDateOfTheWeek(DateTime.now());
      fechaFin = datesUtils.findLastDateOfTheWeek(DateTime.now());
    }
    if (index == 1) {
      final datesUtils = DatesUtils();
      fechaInicio = datesUtils.findFirstDateOfTheMonth(DateTime.now());
      fechaFin = datesUtils.findLastDateOfTheMonth(DateTime.now());
    }

    return FutureBuilder(
      future: index < 2
          ? _todoProvider.getTasks(
              filter: TypeFilter.enProceso,
              fechaInicio: fechaInicio,
              fechaFin: fechaFin,
            )
          : _todoProvider.getTasks(filter: TypeFilter.enProceso),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (_todoProvider.tasks.length < 1) {
          return const NoDataWidget(
            text: 'No tienes tareas',
            lottie: 'assets/todo.json',
          );
        } else {
          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            physics: const BouncingScrollPhysics(),
            itemCount: _todoProvider.tasks.length,
            itemBuilder: (BuildContext context, int index) {
              final task = _todoProvider.tasks[index];
              return CustomAnimatedWidget(
                child: _Task(
                  data: task,
                ),
                index: index,
              );
              // return _Task(data: task, index: index);
            },
          );
        }
      },
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
