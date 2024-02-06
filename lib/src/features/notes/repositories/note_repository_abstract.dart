import '../entities/note_entity.dart';

abstract class NoteRepositoryAbstract {
  Future<int> addNewNote(NoteEntity note);

  Future<List<NoteEntity>> getAllNotes();

  Future<int> updateNote(NoteEntity note);

  Future<int> deleteNote(int id);

  Future<List<NoteEntity>> searchNote(String term);

  Future<NoteEntity> getById(int id);
}
