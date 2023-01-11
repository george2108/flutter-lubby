import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/finances_bloc.dart';

class FinancesLabelsView extends StatelessWidget {
  const FinancesLabelsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FinancesBloc, FinancesState>(
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
                  child: Icon(label.icon),
                  backgroundColor: label.color,
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
