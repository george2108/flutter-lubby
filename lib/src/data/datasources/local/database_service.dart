import 'package:sqflite/sqflite.dart';
import 'dart:io';

import 'db_sqflite_desktop_service.dart';
import 'db_sqflite_service.dart';

class DatabaseService {
  static final DatabaseService _singleton = DatabaseService._();
  DatabaseService._();
  factory DatabaseService() {
    return _singleton;
  }

  Future<Database> get databaseSqflite async {
    if (Platform.isAndroid || Platform.isIOS || Platform.isMacOS) {
      return DBSqfliteService().database;
    }

    return await DBSqfliteDesktopService().database;
  }

  Future<int> save(String table, dynamic data) async {
    final db = await databaseSqflite;
    return db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, Object?>>> find(
    String table, {
    bool? distinct,
    List<String>? columns,
    String? where,
    List<Object?>? whereArgs,
    String? groupBy,
    String? having,
    String? orderBy,
    int? limit,
    int? offset,
  }) async {
    final db = await databaseSqflite;
    return db.query(
      table,
      columns: columns,
      distinct: distinct,
      groupBy: groupBy,
      having: having,
      limit: limit,
      offset: offset,
      orderBy: orderBy,
      where: where,
      whereArgs: whereArgs,
    );
  }

  Future<int> update(
    String table,
    Map<String, Object?> values, {
    String? where,
    List<Object?>? whereArgs,
    ConflictAlgorithm? conflictAlgorithm,
  }) async {
    final db = await databaseSqflite;
    return db.update(
      table,
      values,
      where: where,
      whereArgs: whereArgs,
    );
  }

  Future<int> rawUpdate(String sql, [List<Object?>? arguments]) async {
    final db = await databaseSqflite;
    return db.rawUpdate(sql, arguments);
  }

  rawDelete(String sql, [List<Object?>? arguments]) async {
    final db = await databaseSqflite;
    return db.rawDelete(sql, arguments);
  }
}
