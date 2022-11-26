import 'package:flutter/material.dart';
import 'package:lubby_app/src/presentation/widgets/calendar/event_controller.dart';
import 'package:lubby_app/src/presentation/widgets/calendar/month_view/month_view.dart';
import 'package:lubby_app/src/presentation/widgets/calendar/week_view/week_view.dart';
import 'package:lubby_app/src/presentation/widgets/menu_drawer.dart';

class RemindersPage extends StatelessWidget {
  const RemindersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recordatorios'),
      ),
      drawer: const Menu(),
      body: WeekView(
        controller: EventController(),
      ),
    );
  }
}
