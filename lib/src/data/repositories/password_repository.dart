import 'package:lubby_app/src/domain/entities/password_entity.dart';
import 'package:sqflite/sqflite.dart';

import '../../core/constants/db_tables_name_constants.dart';
import '../../domain/repositories/password_repository_abstract.dart';
import '../datasources/local/db/database_service.dart';

class PasswordRepository implements PasswordRepositoryAbstract {
  @override
  Future<int> addNewPassword(PasswordEntity pass) async {
    final db = await DatabaseProvider.db.database;
    return await db.insert(
      kPasswordsTable,
      pass.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<int> deletePassword(int id) {
    throw UnimplementedError();
  }

  @override
  Future<List<PasswordEntity>> getPasswords() {
    throw UnimplementedError();
  }

  @override
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

  @override
  Future<List<PasswordEntity>> searchPassword(String term) {
    throw UnimplementedError();
  }

  @override
  Future<int> updatePassword(PasswordEntity password) async {
    final db = await DatabaseProvider.db.database;
    return db.update(
      kPasswordsTable,
      password.toMap(),
      where: "id = ?",
      whereArgs: [password.id],
    );
  }
}
