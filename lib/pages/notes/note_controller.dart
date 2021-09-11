import 'package:get/state_manager.dart';
import 'package:lubby_app/models/note_model.dart';

class NoteController extends GetxController {
  List<NoteModel> _notes = [];

  setNotes(List<NoteModel> notes) {
    this._notes = notes;
  }

  get notes => this._notes;
}
