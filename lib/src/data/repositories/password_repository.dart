import 'package:lubby_app/src/data/entities/password_entity.dart';

import '../../domain/repositories/password_repository_abstract.dart';

class PasswordRepository implements PasswordRepositoryAbstract {
  @override
  Future<void> addNewPassword(PasswordEntity pass) {
    throw UnimplementedError();
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
  Future<List<PasswordEntity>> searchPassword(String term) {
    throw UnimplementedError();
  }

  @override
  Future<int> updatePassword(PasswordEntity password) {
    throw UnimplementedError();
  }
}
