import 'package:dio/dio.dart';

import '../../../data/datasources/local/database_service.dart';
import '../../../data/datasources/remote/http_service.dart';
import '../../../data/datasources/remote/sync_server_service.dart';
import '../../labels/domain/entities/label_entity.dart';
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

    List<PasswordEntity> resultPasswords = [];

    for (var i = 0; i < res.length; i++) {
      PasswordEntity password = PasswordEntity.fromMap(res[i]);

      if (password.labelId != null) {
        final label = await DatabaseService().findById(
          kLabelsTable,
          where: 'appId = ?',
          whereArgs: [password.labelId],
        );
        if (label != null) {
          password = password.copyWith(
            label: LabelEntity.fromMap(Map<String, dynamic>.from(label)),
          );
        }
      }

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
      where: "appId = ?",
      whereArgs: [password.appId],
    );
  }

  @override
  Future<PasswordEntity> getById(int id) async {
    final res = await DatabaseService().findById(
      kPasswordsTable,
      where: 'appId = ?',
      whereArgs: [id],
    );

    if (res != null && res['labelId'] != null) {
      final label = await DatabaseService().findById(
        kLabelsTable,
        where: 'appId = ?',
        whereArgs: [res['labelId']],
      );
      if (label != null) {
        res['label'] = label;
      }
    }

    return PasswordEntity.fromMap(res!);
  }
}
