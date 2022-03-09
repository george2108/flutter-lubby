import 'package:flutter/widgets.dart';
import 'package:lubby_app/models/login_model.dart';
import 'package:lubby_app/models/register_model.dart';
import 'package:lubby_app/services/http_service.dart';

class AuthProvider with ChangeNotifier {
  bool obscurePassword = true;

  HttpService _httpService = HttpService();

  login(LoginModel loginModel) {
    final login = loginModel.toMap();
    _httpService.postRequest('/auth/login', data: login);
  }

  Future<bool> register(RegisterModel registerModel) async {
    final register = registerModel.toMap();
    final response =
        await _httpService.postRequest('/auth/register', data: register);
    if (response.data['access_token'] != null) {
      return true;
    }
    return false;
  }
}
