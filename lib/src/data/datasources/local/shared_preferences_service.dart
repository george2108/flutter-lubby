import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../features/user/domain/entities/user_entity.dart';

/*
  Recordar instalar el paquete de:
    shared_preferences:

  Inicializar en el main
    final prefs = new SharedPreferencesService();
    await prefs.initPrefs();
    
    Recuerden que el main() debe de ser async {...

*/

class SharedPreferencesService {
  late SharedPreferences _prefs;

  SharedPreferencesService() {
    initPrefs();
  }

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // GET y SET del tema
  String get tema {
    return _prefs.getString('tema') ?? '';
  }

  set tema(String value) {
    _prefs.setString('tema', value);
  }

  // token
  String get token {
    return _prefs.getString('token') ?? '';
  }

  set token(String value) {
    _prefs.setString('token', value);
  }

  // token
  UserEntity? get user {
    final userString = _prefs.getString('user') ?? '';
    if (userString.isEmpty) return null;

    final userMap = jsonDecode(userString);
    return UserEntity.fromMap(userMap);
  }

  set user(UserEntity? value) {
    if (value == null) _prefs.setString('user', '');

    final userMap = value!.toMap();
    final string = userMap.toString();
    _prefs.setString('user', string);
  }

  // configuración de generación de contraseña
  String get passwordLength {
    return _prefs.getString('passwordLength') ?? '8';
  }

  set passwordLength(String value) {
    _prefs.setString('passwordLength', value);
  }

  String get passwordUppercase {
    return _prefs.getString('passwordUppercase') ?? 'no';
  }

  set passwordUppercase(String value) {
    _prefs.setString('passwordUppercase', value);
  }

  String get passwordNumbers {
    return _prefs.getString('passwordNumbers') ?? 'no';
  }

  set passwordNumbers(String value) {
    _prefs.setString('passwordNumbers', value);
  }

  String get passwordSymbols {
    return _prefs.getString('passwordSymbols') ?? 'no';
  }

  set passwordSymbols(String value) {
    _prefs.setString('passwordSymbols', value);
  }
}
