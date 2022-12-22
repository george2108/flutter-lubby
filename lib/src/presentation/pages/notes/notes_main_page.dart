import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class NotesMainPage extends StatelessWidget {
  const NotesMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children: [],
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: 0,
        onTap: (index) {},
        items: [
          SalomonBottomBarItem(
            icon: const Icon(Icons.add_alarm_outlined),
            title: const Text('Personalizados'),
            selectedColor: Theme.of(context).indicatorColor,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.apps_sharp),
            title: const Text('Otros'),
            selectedColor: Theme.of(context).indicatorColor,
          ),
        ],
      ),
    );
  }
}
