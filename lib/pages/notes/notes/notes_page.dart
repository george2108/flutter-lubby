import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lubby_app/models/note_model.dart';
import 'package:lubby_app/pages/notes/note/note_page.dart';
import 'package:lubby_app/pages/notes/notes/bloc/notes_bloc.dart';
import 'package:lubby_app/pages/notes/notes/notes_help_page.dart';
import 'package:lubby_app/pages/notes/search_note_delegate.dart';
import 'package:lubby_app/widgets/menu_drawer.dart';
import 'package:lubby_app/widgets/no_data_widget.dart';

class NotesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotesBloc()..add(NotesGetEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Mis notas'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (_) => NotesHelpPage(),
                  ),
                );
              },
              icon: const Icon(Icons.help_outline),
            ),
            IconButton(
              onPressed: () {
                showSearch(context: context, delegate: SearchNoteDelegate());
              },
              icon: const Icon(Icons.search),
            )
          ],
        ),
        drawer: Menu(),
        body: BlocBuilder<NotesBloc, NotesState>(
          builder: (context, state) {
            if (state is NotesLoadedState) {
              final notes = state.notes;

              if (notes.length == 0) {
                return const NoDataWidget(
                  text: 'No tienes notas aún, crea una',
                  lottie: 'assets/notes.json',
                );
              }

              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: notes.length,
                padding: const EdgeInsets.only(bottom: 100),
                itemBuilder: (context, index) {
                  return _Nota(
                    note: notes[index],
                  );
                },
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
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
                    CupertinoPageRoute(
                      builder: (_) => NotePage(
                        notesContext: context,
                      ),
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

// muestra las notas en el listado
class _Nota extends StatelessWidget {
  final NoteModel note;

  const _Nota({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (_) => NotePage(
                note: note,
                notesContext: context,
              ),
            ),
          );
        },
        child: Card(
          // color: Color(note.color),
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Visibility(
                      visible: note.favorite == 1,
                      child: const Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                    ),
                    Text(
                      note.createdAt.toString(),
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  note.title.trim().length == 0
                      ? '* Nota sin titulo'
                      : note.title,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
