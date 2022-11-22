import 'package:lubby_app/src/data/models/password_model.dart';

abstract class PasswordRepository {
  Future<List<PasswordModel>> getPasswords();

  Future<void> addNewPassword(PasswordModel pass);

  Future<int> deletePassword(int id);

  Future<int> updatePassword(PasswordModel password);

  Future<List<PasswordModel>> searchPassword(String term);
}
