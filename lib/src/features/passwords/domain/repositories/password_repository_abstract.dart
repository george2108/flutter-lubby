import 'package:lubby_app/src/features/passwords/domain/entities/password_entity.dart';

abstract class PasswordRepositoryAbstract {
  Future<List<PasswordEntity>> getPasswords();

  Future<void> addNewPassword(PasswordEntity pass);

  Future<int> deletePassword(int id);

  Future<int> updatePassword(PasswordEntity password);

  Future<List<PasswordEntity>> searchPassword(String term);

  Future<List<PasswordEntity>> getAllPasswords();
}
