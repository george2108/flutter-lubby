import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';

import 'package:lubby_app/pages/passwords/password_controller.dart';

class NewPassword extends StatelessWidget {
  final _passwordController = Get.find<PasswordController>();
  final _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _passwordController.passwordController.clear();
    _passwordController.titleController.clear();
    _passwordController.userController.clear();
    _passwordController.descriptionController.clear();

    return Scaffold(
      appBar: AppBar(
        title: Text('Nueva contraseña'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
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
                    ],
                  ),
                ),
              ),
            ),
          ),
          _buttonLogin(context),
        ],
      ),
    );
  }

  Widget _description() {
    return TextFormField(
      controller: _passwordController.descriptionController,
      maxLines: 1,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        hintText: "Descipción de la contraseña",
        labelText: 'Descripción',
        suffixIcon:
            _passwordController.descriptionController.text.trim().length > 0
                ? IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      _passwordController.descriptionController.clear();
                    },
                  )
                : null,
      ),
    );
  }

  Widget _password() {
    return Obx(
      () => TextFormField(
        controller: _passwordController.passwordController,
        maxLines: 1,
        keyboardType: TextInputType.visiblePassword,
        obscureText: _passwordController.obscurePassword.value,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(Icons.remove_red_eye),
            onPressed: () {
              _passwordController.obscurePassword.toggle();
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          labelText: 'Contraseña',
          hintText: "Contraseña",
        ),
        validator: (_) {
          return _passwordController.passwordController.text.trim().length > 0
              ? null
              : 'Contraseña requerida';
        },
      ),
    );
  }

  Widget _userPassword() {
    return TextFormField(
      controller: _passwordController.userController,
      maxLines: 1,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        labelText: 'Usuario',
        hintText: "Usuario de la cuenta",
        suffixIcon: _passwordController.userController.text.trim().length > 0
            ? IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  _passwordController.userController.clear();
                },
              )
            : null,
      ),
    );
  }

  Widget _titlePassword() {
    return TextFormField(
      controller: _passwordController.titleController,
      maxLines: 1,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        hintText: 'Titulo de la contraseña',
        labelText: 'Titulo',
        suffixIcon: _passwordController.titleController.text.trim().length > 0
            ? IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  _passwordController.titleController.clear();
                },
              )
            : null,
      ),
      validator: (_) {
        return _passwordController.titleController.text.trim().length > 0
            ? null
            : 'Titulo requerido';
      },
    );
  }

  _buttonLogin(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(5),
      child: ArgonButton(
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
            if (_globalKey.currentState!.validate()) {
              await _passwordController.savePassword();
            }
            stopLoading();
            // navegar
          }
        },
      ),
    );
  }
}
