import '../../data/models/note_model.dart';

abstract class NoteRepository {
  Future<void> addNewNote(NoteModel note);

  Future<List<NoteModel>> getAllNotes();

  Future<int> updateNote(NoteModel note);

  Future<int> deleteNote(int id);

  Future<List<NoteModel>> searchNote(String term);
}
