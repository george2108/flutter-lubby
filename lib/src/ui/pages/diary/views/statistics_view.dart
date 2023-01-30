part of '../diary_main_page.dart';

class StatisticsView extends StatelessWidget {
  const StatisticsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ElevatedButton(
            child: Text('hola'),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MyWidget(),
              ));
            },
          ),
          ElevatedButton(
            child: Text('hola'),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MyWidget(),
              ));
            },
          ),
          ElevatedButton(
            child: Text('hola'),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MyWidget(),
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
    return Center(
      child: Text('hola'),
    );
  }
}
