import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lubby_app/db/database_provider.dart';
import 'package:lubby_app/models/note_model.dart';
import 'package:lubby_app/pages/notes/display_note.dart';
import 'package:lubby_app/pages/notes/new_note.dart';
import 'package:lubby_app/pages/notes/note_controller.dart';
import 'package:lubby_app/widgets/menu_drawer.dart';
import 'package:lubby_app/widgets/no_data_widget.dart';

class NotesPage extends StatelessWidget {
  final noteController = NoteController();

  Future<void> getNotes() async {
    final List<NoteModel> notes = await DatabaseProvider.db.getAllNotes();
    this.noteController.setNotes(notes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis notas'),
      ),
      drawer: Menu(),
      body: FutureBuilder(
        future: getNotes(),
        builder: (context, AsyncSnapshot snapshotData) {
          if (snapshotData.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (noteController.notes.length < 1) {
            return NoDataWidget(
              text: 'No tienes notas aún, crea una',
              lottie: 'assets/notes.json',
            );
          } else {
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: noteController.notes.length,
              itemBuilder: (context, index) {
                return Nota(
                  note: noteController.notes[index],
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.note_add),
        onPressed: () {
          Navigator.of(context).push(
            CupertinoPageRoute(
              builder: (context) => NewNote(),
            ),
          );
        },
      ),
    );
  }
}

// muestra las notas en el listado
class Nota extends StatelessWidget {
  final NoteModel note;

  const Nota({required this.note});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            CupertinoPageRoute(builder: (_) => ShowNote(note: note)),
          );
        },
        child: Card(
          color: Color(int.parse(note.color)),
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      note.createdAt.toString(),
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  note.title,
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 5),
                Text(
                  note.body,
                  style: Theme.of(context).textTheme.bodyText2,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          /* child: ListTile(
            title: Text(title),
            subtitle: Text(createdAt),
            onTap: () {
              Navigator.pushNamed(
                context,
                'showNote',
                arguments: NoteModel(
                  title: title,
                  body: body,
                  id: id,
                  createdAt: DateTime.parse(createdAt),
                  important: important,
                  color: color,
                ),
              );
            },
          ), */
        ),
      ),
    );
  }
}
