import 'package:lubby_app/src/data/models/password_model.dart';
import 'package:lubby_app/src/domain/repositories/password_repository.dart';

class PasswordRepositoryImpl implements PasswordRepository {
  @override
  Future<void> addNewPassword(PasswordModel pass) {
    throw UnimplementedError();
  }

  @override
  Future<int> deletePassword(int id) {
    throw UnimplementedError();
  }

  @override
  Future<List<PasswordModel>> getPasswords() {
    throw UnimplementedError();
  }

  @override
  Future<List<PasswordModel>> searchPassword(String term) {
    throw UnimplementedError();
  }

  @override
  Future<int> updatePassword(PasswordModel password) {
    throw UnimplementedError();
  }
}
