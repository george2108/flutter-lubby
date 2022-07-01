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
  bool _important = false;

  get notes => _notes;

  Future<void> getNotes() async {
    final List<NoteModel> notes = await DatabaseProvider.db.getAllNotes();
    this._notes = notes;
  }

  saveNote(NoteModel note) {
    this._notes.add(note);
    notifyListeners();
  }

  get getNoteColor => noteColor[index]['color'];

  void selectNoteColor(int indexParam) {
    final indexToFalse =
        noteColor.indexWhere((element) => element["selected"] == true);
    noteColor[indexToFalse]["selected"] = false;
    noteColor[indexParam]["selected"] = true;
    index = indexParam;
    notifyListeners();
  }

  get important => _important;

  void setNoteImportant(bool value) {
    this._important = value;
    notifyListeners();
  }
}
