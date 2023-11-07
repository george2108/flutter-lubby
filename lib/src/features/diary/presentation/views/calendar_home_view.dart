part of './diary_main_page.dart';

class CalendarHomeView extends StatefulWidget {
  const CalendarHomeView({super.key});
  @override
  State<CalendarHomeView> createState() => _CalendarHomeViewState();
}

class _CalendarHomeViewState extends State<CalendarHomeView> {
  TypeCalendarViewEnum viewCalendar = TypeCalendarViewEnum.month;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text('Vista'),
              const SizedBox(width: 25),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).hintColor,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButton(
                  value: viewCalendar,
                  underline: Container(),
                  icon: const Icon(Icons.calendar_month_outlined),
                  items: const [
                    DropdownMenuItem(
                      value: TypeCalendarViewEnum.month,
                      child: Text('Mensual'),
                    ),
                    DropdownMenuItem(
                      value: TypeCalendarViewEnum.week,
                      child: Text('Semanal'),
                    ),
                    DropdownMenuItem(
                      value: TypeCalendarViewEnum.day,
                      child: Text('Diaria'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      viewCalendar = value as TypeCalendarViewEnum;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Builder(
            builder: (context) {
              Widget child = const _DayViewWidget();

              if (viewCalendar == TypeCalendarViewEnum.month) {
                child = const _MonthViewWidget();
              }

              if (viewCalendar == TypeCalendarViewEnum.week) {
                child = const _WeekViewWidget();
              }

              const animationDuration = 300;

              return AnimatedSwitcher(
                duration: const Duration(
                  milliseconds: animationDuration,
                ),
                reverseDuration: const Duration(
                  milliseconds: animationDuration,
                ),
                child: child,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _WeekViewWidget extends StatelessWidget {
  const _WeekViewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WeekView(
      onDateLongPress: (date) {
        print(date);
      },
      onEventTap: (events, date) {
        print(events);
        print(date);
      },
      controller: EventController()..addAll(_events),
      onDateTap: (date) {
        print(date);
      },
    );
  }
}

class _DayViewWidget extends StatelessWidget {
  const _DayViewWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DayView(
      onDateLongPress: (date) {
        print(date);
      },
      onEventTap: (events, date) {
        print(events);
        print(date);
      },
      controller: EventController()..addAll(_events),
      onDateTap: (date) {
        print(date);
      },
    );
  }
}

class _MonthViewWidget extends StatelessWidget {
  const _MonthViewWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MonthView(
      borderColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.white
          : Colors.black.withOpacity(0.3),
      onDateLongPress: (date) {
        print(date);
      },
      onCellTap: (events, date) {
        print(events);
      },
      onEventTap: (events, date) {
        print(events);
        print(date);
      },
      controller: EventController()..addAll(_events),
    );
  }
}

DateTime get _now => DateTime.now();

List<CalendarEventData<String>> _events = [
  CalendarEventData<String>(
    date: _now,
    endDate: _now.add(const Duration(days: 1)),
    event: "Joe's Birthday",
    title: "Project meeting",
    description: "Today is project meeting.",
    startTime: DateTime(_now.year, _now.month, _now.day, 18, 30),
    endTime: DateTime(_now.year, _now.month, _now.day, 22),
  ),
  CalendarEventData<String>(
    date: _now.add(const Duration(days: 1)),
    endDate: _now.add(const Duration(days: 2)),
    startTime: DateTime(_now.year, _now.month, _now.day, 18),
    endTime: DateTime(_now.year, _now.month, _now.day, 19),
    event: "Wedding anniversary",
    title: "Wedding anniversary",
    description: "Attend uncle's wedding anniversary.",
  ),
  CalendarEventData<String>(
    date: _now,
    endDate: _now.add(const Duration(days: 2)),
    startTime: DateTime(_now.year, _now.month, _now.day, 14),
    endTime: DateTime(_now.year, _now.month, _now.day, 17),
    event: "Football Tournament",
    title: "Football Tournament",
    description: "Go to football tournament.",
  ),
  CalendarEventData<String>(
    date: _now.add(const Duration(days: 3)),
    endDate: _now.add(const Duration(days: 4)),
    startTime: DateTime(
        _now.add(const Duration(days: 3)).year,
        _now.add(const Duration(days: 3)).month,
        _now.add(const Duration(days: 3)).day,
        10),
    endTime: DateTime(
        _now.add(const Duration(days: 3)).year,
        _now.add(const Duration(days: 3)).month,
        _now.add(const Duration(days: 3)).day,
        14),
    event: "Sprint Meeting.",
    title: "Sprint Meeting.",
    description: "Last day of project submission for last year.",
  ),
  CalendarEventData<String>(
    date: _now.subtract(const Duration(days: 2)),
    endDate: _now.add(const Duration(days: 3)),
    startTime: DateTime(
        _now.subtract(const Duration(days: 2)).year,
        _now.subtract(const Duration(days: 2)).month,
        _now.subtract(const Duration(days: 2)).day,
        14),
    endTime: DateTime(
        _now.subtract(const Duration(days: 2)).year,
        _now.subtract(const Duration(days: 2)).month,
        _now.subtract(const Duration(days: 2)).day,
        16),
    event: "Team Meeting",
    title: "Team Meeting",
    description: "Team Meeting",
  ),
  CalendarEventData<String>(
    date: _now.subtract(const Duration(days: 2)),
    endDate: _now.add(const Duration(days: 3)),
    startTime: DateTime(
        _now.subtract(const Duration(days: 2)).year,
        _now.subtract(const Duration(days: 2)).month,
        _now.subtract(const Duration(days: 2)).day,
        10),
    endTime: DateTime(
        _now.subtract(const Duration(days: 2)).year,
        _now.subtract(const Duration(days: 2)).month,
        _now.subtract(const Duration(days: 2)).day,
        12),
    event: "Chemistry Viva",
    title: "Chemistry Viva",
    description: "Today is Joe's birthday.",
  ),
];
