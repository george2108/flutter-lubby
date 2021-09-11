import 'package:encrypt/encrypt.dart';

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
}
