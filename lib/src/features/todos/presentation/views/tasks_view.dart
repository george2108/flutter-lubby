part of './todo_main_page.dart';

class TasksView extends StatefulWidget {
  const TasksView({super.key});

  @override
  State<TasksView> createState() => _TasksViewState();
}

class _TasksViewState extends State<TasksView> {
  DateTime selectedDate = DateTime.now();
  DateTime selectedValue = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TweenAnimationBuilder(
          tween: Tween<double>(begin: -50.0, end: 0.0),
          duration: const Duration(milliseconds: 600),
          child: DatePickerRow(
            selectedDate.subtract(const Duration(days: 100)),
            initialSelectedDate: selectedValue,
            selectedTextColor: Colors.white,
            daysCount: 200,
            locale: 'es_ES',
            onDateChange: (date) {
              print(date);
              /* setState(() {
              selectedValue = date;
            }); */
            },
          ),
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(0, value),
              child: child,
            );
          },
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.only(
              top: 10.0,
              left: 10.0,
              right: 10.0,
              bottom: 80.0,
            ),
            children: const [
              _TaskWidget(completed: true),
              SizedBox(height: 10),
              _TaskWidget(completed: false),
              SizedBox(height: 10),
              _TaskWidget(completed: false),
              SizedBox(height: 10),
              _TaskWidget(completed: false),
              SizedBox(height: 10),
              _TaskWidget(completed: false),
              SizedBox(height: 10),
              _TaskWidget(completed: false),
              SizedBox(height: 10),
              _TaskWidget(completed: false),
              SizedBox(height: 10),
              _TaskWidget(completed: false),
              SizedBox(height: 10),
              _TaskWidget(completed: false),
              SizedBox(height: 10),
              _TaskWidget(completed: false),
              SizedBox(height: 10),
              _TaskWidget(completed: false),
              SizedBox(height: 10),
              _TaskWidget(completed: false),
              SizedBox(height: 10),
              _TaskWidget(completed: false),
              SizedBox(height: 10),
              _TaskWidget(completed: false),
              SizedBox(height: 10),
              _TaskWidget(completed: false),
              SizedBox(height: 10),
              _TaskWidget(completed: false),
              SizedBox(height: 10),
              _TaskWidget(completed: false),
              SizedBox(height: 10),
              _TaskWidget(completed: false),
            ],
          ),
        ),
      ],
    );
  }
}

////////////////////////////////////////////////////////////////////////////////
class _TaskWidget extends StatefulWidget {
  final bool completed;

  const _TaskWidget({
    Key? key,
    required this.completed,
  }) : super(key: key);

  @override
  State<_TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<_TaskWidget>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  late bool taskCompleted;

  final unCompletedStyle = const TextStyle(
    fontWeight: FontWeight.bold,
  );
  final completedStyle = const TextStyle(
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.lineThrough,
    decorationStyle: TextDecorationStyle.solid,
    decorationThickness: 2,
  );

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    taskCompleted = widget.completed;
    if (taskCompleted) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Theme.of(context).focusColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              if (_controller.status == AnimationStatus.completed) {
                _controller.reverse();
              } else if (_controller.status == AnimationStatus.dismissed) {
                _controller.forward();
              }
              setState(() {
                taskCompleted = !taskCompleted;
              });
            },
            child: SizedBox(
              width: 30,
              height: 30,
              child: OverflowBox(
                maxHeight: 70,
                maxWidth: 70,
                child: Lottie.asset(
                  'assets/checkbox.json',
                  repeat: false,
                  controller: _controller,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 500),
                  style: taskCompleted ? completedStyle : unCompletedStyle,
                  child: const Text(
                    'Titulo de la tarea',
                  ),
                ),
                const Text(
                  'Descripcion de la tarea, esta va mas pequeña asdf asdf asdf sad fasdf ads',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12),
                ),
                const SizedBox(height: 5),
                Wrap(
                  spacing: 10,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Text(
                        'Trabajo',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Text(
                        'Escuela',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Text(
                        'Casa',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
