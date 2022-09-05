part of '../notes_page.dart';

// muestra las notas en el listado

class NoteCardWidget extends StatelessWidget {
  final NoteModel note;

  const NoteCardWidget({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          note.title.trim().length == 0 ? '* Nota sin titulo' : note.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Text(note.createdAt.toString()),
        ),
        leading: CircleAvatar(
          backgroundColor: note.color,
          child: Text(
            note.title.trim().length > 0
                ? note.title.trim().toUpperCase()[0]
                : '*',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        trailing: Visibility(
          visible: note.favorite == 1,
          child: const Icon(
            Icons.star,
            color: Colors.yellow,
          ),
        ),
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
      ),
    );
  }
}
