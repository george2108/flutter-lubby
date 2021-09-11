import 'package:flutter/material.dart';
import 'package:lubby_app/db/database_provider.dart';
import 'package:lubby_app/models/note_model.dart';

class ShowNote extends StatelessWidget {
  final NoteModel note;

  const ShowNote({required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nota'),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) {
                  return EliminacionAlert(note: note);
                },
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.pushNamed(context, 'editNote');
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.title,
                style: Theme.of(context).textTheme.headline4,
              ),
              SizedBox(height: 16.0),
              Text(
                note.body,
                style: Theme.of(context).textTheme.bodyText1,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class EliminacionAlert extends StatelessWidget {
  final NoteModel note;

  const EliminacionAlert({
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('HOla'),
      content: Text('¿Estás seguro de eliminar esta nota?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            DatabaseProvider.db.deleteNote(note.id!);
            Navigator.pushNamedAndRemoveUntil(
              context,
              "notes",
              (route) => false,
            );
          },
          child: Text('Aceptar'),
        ),
      ],
    );
  }
}
