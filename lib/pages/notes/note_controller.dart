import 'package:get/state_manager.dart';
import 'package:lubby_app/db/database_provider.dart';
import 'package:lubby_app/models/note_model.dart';

class NoteController extends GetxController {
  List<NoteModel> _notes = [];

  NoteModel noteModelData = NoteModel(
    title: '',
    body: '',
    createdAt: DateTime.now(),
    important: 0,
    color: 0,
  );

  get notes => this._notes;

  Future<void> getNotes() async {
    final List<NoteModel> notes = await DatabaseProvider.db.getAllNotes();
    this._notes = notes;
  }
}
