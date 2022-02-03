import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:lubby_app/models/user_model.dart';
import 'package:lubby_app/services/shared_preferences_service.dart';

class AuthProvider with ChangeNotifier {
  SharedPreferencesService sharedPreferences = SharedPreferencesService();

  String token = '';
  UserModel user = UserModel(
      id: 0,
      uuid: '',
      sub: 0,
      email: '',
      nombre: '',
      apellidos: '',
      picUrl: '',
      createdAt: '');
  bool isLogged = false;

  AuthProvider() {
    token = sharedPreferences.token;
    if (sharedPreferences.token.isNotEmpty) {
      isLogged = true;
    }
    if (isLogged) {
      if (sharedPreferences.user.isNotEmpty) {
        final usuarioJson = jsonDecode(sharedPreferences.user);
        user = UserModel.fromMap(usuarioJson);
        notifyListeners();
      }
    }
  }
}
