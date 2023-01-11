import 'package:lubby_app/src/domain/entities/note_abstract_entity.dart';

abstract class NoteRepositoryAbstract {
  Future<void> addNewNote(NoteAbstractEntity note);

  Future<List<NoteAbstractEntity>> getAllNotes();

  Future<int> updateNote(NoteAbstractEntity note);

  Future<int> deleteNote(int id);

  Future<List<NoteAbstractEntity>> searchNote(String term);
}
