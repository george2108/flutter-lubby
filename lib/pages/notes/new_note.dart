import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_quill/flutter_quill.dart';

import 'package:lubby_app/db/database_provider.dart';
import 'package:lubby_app/models/note_model.dart';

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

  QuillController _controller = QuillController.basic();

  List<Map<String, dynamic>> noteColor = [
    {
      "name": "yellow",
      "color": 0xffF3F9A7,
      "selected": true,
    },
    {
      "name": "red",
      "color": 0xffb92b27,
      "selected": false,
    },
    {
      "name": "purple",
      "color": 0xff8E2DE2,
      "selected": false,
    },
    {
      "name": "blue",
      "color": 0xff1565C0,
      "selected": false,
    },
    {
      "name": "green",
      "color": 0xff38ef7d,
      "selected": false,
    },
  ];
  int index = 0;

  moverScroll() {
    _scrollController.animateTo(250,
        duration: Duration(milliseconds: 100), curve: Curves.bounceIn);
  }

  @override
  void initState() {
    _scrollController.addListener(() => moverScroll());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Nueva nota'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      child: Text(
                        'Seleccionar el color de la nota',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _noteColor(width: size.width * 0.1, index: 0),
                        _noteColor(width: size.width * 0.1, index: 1),
                        _noteColor(width: size.width * 0.1, index: 2),
                        _noteColor(width: size.width * 0.1, index: 3),
                        _noteColor(width: size.width * 0.1, index: 4),
                      ],
                    ),
                    _important(),
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hintText: "Titulo de la nota",
                      ),
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    /* Expanded(
                      child: TextField(
                        controller: bodyController,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Escribe tu nota",
                        ),
                      ),
                    ), */
                  ],
                ),
              ),
            ),
          ),
          _buttonSave(context, size.width),
        ],
      ),
    );
  }

  Widget _noteColor({
    required double width,
    required int index,
  }) {
    return GestureDetector(
      onTap: () {
        noteColor.forEach((element) {
          element["selected"] = false;
        });
        noteColor[index]["selected"] = true;
        this.index = index;
        setState(() {});
      },
      child: Container(
        color: noteColor[index]["selected"] ? Colors.black : Colors.transparent,
        padding: EdgeInsets.all(5),
        child: Container(
          width: width,
          height: width,
          color: Color(noteColor[index]["color"]),
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
      color: Theme.of(context).buttonColor,
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