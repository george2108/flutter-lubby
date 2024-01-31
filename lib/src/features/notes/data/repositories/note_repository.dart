import '../../../../core/constants/db_tables_name_constants.dart';
import '../../../../data/datasources/local/database_service.dart';
import '../../domain/entities/note_entity.dart';
import '../../domain/repositories/note_repository_abstract.dart';

class NoteRepository extends NoteRepositoryAbstract {
  @override
  Future<int> addNewNote(NoteEntity note) async {
    return DatabaseService().save(
      kNotesTable,
      note.toMap(),
    );
  }

  @override
  Future<int> deleteNote(int id) async {
    int count = await DatabaseService().rawDelete(
      "DELETE FROM $kNotesTable WHERE id = ?",
      [id],
    );
    return count;
  }

  @override
  Future<List<NoteEntity>> getAllNotes() async {
    final res = await DatabaseService().find(
      kNotesTable,
      orderBy: "favorite DESC, createdAt DESC",
    );
    if (res.isEmpty) return [];
    final resultMap = res.toList();
    List<NoteEntity> resultNotes = [];
    for (var i = 0; i < resultMap.length; i++) {
      final note = Map<String, dynamic>.from(resultMap[i]);
      final noteFromMap = NoteEntity.fromMap(note);
      resultNotes.add(noteFromMap);
    }

    return resultNotes;
  }

  @override
  Future<List<NoteEntity>> searchNote(String term) async {
    final results = await DatabaseService().find(
      kNotesTable,
      where: 'title LIKE "%$term%" OR body LIKE "%$term%"',
    );
    if (results.isEmpty) return [];
    return results.map((e) => NoteEntity.fromMap(e)).toList();
  }

  @override
  Future<int> updateNote(NoteEntity note) async {
    return await DatabaseService().update(
      kNotesTable,
      note.toMap(),
      where: 'id = ${note.id}',
    );
  }
}
