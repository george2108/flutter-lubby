import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_quill/flutter_quill.dart' as flutter_quill;
import 'package:lubby_app/src/core/utils/get_contrasting_text_color.dart';

import '../../../../config/routes/routes.dart';
import '../../../../config/routes_settings/note_route_settings.dart';
import '../../../../data/entities/note_entity.dart';
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
        Navigator.pushNamed(
          context,
          noteRoute,
          arguments: NoteRouteSettings(
            notesContext: context,
            note: note,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(4.0),
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          // bajar la intensidad del color
          color: note.color.withOpacity(0.8),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Visibility(
                  visible: note.favorite,
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
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: getContrastingTextColor(note.color),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Divider(
              height: 5,
              thickness: 2,
              color: getContrastingTextColor(note.color),
            ),
            const SizedBox(height: 5),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                plainText,
                maxLines: 10,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: getContrastingTextColor(note.color),
                ),
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
            if (note.label != null)
              Chip(
                label: Text(
                  note.label!.name,
                  style: TextStyle(
                    color: getContrastingTextColor(
                      note.label!.color.withOpacity(0.5),
                    ),
                  ),
                ),
                backgroundColor: note.label!.color.withOpacity(0.5),
                avatar: CircleAvatar(
                  backgroundColor: note.label!.color,
                  child: Icon(
                    note.label!.icon,
                    size: 15,
                  ),
                ),
              ),
            const SizedBox(height: 5),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                formatDate,
                style: TextStyle(
                  color: getContrastingTextColor(note.color),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
