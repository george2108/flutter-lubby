import 'package:flutter/widgets.dart';
import 'package:lubby_app/db/database_provider.dart';
import 'package:lubby_app/models/password_model.dart';
import 'package:lubby_app/services/password_service.dart';

class PasswordsProvider with ChangeNotifier {
  final _passwordService = PasswordService();

  List<PasswordModel> _passwords = [];

  bool obscurePassword = true;
  bool showPassword = false;

  PasswordModel passwordModelData = PasswordModel(title: '', password: '');

  get passwords => this._passwords;

  Future<bool> savePassword(PasswordModel passwordModel) async {
    // encripta la contraseña
    passwordModel.password =
        _passwordService.encrypt(passwordModel.password.toString());
    passwordModel.createdAt = DateTime.now();

    await _passwordService.addPassword(passwordModel);

    return true;
  }

  Future<bool> editPassword(int id) async {
    // encripta la contraseña
    /*  final passEncrypt =
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
      obscurePassword = true;
      return true;
    }
    return false; */
    return true;
  }

  Future<void> getPasswords() async {
    final List<PasswordModel> passwordsData =
        await DatabaseProvider.db.getAllPasswords();
    _passwords = passwordsData;
  }
}
