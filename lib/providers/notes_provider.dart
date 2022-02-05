import 'package:flutter/widgets.dart';
import 'package:lubby_app/db/database_provider.dart';

import 'package:lubby_app/models/note_model.dart';

class NotesProvider with ChangeNotifier {
  List<NoteModel> _notes = [];

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

  get notes => _notes;

  Future<void> getNotes() async {
    final List<NoteModel> notes = await DatabaseProvider.db.getAllNotes();
    this._notes = notes;
  }

  saveNote(NoteModel note) {
    this._notes.add(note);
    notifyListeners();
  }

  void selectNoteColor(int indexParam) {
    noteColor.forEach((element) {
      element["selected"] = false;
    });
    print('indexParam');
    print(indexParam);
    noteColor[index]["selected"] = true;
    index = indexParam;
    notifyListeners();
  }
}
