import 'package:flutter/widgets.dart';

import 'package:lubby_app/models/note_model.dart';

class NotesProvider with ChangeNotifier {
  List<NoteModel> _notes = [];

  get notes => _notes;

  saveNote(NoteModel note) {
    this._notes.add(note);
    notifyListeners();
  }
}
