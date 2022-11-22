import 'package:sqflite/sqflite.dart';

import 'package:lubby_app/core/constants/db_tables_name_constants.dart';
import 'package:lubby_app/db/database_provider.dart';
import 'package:lubby_app/models/note_model.dart';

class NotesDatabaseProvider {
  static final NotesDatabaseProvider provider =
      NotesDatabaseProvider._internal();

  factory NotesDatabaseProvider() {
    return provider;
  }

  NotesDatabaseProvider._internal();

  Future<void> addNewNote(NoteModel note) async {
    final db = await DatabaseProvider.db.database;
    db.insert(
      kNotesTable,
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<NoteModel>> getAllNotes() async {
    final db = await DatabaseProvider.db.database;
    final res = await db.query(
      kNotesTable,
      orderBy: "favorite DESC, createdAt DESC",
    );
    if (res.isEmpty) return [];
    final resultMap = res.toList();
    List<NoteModel> resultNotes = [];
    for (var i = 0; i < resultMap.length; i++) {
      final note = Map<String, dynamic>.from(resultMap[i]);
      final noteFromMap = NoteModel.fromMap(note);
      resultNotes.add(noteFromMap);
    }
    return resultNotes;
  }

  Future<int> updateNote(NoteModel note) async {
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

  Future<List<NoteModel>> searchNote(String term) async {
    final db = await DatabaseProvider.db.database;
    final results = await db.query(
      kNotesTable,
      where: 'title LIKE "%$term%" OR body LIKE "%$term%"',
    );
    if (results.isEmpty) return [];
    return results.map((e) => NoteModel.fromMap(e)).toList();
  }
}
