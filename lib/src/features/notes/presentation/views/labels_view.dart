import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/notes_bloc.dart';

class LabelsView extends StatelessWidget {
  const LabelsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NotesBloc, NotesState>(
        builder: (context, state) {
          if (state.labels.isEmpty) {
            return const Center(
              child: Text('No hay etiquetas'),
            );
          }

          final labels = state.labels;
          return ListView.separated(
            separatorBuilder: (context, index) => const Divider(),
            itemCount: labels.length,
            itemBuilder: (context, index) {
              final label = labels[index];
              return ListTile(
                style: ListTileStyle.drawer,
                leading: CircleAvatar(
                  backgroundColor: label.color,
                  child: Icon(
                    label.icon,
                    color: Theme.of(context).textTheme.bodyText1!.color,
                  ),
                ),
                title: Text(label.name),
                onTap: () {},
              );
            },
          );
        },
      ),
    );
  }
}
