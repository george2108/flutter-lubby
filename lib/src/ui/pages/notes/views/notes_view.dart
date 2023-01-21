import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:lubby_app/src/ui/widgets/no_data_widget.dart';

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
              _LabelsNotes(
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

////////////////////////////////////////////////////////////////////////////////
class _LabelsNotes extends StatefulWidget {
  final List<LabelEntity> labels;
  final Function(int? indexLabelSelected)? onLabelSelected;

  const _LabelsNotes({
    Key? key,
    required this.labels,
    this.onLabelSelected,
  }) : super(key: key);
  @override
  State<_LabelsNotes> createState() => _LabelsNotesState();
}

class _LabelsNotesState extends State<_LabelsNotes> {
  int _indexLabelSelected = -1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _indexLabelSelected = -1;
                          });
                          if (widget.onLabelSelected != null) {
                            widget.onLabelSelected!(null);
                          }
                        },
                        child: Chip(
                          label: const Text('Todas'),
                          backgroundColor: _indexLabelSelected == -1
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).chipTheme.backgroundColor,
                        ),
                      ),
                      const SizedBox(width: 5),
                    ],
                  ),
                  ...List.generate(widget.labels.length, (index) {
                    final label = widget.labels[index];
                    return Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _indexLabelSelected = index;
                            });
                            if (widget.onLabelSelected != null) {
                              widget.onLabelSelected!(_indexLabelSelected);
                            }
                          },
                          child: Chip(
                            backgroundColor: _indexLabelSelected == index
                                ? label.color.withOpacity(0.5)
                                : Theme.of(context).chipTheme.backgroundColor,
                            avatar: CircleAvatar(
                              backgroundColor: label.color,
                              child: Icon(label.icon),
                            ),
                            label: Text(label.name),
                          ),
                        ),
                        const SizedBox(width: 5),
                      ],
                    );
                  }),
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
    );
  }
}
