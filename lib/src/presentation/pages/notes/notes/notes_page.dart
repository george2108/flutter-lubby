import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:flutter_quill/flutter_quill.dart' as flutter_quill;

import 'package:lubby_app/src/data/entities/note_entity.dart';
import 'package:lubby_app/src/presentation/widgets/menu_drawer.dart';
import 'package:lubby_app/src/presentation/widgets/no_data_widget.dart';

import '../note/note_page.dart';
import 'bloc/notes_bloc.dart';

part 'widgets/notes_card_widget.dart';
part 'widgets/notes_data_screen_widget.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotesBloc()..add(NotesGetEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Mis notas'),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ],
        ),
        drawer: const Menu(),
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
                  child: NotificationListener<UserScrollNotification>(
                    onNotification: ((notification) {
                      if (notification.direction == ScrollDirection.forward) {
                        BlocProvider.of<NotesBloc>(context, listen: false).add(
                          const NotesShowHideFabEvent(true),
                        );
                      } else if (notification.direction ==
                          ScrollDirection.reverse) {
                        BlocProvider.of<NotesBloc>(context, listen: false).add(
                          const NotesShowHideFabEvent(false),
                        );
                      }
                      return true;
                    }),
                    child: MasonryGridView.count(
                      crossAxisCount: 2,
                      itemCount: notes.length,
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
                    ),
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
        floatingActionButton: BlocBuilder<NotesBloc, NotesState>(
          builder: (context, state) {
            return AnimatedSlide(
              duration: const Duration(milliseconds: 300),
              curve: Curves.decelerate,
              offset: state.showFab ? Offset.zero : const Offset(0, 2),
              child: FloatingActionButton.extended(
                label: const Text('Nueva nota'),
                icon: const Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 500),
                      pageBuilder: ((_, animation, __) => FadeTransition(
                            opacity: animation,
                            child: NotePage(notesContext: context),
                          )),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
