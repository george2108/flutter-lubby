import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lubby_app/injector.dart';
import 'package:lubby_app/src/core/constants/shape_modal_bottom.dart';
import 'package:lubby_app/src/data/entities/diary_entity.dart';
import 'package:lubby_app/src/ui/pages/diary/widgets/add_new_event_widget.dart';
import 'package:lubby_app/src/ui/widgets/calendar_row/date_picker_widget.dart';

import 'package:lubby_app/src/ui/widgets/menu_drawer.dart';
import 'package:lubby_app/src/ui/widgets/time_line_widget.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../../../data/repositories/diary_repository.dart';
import '../../widgets/calendar/calendar_event_data.dart';
import '../../widgets/calendar/day_view/day_view.dart';
import '../../widgets/calendar/event_controller.dart';
import '../../widgets/calendar/month_view/month_view.dart';
import '../../widgets/calendar/week_view/week_view.dart';
import 'bloc/diary_bloc.dart';
import 'enums/type_calendar_view_enum.dart';

part 'views/resume_view.dart';
part 'views/calendar_home_view.dart';
part 'views/statistics_view.dart';

class DiaryMainPage extends StatelessWidget {
  const DiaryMainPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DiaryBloc(
        injector<DiaryRepository>(),
      )..add(GetDiariesResumeEvent(DateTime.now())),
      child: const _BuildPage(),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////
class _BuildPage extends StatefulWidget {
  const _BuildPage();
  @override
  State<_BuildPage> createState() => _BuildPageState();
}

class _BuildPageState extends State<_BuildPage> {
  int indexSelected = 0;

  @override
  Widget build(BuildContext context) {
    final diaryBloc = BlocProvider.of<DiaryBloc>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agenda'),
      ),
      drawer: const Menu(),
      body: IndexedStack(
        index: indexSelected,
        children: const [
          ResumeView(),
          CalendarHomeView(),
          StatisticsView(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Nuevo evento'),
        icon: const Icon(Icons.add),
        onPressed: () async {
          final diary = await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: kShapeModalBottom,
            builder: (_) => const AddNewEventWidget(),
          );

          if (diary != null) {
            diaryBloc.add(DiaryAddEvent(diary));
          }
        },
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: indexSelected,
        onTap: (index) {
          setState(() {
            indexSelected = index;
          });
        },
        items: [
          SalomonBottomBarItem(
            icon: const Icon(Icons.dashboard),
            title: const Text('Resumen'),
            selectedColor: Theme.of(context).indicatorColor,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.calendar_month_outlined),
            title: const Text('Calendario'),
            selectedColor: Theme.of(context).indicatorColor,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.bar_chart),
            title: const Text('Estadisticas'),
            selectedColor: Theme.of(context).indicatorColor,
          ),
        ],
      ),
    );
  }
}
