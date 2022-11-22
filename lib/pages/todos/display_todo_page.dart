import 'package:flutter/material.dart';
import 'package:lubby_app/db/todos_database_provider.dart';

class DisplayToDoPage extends StatelessWidget {
  final Map data;

  const DisplayToDoPage({super.key, required this.data});

  Future<List> getTaskDetail() async {
    final details =
        await TodosDatabaseProvider.provider.getTaskDetail(data['id']);
    return details;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarea'),
      ),
      body: FutureBuilder(
        future: getTaskDetail(),
        builder: (BuildContext context, AsyncSnapshot<List> detailData) {
          if (detailData.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final details = detailData.data;
          if (details!.isEmpty) {
            return const Center(child: Text('No hay detalles'));
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                Text(data['title']),
                Text(data['description']),
                Text(data['createdAt']),
                Text(data['complete'].toString()),
                ListView.builder(
                  itemCount: details.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    final detailsMap = details[index];
                    final detailOne = Map<String, dynamic>.from(detailsMap);
                    return _BuildTask(detail: detailOne);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _BuildTask extends StatefulWidget {
  final Map<String, dynamic> detail;

  const _BuildTask({
    required this.detail,
  });

  @override
  __BuildTaskState createState() => __BuildTaskState();
}

class __BuildTaskState extends State<_BuildTask> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: widget.detail['complete'] == 1 ? true : false,
          onChanged: (value) {
            setState(
              () {
                widget.detail['title'] = "hola";
                value == true
                    ? widget.detail['complete'] = 1
                    : widget.detail['complete'] = 0;
              },
            );
          },
        ),
        Expanded(
          child: Text(widget.detail["description"] ?? 'No Description'),
        ),
      ],
    );
  }
}
