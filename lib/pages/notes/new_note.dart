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

  @override
  Widget build(BuildContext context) {
    final _notesProvider = Provider.of<NotesProvider>(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Nueva nota'),
        actions: [
          PopupMenuButton(
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Color de nota'),
                value: 'color',
              ),
            ],
            onSelected: (value) {
              if (value == 'color') {
                showDialogElegirColor(_notesProvider);
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              child: Text(
                'Seleccionar el color de la nota',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(height: 10),
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
          _important(),
          TextField(
            controller: titleController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              hintText: "Titulo de la nota",
            ),
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
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
          Divider(
            height: 20,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                child: flutterQuill.QuillEditor.basic(
                  controller: _controller,
                  readOnly: false, // true for view only mode
                ),
              ),
            ),
          ),
          _buttonSave(context, size.width),
        ],
      ),
    );
  }

  showDialogElegirColor(NotesProvider _provider) {
    print('_provider');
    final widthColor = 50.0;
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.center,
                children: [
                  _noteColor(width: widthColor, index: 0, provider: _provider),
                  _noteColor(width: widthColor, index: 1, provider: _provider),
                  _noteColor(width: widthColor, index: 2, provider: _provider),
                  _noteColor(width: widthColor, index: 3, provider: _provider),
                  _noteColor(width: widthColor, index: 4, provider: _provider),
                ],
              ),
              Container(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text('Elegir'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _noteColor({
    required double width,
    required int index,
    required NotesProvider provider,
  }) {
    return GestureDetector(
      onTap: () {
        print('provider.index');
        print(provider.index);
        provider.selectNoteColor(index);
      },
      child: Container(
        color: provider.noteColor[index]["selected"]
            ? Colors.black
            : Colors.transparent,
        padding: EdgeInsets.all(5),
        child: Container(
          width: width,
          height: width,
          child: Stack(
            children: [
              Container(
                color: Color(provider.noteColor[index]["color"]),
              ),
              Container(
                alignment: Alignment.center,
                child: Visibility(
                  visible: provider.noteColor[index]["selected"],
                  child: Icon(Icons.check),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _buttonSave(BuildContext context, double width) {
    return ArgonButton(
      height: 50,
      width: width,
      child: Text(
        'Guardar',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      borderRadius: 5.0,
      color: Theme.of(context).buttonTheme.colorScheme!.background,
      loader: Container(
        padding: EdgeInsets.all(10),
        child: CircularProgressIndicator(
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

  Widget _important() {
    return CheckboxListTile(
      value: important,
      onChanged: (value) {
        important = value!;
        setState(() {});
      },
      title: Text('¿Importante?'),
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