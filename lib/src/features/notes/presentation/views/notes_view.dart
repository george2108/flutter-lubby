import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../bloc/notes_bloc.dart';
import '../../../../ui/widgets/no_data_widget.dart';
import '../../../../ui/widgets/view_labels_categories_widget.dart';

import '../widgets/notes_card_widget.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  int crossAxisCount = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          BlocBuilder<NotesBloc, NotesState>(
            builder: (context, state) {
              return ViewLabelsCategoriesWidget(
                labels: state.labels,
                onLabelSelected: (indexLabelSelected) {
                  if (indexLabelSelected == null) {
                    // ir por todas las notas
                  } else {
                    // ir por las notas de la etiqueta
                  }
                },
              );
            },
          ),
          Expanded(
            child: BlocBuilder<NotesBloc, NotesState>(
              buildWhen: (previous, current) {
                return previous != current;
              },
              builder: (context, state) {
                if (state.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final notes = state.notes;

                if (notes.isEmpty) {
                  return const NoDataWidget(
                    text: 'No tienes notas aún, crea una',
                    lottie: 'assets/notes.json',
                  );
                }

                return LayoutBuilder(builder: (context, constraints) {
                  final width = constraints.maxWidth;
                  crossAxisCount = (width / 500).ceil();

                  return MasonryGridView.count(
                    crossAxisCount: crossAxisCount,
                    itemCount: notes.length,
                    padding: const EdgeInsets.only(
                      top: 5,
                      left: 5,
                      right: 5,
                      bottom: 100,
                    ),
                    itemBuilder: (context, index) {
                      final note = notes[index];
                      return NoteCardWidget(
                        note: note,
                      );
                    },
                  );
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
