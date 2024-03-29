import 'package:encrypt/encrypt.dart';

class PasswordService {
  // singleton
  static final PasswordService _singleton = PasswordService._internal();
  PasswordService._internal();

  factory PasswordService() {
    return _singleton;
  }

  // variables
  final String secretKey = '8364194037128453';

  // encriptar contraseña
  String encrypt(String texto) {
    final key = Key.fromUtf8(secretKey);
    final iv = IV.fromUtf8(secretKey);
    final encrypter = Encrypter(AES(key));
    return encrypter.encrypt(texto, iv: iv).base64;
  }

  String decrypt(String texto) {
    try {
      final key = Key.fromUtf8(secretKey);
      final iv = IV.fromUtf8(secretKey);
      final encrypter = Encrypter(AES(key));
      return encrypter.decrypt(Encrypted.fromBase64(texto), iv: iv);
    } catch (e) {
      return texto;
    }
  }
}
