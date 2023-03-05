import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:lubby_app/src/ui/widgets/no_data_widget.dart';
import 'package:lubby_app/src/ui/widgets/view_labels_categories_widget.dart';

import '../../../../data/entities/label_entity.dart';
import '../bloc/notes_bloc.dart';
import '../widgets/notes_card_widget.dart';

class NotesView extends StatelessWidget {
  const NotesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NotesBloc, NotesState>(
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

          return Column(
            children: [
              ViewLabelsCategoriesWidget(
                labels: state.labels,
                onLabelSelected: (indexLabelSelected) {
                  print(indexLabelSelected);
                  if (indexLabelSelected == null) {
                    // ir por todas las notas
                  } else {
                    // ir por las notas de la etiqueta
                  }
                },
              ),
              Expanded(
                child: MasonryGridView.count(
                  crossAxisCount: 2,
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
                ),
              ),
            ],

            /* child: ListView.separated(
              padding: const EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
                bottom: 50,
              ),
              itemBuilder: (context, index) {
                final note = notes[index];
                return NoteCardWidget(
                  note: note,
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 5),
              itemCount: notes.length,
            ), */
            // child:  NotesDataScreenWidget(notes: notes),
          );
        },
      ),
    );
  }
}
