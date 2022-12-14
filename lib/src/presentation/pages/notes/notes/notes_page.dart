import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

            return NotificationListener<UserScrollNotification>(
              onNotification: ((notification) {
                if (notification.direction == ScrollDirection.forward) {
                  BlocProvider.of<NotesBloc>(context, listen: false).add(
                    const NotesShowHideFabEvent(true),
                  );
                } else if (notification.direction == ScrollDirection.reverse) {
                  BlocProvider.of<NotesBloc>(context, listen: false).add(
                    const NotesShowHideFabEvent(false),
                  );
                }
                return true;
              }),
              child: ListView.separated(
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
              ),
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
