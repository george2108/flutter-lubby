import 'package:sqflite/sqflite.dart';

import '../../../../core/constants/db_tables_name_constants.dart';
import '../db/database_service.dart';
import '../../../../features/passwords/domain/entities/password_entity.dart';

class PasswordsLocalService {
  static final PasswordsLocalService provider =
      PasswordsLocalService._internal();

  factory PasswordsLocalService() {
    return provider;
  }

  PasswordsLocalService._internal();

  Future<List<PasswordEntity>> getAllPasswords() async {
    final db = await DatabaseProvider.db.database;
    final res = await db.query(
      kPasswordsTable,
      orderBy: "favorite DESC, createdAt DESC",
    );

    if (res.isEmpty) return [];
    final resultMap = res.toList();
    List<PasswordEntity> resultPasswords = [];
    for (var i = 0; i < resultMap.length; i++) {
      final pass = Map<String, dynamic>.from(resultMap[i]);
      final password = PasswordEntity.fromMap(pass);
      resultPasswords.add(password);
    }
    return resultPasswords;
  }

  Future<void> addNewPassword(PasswordEntity pass) async {
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

  Future<int> updatePassword(PasswordEntity password) async {
    final db = await DatabaseProvider.db.database;
    return await db.update(
      kPasswordsTable,
      password.toMap(),
      where: 'id = ${password.id}',
    );
  }

  Future<List<PasswordEntity>> searchPassword(String term) async {
    final db = await DatabaseProvider.db.database;
    final results = await db.query(
      kPasswordsTable,
      where: 'title LIKE "%$term%"',
    );
    if (results.isEmpty) return [];
    return results.map((e) => PasswordEntity.fromMap(e)).toList();
  }
}
