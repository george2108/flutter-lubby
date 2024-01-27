import '../../../../features/notes/domain/entities/note_entity.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../core/constants/db_tables_name_constants.dart';
import '../db/database_service.dart';

class NotesLocalService {
  static final NotesLocalService provider = NotesLocalService._internal();

  factory NotesLocalService() {
    return provider;
  }

  NotesLocalService._internal();

  Future<void> addNewNote(NoteEntity note) async {
    final db = await DatabaseProvider.db.database;
    db.insert(
      kNotesTable,
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

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

  Future<int> updateNote(NoteEntity note) async {
    final db = await DatabaseProvider.db.database;
    return await db.update(
      kNotesTable,
      note.toMap(),
      where: 'id = ${note.id}',
    );
  }

  Future<int> deleteNote(int id) async {
    final db = await DatabaseProvider.db.database;
    int count = await db.rawDelete(
      "DELETE FROM $kNotesTable WHERE id = ?",
      [id],
    );
    return count;
  }

  Future<List<NoteEntity>> searchNote(String term) async {
    final db = await DatabaseProvider.db.database;
    final results = await db.query(
      kNotesTable,
      where: 'title LIKE "%$term%" OR body LIKE "%$term%"',
    );
    if (results.isEmpty) return [];
    return results.map((e) => NoteEntity.fromMap(e)).toList();
  }
}
