part of '../todo_main_page.dart';

class TasksPageItem extends StatefulWidget {
  const TasksPageItem({super.key});

  @override
  State<TasksPageItem> createState() => _TasksPageItemState();
}

class _TasksPageItemState extends State<TasksPageItem> {
  DateTime selectedDate = DateTime.now();
  DateTime selectedValue = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<TodosBloc>(context, listen: true);
    final currentDate = DateTime.now();
    final now = DateTime(currentDate.year, currentDate.month, currentDate.day);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                now.compareTo(selectedValue) == 0
                    ? 'HOY'
                    : DateFormat("E, d MMMM y", 'es_ES')
                        .format(selectedValue)
                        .toUpperCase(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.calendar_month_outlined),
                onPressed: () async {
                  final newDateTime = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2050),
                  );
                  if (newDateTime != null) {
                    setState(() {
                      selectedValue = newDateTime;
                      selectedDate = newDateTime;
                    });
                  }
                },
              ),
            ],
          ),
        ),
        DatePickerRow(
          selectedDate.subtract(const Duration(days: 10)),
          initialSelectedDate: selectedValue,
          selectedTextColor: Colors.white,
          daysCount: 20,
          locale: 'es_ES',
          onDateChange: (date) {
            setState(() {
              selectedValue = date;
            });
          },
        ),
        Expanded(
          child: Center(
            child: Text('Vista de tareas'),
          ),
        ),
      ],
    );
  }
}
