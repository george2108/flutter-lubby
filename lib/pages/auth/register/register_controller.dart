import 'package:flutter/widgets.dart';
import 'package:get/state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:lubby_app/models/register_model.dart';
import 'package:lubby_app/services/http_service.dart';

class RegisterController extends GetxController {
  final HttpService _httpService = Get.find<HttpService>();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController telefonoController = TextEditingController();

  RxBool obscurePassword = true.obs;

  Future<bool> register() async {
    final RegisterModel registerModel = RegisterModel(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      nombre: firstNameController.text.trim(),
      apellidos: lastNameController.text.trim(),
      telefono: telefonoController.text.trim(),
    );
    final register = registerModel.toMap();
    final response =
        await _httpService.postRequest('/auth/register', data: register);
    if (response.data['access_token'] != null) {
      return true;
    }
    return false;
  }
}
