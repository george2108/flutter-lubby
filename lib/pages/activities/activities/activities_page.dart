import 'package:flutter/material.dart';
import 'package:lubby_app/widgets/menu_drawer.dart';

class ActivitiesPage extends StatelessWidget {
  const ActivitiesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Organizador de actividades'),
      ),
      drawer: Menu(),
      body: const Center(
        child: Text('Este es el organizador de actividades'),
      ),
    );
  }
}
