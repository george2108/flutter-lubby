import 'package:lubby_app/src/data/entities/password_entity.dart';
import 'package:lubby_app/src/domain/repositories/password_repository.dart';

class PasswordRepositoryImpl implements PasswordRepository {
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
