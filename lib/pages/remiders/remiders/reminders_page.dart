import 'package:flutter/material.dart';
import 'package:lubby_app/widgets/menu_drawer.dart';

class RemindersPage extends StatelessWidget {
  const RemindersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recordatorios'),
      ),
      drawer: Menu(),
      body: const Center(
        child: Text('Estos son los recordatorios'),
      ),
    );
  }
}
