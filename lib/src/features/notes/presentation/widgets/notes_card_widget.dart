import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:intl/intl.dart';
import 'package:flutter_quill/flutter_quill.dart' as flutter_quill;

import '../../../../core/utils/get_contrasting_text_color.dart';
import '../helpers/notes_embed.dart';
import '../../../../config/routes/routes.dart';
import '../../../../config/routes_settings/note_route_settings.dart';
import '../../domain/entities/note_entity.dart';
// muestra las notas en el listado

class NoteCardWidget extends StatefulWidget {
  final NoteEntity note;

  const NoteCardWidget({Key? key, required this.note}) : super(key: key);

  @override
  State<NoteCardWidget> createState() => _NoteCardWidgetState();
}

class _NoteCardWidgetState extends State<NoteCardWidget> {
  navigate() {
    Navigator.pushNamed(
      context,
      noteRoute,
      arguments: NoteRouteSettings(
        notesContext: context,
        note: widget.note,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final formatDate =
        DateFormat('dd MMM y', 'es').add_jm().format(widget.note.createdAt);

    return InkWell(
      onLongPress: () {
        print('sacar opciones');
      },
      onTap: navigate,
      child: Container(
        margin: const EdgeInsets.all(4.0),
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: widget.note.color.withOpacity(0.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Visibility(
                  visible: widget.note.favorite,
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
                widget.note.title.trim().isEmpty
                    ? '* Nota sin titulo'
                    : widget.note.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: getContrastingTextColor(
                    widget.note.color.withOpacity(0.5),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Divider(
              height: 5,
              thickness: 2,
              color: getContrastingTextColor(widget.note.color),
            ),
            const SizedBox(height: 5),
            flutter_quill.QuillEditor(
              focusNode: FocusNode(canRequestFocus: false, skipTraversal: true),
              embedBuilders: [
                ...FlutterQuillEmbeds.builders(),
                NotesEmbedBuilder(addImage: (context) async => {}),
              ],
              scrollController: ScrollController(),
              controller: flutter_quill.QuillController(
                document: flutter_quill.Document.fromJson(
                  jsonDecode(widget.note.body),
                ),
                selection: const TextSelection.collapsed(offset: 0),
              ),
              readOnly: true,
              expands: false,
              padding: const EdgeInsets.all(0),
              autoFocus: false,
              scrollable: true,
              onTapDown: (details, p1) {
                navigate();
                return false;
              },
              scrollBottomInset: 20,
              scrollPhysics: const NeverScrollableScrollPhysics(),
              maxHeight: 300,
            ),
            const SizedBox(height: 5),
            if (widget.note.label != null)
              Chip(
                label: Text(
                  widget.note.label!.name,
                  style: TextStyle(
                    color: getContrastingTextColor(
                      widget.note.label!.color.withOpacity(0.5),
                    ),
                  ),
                ),
                backgroundColor: widget.note.label!.color.withOpacity(0.5),
                avatar: CircleAvatar(
                  backgroundColor: widget.note.label!.color,
                  child: Icon(
                    widget.note.label!.icon,
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
                  color: getContrastingTextColor(
                    widget.note.color.withOpacity(0.5),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
