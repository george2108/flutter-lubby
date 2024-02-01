import 'package:dio/dio.dart';

import '../../../data/datasources/local/database_service.dart';
import '../../../data/datasources/remote/http_service.dart';
import '../../../data/datasources/remote/sync_server_service.dart';
import '../entities/password_entity.dart';
import '../../../core/constants/db_tables_name_constants.dart';
import 'password_repository_abstract.dart';

class PasswordRepository implements PasswordRepositoryAbstract {
  final HttpService httpService;
  final SyncServerService syncServerService;

  PasswordRepository({
    required this.httpService,
    required this.syncServerService,
  });

  @override
  Future<int> addNewPassword(PasswordEntity pass) async {
    final Map<String, dynamic> passwordMap = pass.toMap();

    try {
      await syncServerService.syncElements(passwordMap, "/passwords");

      return await DatabaseService().save(
        kPasswordsTable,
        passwordMap,
      );
    } on DioException catch (_) {
      return await DatabaseService().save(
        kPasswordsTable,
        passwordMap,
      );
    }
  }

  @override
  Future<int> deletePassword(int id) {
    throw UnimplementedError();
  }

  @override
  Future<List<PasswordEntity>> getAllPasswords() async {
    final res = await DatabaseService().find(
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
    return DatabaseService().update(
      kPasswordsTable,
      password.toMap(),
      where: "id = ?",
      whereArgs: [password.id],
    );
  }

  @override
  Future<PasswordEntity> getById(int id) async {
    final res = await DatabaseService().findById(
      kPasswordsTable,
      where: 'appId = ?',
      whereArgs: [id],
    );
    return PasswordEntity.fromMap(res!);
  }
}
