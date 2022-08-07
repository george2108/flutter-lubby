part of '../todos_page.dart';

class TodosDetailCardWidget extends StatelessWidget {
  final ToDoModel data;

  const TodosDetailCardWidget({
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
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: ((_, animation, __) => FadeTransition(
                  opacity: animation,
                  child: TodoPage(
                    toDo: data,
                  ),
                )),
          ),
        );
      },
      child: Card(
        elevation: 5,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    child: Text(data.title[0].toUpperCase()),
                  ),
                  Text(
                    'Creada el $day/$month/$year a las $hour:$minute',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
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
