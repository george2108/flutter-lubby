import 'package:flutter/material.dart';
import 'package:lubby_app/widgets/menu_drawer.dart';

class DiaryPage extends StatelessWidget {
  const DiaryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agenda'),
      ),
      drawer: Menu(),
      body: const Center(
        child: Text('Esta es la agenda'),
      ),
    );
  }
}
