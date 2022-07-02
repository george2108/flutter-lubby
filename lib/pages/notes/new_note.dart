import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:flutter_quill/flutter_quill.dart' as flutterQuill;
import 'package:lubby_app/pages/notes/note/star.widget.dart';
import 'package:lubby_app/pages/notes/notes_page.dart';
import 'package:lubby_app/providers/notes_provider.dart';
import 'package:provider/provider.dart';

import '../../models/note_model.dart';

class NewNote extends StatefulWidget {
  @override
  _NewNoteState createState() => _NewNoteState();
}

class _NewNoteState extends State<NewNote> {
  String title = '';
  String body = '';
  DateTime createdAt = DateTime.now();
  bool important = false;

  TextEditingController titleController = TextEditingController();

  flutterQuill.QuillController _controller =
      flutterQuill.QuillController.basic();

  FocusNode _focusNode = FocusNode(canRequestFocus: true);

  @override
  Widget build(BuildContext context) {
    final _notesProvider = Provider.of<NotesProvider>(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva nota'),
        actions: [
          const NoteStarWidget(),
          PopupMenuButton(
            itemBuilder: (_) => [
              const PopupMenuItem(
                child: Text('Color de nota'),
                value: 'color',
              ),
            ],
            onSelected: (value) {
              if (value == 'color') {
                showDialogElegirColor(context);
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: "Titulo de la nota",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border(
                  top: BorderSide(),
                  bottom: BorderSide(),
                  right: BorderSide(),
                  left: BorderSide(),
                ),
              ),
              child: flutterQuill.QuillToolbar.basic(
                controller: _controller,
                locale: const Locale('es'),
                showDividers: true,
                showImageButton: false,
                showVideoButton: false,
                showCameraButton: false,
                onImagePickCallback: (file) async {
                  print(file);
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                child: flutterQuill.QuillEditor(
                  scrollController: ScrollController(),
                  expands: false,
                  padding: const EdgeInsets.all(0),
                  autoFocus: true,
                  controller: _controller,
                  readOnly: false,
                  focusNode: _focusNode,
                  scrollable: true,
                  placeholder: 'Escribe tu nota aqui...',
                  scrollBottomInset: 20,
                  scrollPhysics: const BouncingScrollPhysics(),
                ),
              ),
            ),
          ),
          _buttonSave(context, size.width),
        ],
      ),
    );
  }

  _buttonSave(BuildContext context, double width) {
    return ArgonButton(
      height: 50,
      width: width,
      child: const Text(
        'Guardar',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      borderRadius: 5.0,
      color: Theme.of(context).buttonTheme.colorScheme!.background,
      loader: Container(
        padding: const EdgeInsets.all(10),
        child: const CircularProgressIndicator(
          backgroundColor: Colors.red,
        ),
      ),
      onTap: (startLoading, stopLoading, btnState) async {
        if (btnState == ButtonState.Idle) {
          startLoading();
          final data = _controller.document.toDelta().toJson();
          body = json.encode(data);

          title = titleController.text.toString();
          createdAt = DateTime.now();
          NoteModel note = NoteModel(
            title: title,
            body: body,
            createdAt: createdAt,
            important: important ? 1 : 0,
            color: context.read<NotesProvider>().getNoteColor,
          );
          // await context.read<NotesProvider>().saveNote(note);
          stopLoading();
          Navigator.pushAndRemoveUntil(
            context,
            CupertinoPageRoute(
              builder: (BuildContext context) => NotesPage(),
            ),
            (route) => false,
          );
          stopLoading();
        }
      },
    );
  }

  showDialogElegirColor(BuildContext context) {
    Color pickerColor = Color(0xff443a49);

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: ColorPicker(
                    pickerColor: pickerColor,
                    onColorChanged: changeColor,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancelar'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Elegir'),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void changeColor(Color color) {
    Color currentColor = color;
    print(currentColor);
  }

  /*  showDialogElegirColor(BuildContext context) => showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => Dialog(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SelectNoteColor(context: context),
                Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Elegir'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ); */

}

class SelectNoteColor extends StatelessWidget {
  final BuildContext context;

  const SelectNoteColor({Key? key, required this.context}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      alignment: WrapAlignment.center,
      children: List.generate(
        context.watch<NotesProvider>().noteColor.length,
        (index) => GestureDetector(
          onTap: () {
            context.read<NotesProvider>().selectNoteColor(index);
          },
          child: ItemColorNote(
            selected: context.watch<NotesProvider>().noteColor[index]
                ["selected"],
            color: context.watch<NotesProvider>().noteColor[index]["color"],
          ),
        ),
      ).toList(),
    );
  }
}

class ItemColorNote extends StatelessWidget {
  final bool selected;
  final int color;

  const ItemColorNote({
    required this.selected,
    required this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: selected ? Colors.black : Colors.transparent,
      padding: const EdgeInsets.all(5),
      child: Container(
        width: 50,
        height: 50,
        child: Stack(
          children: [
            Container(
              color: Color(color),
            ),
            Container(
              alignment: Alignment.center,
              child: Visibility(
                visible: selected,
                child: const Icon(Icons.check),
              ),
            )
          ],
        ),
      ),
    );
  }
}

/* var txt = await controller.getText();
                      if (txt.contains('src=\"data:')) {
                        txt =
                            '<text removed due to base-64 data, displaying the text could cause the app to crash>';
                      }
                      setState(() {
                        result = txt;
                      }); */
