import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lubby_app/db/database_provider.dart';
import 'package:lubby_app/models/password_model.dart';
import 'package:lubby_app/pages/passwords/password_controller.dart';
import 'package:lubby_app/providers/password_provider.dart';

class NewPassword extends StatefulWidget {
  @override
  _NewPasswordState createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  final _passwordController = Get.find<PasswordController>();

  final _globalKey = GlobalKey<FormState>();

  String title = '';
  String user = '';
  String password = '';
  String description = '';
  DateTime createdAt = DateTime.now();

  TextEditingController titleController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  bool ocultarPassword = true;

  Future<void> addPassword(PasswordModel pass) async {
    await DatabaseProvider.db.addNewPassword(pass);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nueva contraseña'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
          child: Form(
            key: _globalKey,
            child: Column(
              children: [
                _titlePassword(),
                SizedBox(height: 17.0),
                _userPassword(),
                SizedBox(height: 17.0),
                _password(),
                SizedBox(height: 17.0),
                _description(),
                SizedBox(height: 17.0),
                _buttonLogin(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _description() {
    return TextFormField(
      controller: descriptionController,
      maxLines: 1,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        hintText: "Descipción de la contraseña",
        labelText: 'Descripción',
      ),
    );
  }

  Widget _password() {
    return TextFormField(
      controller: passwordController,
      maxLines: 1,
      obscureText: ocultarPassword,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(Icons.remove_red_eye),
          onPressed: () {
            setState(() {
              ocultarPassword = !ocultarPassword;
            });
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        labelText: 'Contraseña',
        hintText: "Contraseña",
      ),
    );
  }

  Widget _userPassword() {
    return TextFormField(
      controller: userController,
      maxLines: 1,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        labelText: 'Usuario',
        hintText: "Usuario de la cuenta",
      ),
    );
  }

  Widget _titlePassword() {
    return TextFormField(
      controller: titleController,
      maxLines: 1,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        hintText: 'Titulo de la contraseña',
        labelText: 'Titulo',
      ),
    );
  }

  _buttonLogin(BuildContext context) {
    return ArgonButton(
      height: 50,
      width: 350,
      child: Text('Guardar'),
      borderRadius: 5.0,
      color: Theme.of(context).buttonColor,
      loader: Container(
        padding: EdgeInsets.all(10),
        child: CircularProgressIndicator(
          backgroundColor: Colors.red,
        ),
      ),
      onTap: (startLoading, stopLoading, btnState) async {
        if (btnState == ButtonState.Idle) {
          startLoading();
          await _savePassword();
          stopLoading();
          // navegar
        }
      },
    );
  }

  Future<void> _savePassword() async {
    final passProvider = PasswordProvider();
    title = titleController.text.toString();
    user = userController.text.toString();
    // encripta la contraseña
    password = passProvider.encrypt(passwordController.text.toString());
    description = descriptionController.text.toString();
    createdAt = DateTime.now();

    PasswordModel passwordModel = PasswordModel(
      title: title,
      user: user,
      password: password,
      description: description,
      createdAt: createdAt,
    );
    await addPassword(passwordModel);
    Navigator.pushNamedAndRemoveUntil(
      context,
      'passwords',
      (route) => false,
    );
  }
}
