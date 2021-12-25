import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:lubby_app/models/login_model.dart';
import 'package:lubby_app/services/http_service.dart';

class LoginController extends GetxController {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final HttpService _httpService = Get.find<HttpService>();

  RxBool obscurePassword = true.obs;

  login() {
    final LoginModel loginModel = LoginModel(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
    final login = loginModel.toMap();
    _httpService.postRequest('/auth/login', data: login);
  }
}
