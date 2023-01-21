import 'package:lubby_app/src/core/constants/db_tables_name_constants.dart';
import 'package:lubby_app/src/data/entities/note_entity.dart';
import 'package:lubby_app/src/domain/repositories/note_repository_abstract.dart';
import 'package:sqflite/sqflite.dart';

import '../datasources/local/db/database_service.dart';
import '../entities/label_entity.dart';

class NoteRepository extends NoteRepositoryAbstract {
  @override
  Future<int> addNewNote(NoteEntity note) async {
    final db = await DatabaseProvider.db.database;
    return db.insert(
      kNotesTable,
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<int> deleteNote(int id) async {
    final db = await DatabaseProvider.db.database;
    int count = await db.rawDelete(
      "DELETE FROM $kNotesTable WHERE id = ?",
      [id],
    );
    return count;
  }

  @override
  Future<List<NoteEntity>> getAllNotes() async {
    final db = await DatabaseProvider.db.database;
    final res = await db.query(
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
    final db = await DatabaseProvider.db.database;
    final results = await db.query(
      kNotesTable,
      where: 'title LIKE "%$term%" OR body LIKE "%$term%"',
    );
    if (results.isEmpty) return [];
    return results.map((e) => NoteEntity.fromMap(e)).toList();
  }

  @override
  Future<int> updateNote(NoteEntity note) async {
    final db = await DatabaseProvider.db.database;
    return await db.update(
      kNotesTable,
      note.toMap(),
      where: 'id = ${note.id}',
    );
  }
}
