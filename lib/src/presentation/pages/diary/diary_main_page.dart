import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lubby_app/src/presentation/widgets/menu_drawer.dart';
import '../../widgets/calendar/calendar_event_data.dart';
import '../../widgets/calendar/day_view/day_view.dart';
import '../../widgets/calendar/event_controller.dart';
import '../../widgets/calendar/month_view/month_view.dart';
import '../../widgets/calendar/week_view/week_view.dart';
import 'bloc/diary_bloc.dart';
import 'enums/type_calendar_view_enum.dart';

part 'widgets/resume_page_item_widget.dart';
part 'widgets/calendar_page_item_widget.dart';
part 'widgets/statistics_page_item_widget.dart';

class DiaryMainPage extends StatelessWidget {
  const DiaryMainPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DiaryBloc(),
      child: _BuildPage(),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////
class _BuildPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<DiaryBloc>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agenda'),
      ),
      drawer: const Menu(),
      body: IndexedStack(
        index: bloc.state.index,
        children: const [
          ResumePageItemWidget(),
          CalendarPageItemWidget(),
          StatisticsPageItemWidget(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text('Nuevo evento'),
        icon: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bloc.state.index,
        onTap: (index) {
          bloc.add(ChangePageEvent(index));
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Resumen',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            label: 'Calendario',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Estadisticas',
          ),
        ],
      ),
    );
  }
}
