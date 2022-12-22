import 'package:flutter/material.dart';
import 'package:lubby_app/src/presentation/widgets/menu_drawer.dart';

class HabitsMainPage extends StatelessWidget {
  const HabitsMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hábitos'),
      ),
      drawer: const Menu(),
      body: const Center(
        child: Text('Hábitos'),
      ),
    );
  }
}
