import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:lubby_app/src/presentation/widgets/no_data_widget.dart';

import '../bloc/notes_bloc.dart';
import '../widgets/notes_card_widget.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

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
              Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5.0),
                            margin: const EdgeInsets.only(right: 5.0),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Text('Todos'),
                          ),
                          Container(
                            padding: const EdgeInsets.all(5.0),
                            margin: const EdgeInsets.only(right: 5.0),
                            decoration: BoxDecoration(
                              color: Theme.of(context).focusColor,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Text('Escuela'),
                          ),
                          Container(
                            padding: const EdgeInsets.all(5.0),
                            margin: const EdgeInsets.only(right: 5.0),
                            decoration: BoxDecoration(
                              color: Theme.of(context).focusColor,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Text('Música'),
                          ),
                          Container(
                            padding: const EdgeInsets.all(5.0),
                            margin: const EdgeInsets.only(right: 5.0),
                            decoration: BoxDecoration(
                              color: Theme.of(context).focusColor,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Text('Departamento'),
                          ),
                          Container(
                            padding: const EdgeInsets.all(5.0),
                            margin: const EdgeInsets.only(right: 5.0),
                            decoration: BoxDecoration(
                              color: Theme.of(context).focusColor,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Text('Programación'),
                          ),
                          Container(
                            padding: const EdgeInsets.all(5.0),
                            margin: const EdgeInsets.only(right: 5.0),
                            decoration: BoxDecoration(
                              color: Theme.of(context).focusColor,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Text('Internet'),
                          ),
                          Container(
                            padding: const EdgeInsets.all(5.0),
                            margin: const EdgeInsets.only(right: 5.0),
                            decoration: BoxDecoration(
                              color: Theme.of(context).focusColor,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Text('Trabajo'),
                          ),
                          Container(
                            padding: const EdgeInsets.all(5.0),
                            margin: const EdgeInsets.only(right: 5.0),
                            decoration: BoxDecoration(
                              color: Theme.of(context).focusColor,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Text('CIelo'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  /* TextButton(
                    onPressed: () {},
                    child: const Text('Nota rapida'),
                  ), */
                ],
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
