import '../entities/password_entity.dart';

abstract class PasswordRepositoryAbstract {
  Future<int> addNewPassword(PasswordEntity pass);

  Future<int> deletePassword(int id);

  Future<int> updatePassword(PasswordEntity password);

  Future<List<PasswordEntity>> searchPassword(String term);

  Future<List<PasswordEntity>> getAllPasswords();

  Future<PasswordEntity> getById(int id);
}
