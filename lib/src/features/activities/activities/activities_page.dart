import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../ui/widgets/menu_drawer.dart';

import '../activity/activity_page.dart';
import 'bloc/activities_bloc.dart';

class ActivitiesPage extends StatelessWidget {
  const ActivitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ActivitiesBloc()
        ..add(
          LoadActivitiesEvent(),
        ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Organizador de actividades'),
        ),
        drawer: const Menu(),
        body: const Center(
          child: Text('Este es el organizador de actividades'),
        ),
        floatingActionButton: FloatingActionButton.extended(
          icon: const Icon(Icons.add),
          label: const Text('Nuevo tablero de actividades'),
          onPressed: () {
            Navigator.of(context).push(
              CupertinoPageRoute(
                builder: ((context) => const ActivityPage()),
              ),
            );
          },
        ),
      ),
    );
  }
}
