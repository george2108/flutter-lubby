import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../../../injector.dart';
import '../../../../core/constants/shape_modal_bottom.dart';
import '../../data/repositories/diary_repository.dart';
import '../../domain/entities/diary_entity.dart';
import '../bloc/diary_bloc.dart';
import '../widgets/add_new_event_widget.dart';
import '../../../../ui/widgets/calendar/calendar_view.dart';
import '../../../../ui/widgets/calendar_row/date_picker_widget.dart';
import '../../../../ui/widgets/menu_drawer/menu_drawer.dart';
import '../../../../ui/widgets/time_line_widget.dart';
import '../enums/type_calendar_view_enum.dart';

part 'resume_view.dart';
part 'calendar_home_view.dart';
part 'statistics_view.dart';

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
