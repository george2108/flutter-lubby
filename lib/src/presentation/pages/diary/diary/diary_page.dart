import 'package:flutter/material.dart';

import 'package:calendar_view/calendar_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lubby_app/src/presentation/widgets/menu_drawer.dart';

import 'bloc/diary_bloc.dart';

part '../diary/widgets/resume_page_item_widget.dart';
part '../diary/widgets/calendar_page_item_widget.dart';
part '../diary/widgets/statistics_page_item_widget.dart';

class DiaryPage extends StatelessWidget {
  const DiaryPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DiaryBloc(),
      child: const _BuildPage(),
    );
  }
}

class _BuildPage extends StatefulWidget {
  const _BuildPage({Key? key}) : super(key: key);
  @override
  State<_BuildPage> createState() => _BuildPageState();
}

class _BuildPageState extends State<_BuildPage> {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<DiaryBloc>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agenda'),
      ),
      drawer: const Menu(),
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          ResumePageItemWidget(),
          const CalendarPageItemWidget(),
          const StatisticsPageItemWidget(),
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
          pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
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
