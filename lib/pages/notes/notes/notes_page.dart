import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lubby_app/models/note_model.dart';
import 'package:lubby_app/pages/notes/note/note_page.dart';
import 'package:lubby_app/pages/notes/notes/bloc/notes_bloc.dart';
import 'package:lubby_app/pages/notes/search_note_delegate.dart';
import 'package:lubby_app/widgets/menu_drawer.dart';
import 'package:lubby_app/widgets/no_data_widget.dart';

class NotesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Mis notas'),
        backgroundColor: Theme.of(context).canvasColor,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: SearchNoteDelegate());
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      drawer: Menu(),
      body: BlocProvider(
        create: (context) => NotesBloc()..add(NotesGetEvent()),
        child: BlocBuilder<NotesBloc, NotesState>(
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
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Nueva nota'),
        icon: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            CupertinoPageRoute(
              builder: (context) => NotePage(),
            ),
          );
        },
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
