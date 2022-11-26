part of '../diary_page.dart';

class CalendarPageItemWidget extends StatelessWidget {
  const CalendarPageItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    print('creadoooooooooooooooooooooooooooo');
    return DayView(
      onDateLongPress: (date) {
        print(date);
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
    endDate: _now.add(Duration(days: 1)),
    event: "Joe's Birthday",
    title: "Project meeting",
    description: "Today is project meeting.",
    startTime: DateTime(_now.year, _now.month, _now.day, 18, 30),
    endTime: DateTime(_now.year, _now.month, _now.day, 22),
  ),
  CalendarEventData<String>(
    date: _now.add(Duration(days: 1)),
    endDate: _now.add(Duration(days: 2)),
    startTime: DateTime(_now.year, _now.month, _now.day, 18),
    endTime: DateTime(_now.year, _now.month, _now.day, 19),
    event: "Wedding anniversary",
    title: "Wedding anniversary",
    description: "Attend uncle's wedding anniversary.",
  ),
  CalendarEventData<String>(
    date: _now,
    endDate: _now.add(Duration(days: 2)),
    startTime: DateTime(_now.year, _now.month, _now.day, 14),
    endTime: DateTime(_now.year, _now.month, _now.day, 17),
    event: "Football Tournament",
    title: "Football Tournament",
    description: "Go to football tournament.",
  ),
  CalendarEventData<String>(
    date: _now.add(Duration(days: 3)),
    endDate: _now.add(Duration(days: 4)),
    startTime: DateTime(_now.add(Duration(days: 3)).year,
        _now.add(Duration(days: 3)).month, _now.add(Duration(days: 3)).day, 10),
    endTime: DateTime(_now.add(Duration(days: 3)).year,
        _now.add(Duration(days: 3)).month, _now.add(Duration(days: 3)).day, 14),
    event: "Sprint Meeting.",
    title: "Sprint Meeting.",
    description: "Last day of project submission for last year.",
  ),
  CalendarEventData<String>(
    date: _now.subtract(Duration(days: 2)),
    endDate: _now.add(Duration(days: 3)),
    startTime: DateTime(
        _now.subtract(Duration(days: 2)).year,
        _now.subtract(Duration(days: 2)).month,
        _now.subtract(Duration(days: 2)).day,
        14),
    endTime: DateTime(
        _now.subtract(Duration(days: 2)).year,
        _now.subtract(Duration(days: 2)).month,
        _now.subtract(Duration(days: 2)).day,
        16),
    event: "Team Meeting",
    title: "Team Meeting",
    description: "Team Meeting",
  ),
  CalendarEventData<String>(
    date: _now.subtract(Duration(days: 2)),
    endDate: _now.add(Duration(days: 3)),
    startTime: DateTime(
        _now.subtract(Duration(days: 2)).year,
        _now.subtract(Duration(days: 2)).month,
        _now.subtract(Duration(days: 2)).day,
        10),
    endTime: DateTime(
        _now.subtract(Duration(days: 2)).year,
        _now.subtract(Duration(days: 2)).month,
        _now.subtract(Duration(days: 2)).day,
        12),
    event: "Chemistry Viva",
    title: "Chemistry Viva",
    description: "Today is Joe's birthday.",
  ),
];
