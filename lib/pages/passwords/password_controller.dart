import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lubby_app/db/database_provider.dart';
import 'package:lubby_app/models/password_model.dart';
import 'package:lubby_app/services/password_service.dart';

class PasswordController extends GetxController {
  final _passwordService = Get.find<PasswordService>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  List<PasswordModel> _passwords = [];

  RxBool obscurePassword = true.obs;
  RxBool showPassword = false.obs;

  PasswordModel passwordModelData = PasswordModel(title: '', password: '');

  get passwords => this._passwords;

  Future<void> savePassword() async {
    // encripta la contraseña
    final passEncrypt =
        _passwordService.encrypt(passwordController.text.toString());
    final createdAt = DateTime.now();

    PasswordModel passwordModel = PasswordModel(
      title: titleController.text,
      user: userController.text,
      password: passEncrypt,
      description: descriptionController.text,
      createdAt: createdAt,
    );
    await _passwordService.addPassword(passwordModel);
    obscurePassword.value = true;
    Get.offNamedUntil('/passwords', (route) => false);
  }

  Future<bool> editPassword(int id) async {
    // encripta la contraseña
    final passEncrypt =
        _passwordService.encrypt(passwordController.text.toString());
    final createdAt = DateTime.now();

    PasswordModel passwordModel = PasswordModel(
      id: id,
      title: titleController.text,
      user: userController.text,
      password: passEncrypt,
      description: descriptionController.text,
      createdAt: createdAt,
    );
    final count = await _passwordService.editPassword(passwordModel);
    if (count > 0) {
      obscurePassword.value = true;
      return true;
    }
    return false;
  }

  Future<void> getPasswords() async {
    final List<PasswordModel> passwordsData =
        await DatabaseProvider.db.getAllPasswords();
    _passwords = passwordsData;
  }
}
