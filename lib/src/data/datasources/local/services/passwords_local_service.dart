import 'package:sqflite/sqflite.dart';

import 'package:lubby_app/src/core/constants/db_tables_name_constants.dart';
import 'package:lubby_app/src/data/datasources/local/db/database_service.dart';
import 'package:lubby_app/src/data/models/password_model.dart';

class PasswordsLocalService {
  static final PasswordsLocalService provider =
      PasswordsLocalService._internal();

  factory PasswordsLocalService() {
    return provider;
  }

  PasswordsLocalService._internal();

  Future<List<PasswordModel>> getAllPasswords() async {
    final db = await DatabaseProvider.db.database;
    final res = await db.query(
      kPasswordsTable,
      orderBy: "favorite DESC, createdAt DESC",
    );

    if (res.isEmpty) return [];
    final resultMap = res.toList();
    List<PasswordModel> resultPasswords = [];
    for (var i = 0; i < resultMap.length; i++) {
      final pass = Map<String, dynamic>.from(resultMap[i]);
      final password = PasswordModel.fromMap(pass);
      resultPasswords.add(password);
    }
    return resultPasswords;
  }

  Future<void> addNewPassword(PasswordModel pass) async {
    final db = await DatabaseProvider.db.database;
    db.insert(
      kPasswordsTable,
      pass.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> deletePassword(int id) async {
    final db = await DatabaseProvider.db.database;
    int count = await db.rawDelete(
      "DELETE FROM $kPasswordsTable WHERE id = ?",
      [id],
    );
    return count;
  }

  Future<int> updatePassword(PasswordModel password) async {
    final db = await DatabaseProvider.db.database;
    return await db.update(
      kPasswordsTable,
      password.toMap(),
      where: 'id = ${password.id}',
    );
  }

  Future<List<PasswordModel>> searchPassword(String term) async {
    final db = await DatabaseProvider.db.database;
    final results = await db.query(
      kPasswordsTable,
      where: 'title LIKE "%$term%"',
    );
    if (results.isEmpty) return [];
    return results.map((e) => PasswordModel.fromMap(e)).toList();
  }
}
