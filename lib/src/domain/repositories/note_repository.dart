import '../../data/entities/note_entity.dart';

abstract class NoteRepository {
  Future<void> addNewNote(NoteEntity note);

  Future<List<NoteEntity>> getAllNotes();

  Future<int> updateNote(NoteEntity note);

  Future<int> deleteNote(int id);

  Future<List<NoteEntity>> searchNote(String term);
}
