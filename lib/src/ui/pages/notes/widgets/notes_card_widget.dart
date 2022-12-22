import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_quill/flutter_quill.dart' as flutter_quill;

import '../../../../data/entities/note_entity.dart';
import '../views/note_view.dart';
// muestra las notas en el listado

class NoteCardWidget extends StatelessWidget {
  final NoteEntity note;

  const NoteCardWidget({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatDate =
        DateFormat('d MMM y', 'es').add_jm().format(note.createdAt);
    final plainText = flutter_quill.Document.fromJson(
      jsonDecode(note.body),
    ).toPlainText();
    final containsImage =
        note.body.contains('custom') && note.body.contains('image_notes');

    return GestureDetector(
      onLongPress: () {
        print('sacar opciones');
      },
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (_) => NoteView(
              note: note,
              notesContext: context,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(4.0),
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: note.color,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Visibility(
                  visible: note.favorite == 1,
                  child: const Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                note.title.trim().isEmpty ? '* Nota sin titulo' : note.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                plainText,
                maxLines: 10,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Visibility(
                  visible: containsImage,
                  child: const Icon(Icons.photo_library_outlined),
                ),
                const Icon(Icons.alarm),
                const Icon(Icons.calendar_month),
              ],
            ),
            const SizedBox(height: 5),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(formatDate),
            ),
          ],
        ),
      ),
    );
  }
}