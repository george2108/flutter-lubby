import 'dart:convert';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:lubby_app/models/user_model.dart';
import 'package:lubby_app/services/shared_preferences_service.dart';

class AuthenticationController extends GetxController {
  late SharedPreferencesService sharedPreferences;

  RxString token = ''.obs;
  late Rx<UserModel> user = UserModel(
          id: 0,
          uuid: '',
          sub: 0,
          email: '',
          nombre: '',
          apellidos: '',
          picUrl: '',
          createdAt: '')
      .obs;
  RxBool isLogged = false.obs;

  AuthenticationController() {
    sharedPreferences = Get.find<SharedPreferencesService>();
    token.value = sharedPreferences.token;
    if (sharedPreferences.token.isNotEmpty) {
      isLogged.value = true;
    }
    if (isLogged.value) {
      if (sharedPreferences.user.isNotEmpty) {
        final usuarioJson = jsonDecode(sharedPreferences.user);
        user = UserModel.fromMap(usuarioJson).obs;
      }
    }
  }
}
