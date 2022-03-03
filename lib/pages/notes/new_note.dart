import 'package:flutter/material.dart';

import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter_quill/flutter_quill.dart' as flutterQuill;
import 'package:lubby_app/providers/notes_provider.dart';
import 'package:provider/provider.dart';

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
  TextEditingController bodyController = TextEditingController();

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
          /* Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _noteColor(width: size.width * 0.1, index: 0),
              _noteColor(width: size.width * 0.1, index: 1),
              _noteColor(width: size.width * 0.1, index: 2),
              _noteColor(width: size.width * 0.1, index: 3),
              _noteColor(width: size.width * 0.1, index: 4),
            ],
          ), */
          CheckImportant(context: context),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: "Titulo de la nota",
              ),
              style:
                  const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: flutterQuill.QuillToolbar.basic(
              controller: _controller,
              locale: Locale('es'),
              showDividers: false,
              showImageButton: true,
              onImagePickCallback: (file) async {
                print(
                    '------------------------------------aaaaaaaaaaaaaaaaaaaaaa');
                print(file);
              },
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
          /* title = titleController.text.toString();
          body = bodyController.text.toString();
          createdAt = DateTime.now();
          NoteModel note = NoteModel(
            title: title,
            body: body,
            createdAt: createdAt,
            important: important ? 1 : 0,
            color: noteColor[index]["color"].toString(),
          );
          await addNote(note);
          stopLoading();
          Navigator.pushAndRemoveUntil(
            context,
            CupertinoPageRoute(
              builder: (BuildContext context) => NotesPage(),
            ),
            (route) => false,
          ); */
          stopLoading();
        }
      },
    );
  }

  showDialogElegirColor(BuildContext context) => showDialog(
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
      );
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

class CheckImportant extends StatelessWidget {
  final BuildContext context;

  const CheckImportant({
    required this.context,
    Key? key,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: context.watch<NotesProvider>().important,
      onChanged: (value) =>
          context.read<NotesProvider>().setNoteImportant(value!),
      title: const Text('¿Importante?'),
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
