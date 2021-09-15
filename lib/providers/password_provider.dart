import 'package:encrypt/encrypt.dart';
import 'package:lubby_app/db/database_provider.dart';
import 'package:lubby_app/models/password_model.dart';

class PasswordProvider {
  // encriptar contraseña
  String encrypt(String texto) {
    final key = Key.fromUtf8('aplication_luby_notes_passwords.');
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    return encrypter.encrypt(texto, iv: iv).base64;
  }

  String decrypt(String texto) {
    final key = Key.fromUtf8('aplication_luby_notes_passwords.');
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    return encrypter.decrypt(Encrypted.from64(texto), iv: iv);
  }

  Future<void> addPassword(PasswordModel pass) async {
    await DatabaseProvider.db.addNewPassword(pass);
  }

  Future<int> editPassword(PasswordModel pass) async {
    return await DatabaseProvider.db.updatePassword(pass);
  }
}
