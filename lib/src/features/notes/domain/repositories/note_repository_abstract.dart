import 'package:lubby_app/src/features/notes/domain/entities/note_entity.dart';

abstract class NoteRepositoryAbstract {
  Future<int> addNewNote(NoteEntity note);

  Future<List<NoteEntity>> getAllNotes();

  Future<int> updateNote(NoteEntity note);

  Future<int> deleteNote(int id);

  Future<List<NoteEntity>> searchNote(String term);
}
