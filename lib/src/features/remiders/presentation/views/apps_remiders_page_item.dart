part of './reminders_main_page.dart';

class AppsRemindersPageItem extends StatefulWidget {
  const AppsRemindersPageItem({super.key});
  @override
  State<AppsRemindersPageItem> createState() => _AppsRemindersPageItemState();
}

class _AppsRemindersPageItemState extends State<AppsRemindersPageItem>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 6,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Notas'),
            Tab(text: 'Tareas'),
            Tab(text: 'Gastos'),
            Tab(text: 'Actividades'),
            Tab(text: 'Agenda'),
            Tab(text: 'Hábitos'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: const [
              Center(child: Text('1')),
              Center(child: Text('2')),
              Center(child: Text('3')),
              Center(child: Text('4')),
              Center(child: Text('5')),
              Center(child: Text('6')),
            ],
          ),
        ),
      ],
    );
  }
}
