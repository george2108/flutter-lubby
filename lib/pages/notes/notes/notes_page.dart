import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lubby_app/models/note_model.dart';
import 'package:lubby_app/pages/notes/note/note_page.dart';
import 'package:lubby_app/pages/notes/notes/bloc/notes_bloc.dart';
import 'package:lubby_app/widgets/menu_drawer.dart';
import 'package:lubby_app/widgets/no_data_widget.dart';

part 'widgets/notes_card_widget.dart';
part 'widgets/notes_no_data_screen_widget.dart';
part 'widgets/notes_data_screen_widget.dart';

class NotesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotesBloc()..add(NotesGetEvent()),
      child: Scaffold(
        drawer: Menu(),
        body: BlocBuilder<NotesBloc, NotesState>(
          builder: (context, state) {
            if (state is NotesLoadedState) {
              final notes = state.notes;

              if (notes.length == 0) {
                return const NotesNoDataScreenWidget(
                  child: NoDataWidget(
                    text: 'No tienes notas aún, crea una',
                    lottie: 'assets/notes.json',
                  ),
                );
              }

              return NotesDataScreenWidget(notes: notes);
            }

            return const NotesNoDataScreenWidget(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
        floatingActionButton: BlocBuilder<NotesBloc, NotesState>(
          builder: (context, state) {
            if (state is NotesLoadedState)
              return FloatingActionButton.extended(
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
              );

            return Container();
          },
        ),
      ),
    );
  }
}
