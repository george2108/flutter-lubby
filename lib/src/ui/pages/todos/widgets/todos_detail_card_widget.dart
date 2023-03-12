part of '../todo_main_page.dart';

class TodosDetailCardWidget extends StatelessWidget {
  final ToDoEntity data;

  const TodosDetailCardWidget({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<TodosBloc>(context);

    final day = data.createdAt!.day.toString().padLeft(2, '0');
    final month = data.createdAt!.month.toString().padLeft(2, '0');
    final year = data.createdAt!.year.toString();
    final minute = data.createdAt!.minute.toString();
    final hour = data.createdAt!.hour.toString();

    return GestureDetector(
      onTap: () {
        bloc.add(NavigateToDetailEvent(context, data));
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
                    backgroundColor: data.color,
                    child: Text(
                      data.title.trim().toUpperCase()[0],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
