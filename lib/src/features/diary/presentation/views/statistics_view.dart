part of './diary_main_page.dart';

class StatisticsView extends StatelessWidget {
  const StatisticsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ElevatedButton(
            child: const Text('hola'),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const MyWidget(),
              ));
            },
          ),
          ElevatedButton(
            child: const Text('hola'),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const MyWidget(),
              ));
            },
          ),
          ElevatedButton(
            child: const Text('hola'),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const MyWidget(),
              ));
            },
          ),
        ],
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('hola'),
    );
  }
}
