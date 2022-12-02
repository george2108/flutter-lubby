import 'package:flutter/material.dart';

int createUniqueNumber() {
  return DateTime.now().millisecondsSinceEpoch.remainder(100000);
}

class NotificationWeekAndTime {
  final int dayOfTheWeek;
  final TimeOfDay timeOfDay;

  NotificationWeekAndTime({
    required this.dayOfTheWeek,
    required this.timeOfDay,
  });
}

Future<NotificationWeekAndTime?> picksSchedule(
  BuildContext context,
) async {
  List<String> weekdays = [
    'lunes',
    'martes',
    'miercoles',
    'jueves',
    'viernes',
    'sabado',
    'domingo',
  ];

  TimeOfDay? timeOfDay;
  DateTime now = DateTime.now();
  int? selectedDay;

  await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Quisiera que me recordara cada:',
            textAlign: TextAlign.center,
          ),
          content: Wrap(
            alignment: WrapAlignment.center,
            spacing: 3,
            children: [
              for (int index = 0; index < weekdays.length; index++)
                ElevatedButton(
                  onPressed: () {
                    selectedDay = index + 1;
                    Navigator.pop(context);
                  },
                  child: Text(weekdays[index]),
                ),
            ],
          ),
        );
      });

  if (selectedDay != null) {
    timeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(
        now.add(
          const Duration(minutes: 1),
        ),
      ),
    );

    if (timeOfDay != null) {
      return NotificationWeekAndTime(
        dayOfTheWeek: selectedDay!,
        timeOfDay: timeOfDay,
      );
    }
  }

  return null;
}
