import 'package:lubby_app/src/data/entities/password_entity.dart';

abstract class PasswordRepository {
  Future<List<PasswordEntity>> getPasswords();

  Future<void> addNewPassword(PasswordEntity pass);

  Future<int> deletePassword(int id);

  Future<int> updatePassword(PasswordEntity password);

  Future<List<PasswordEntity>> searchPassword(String term);
}
