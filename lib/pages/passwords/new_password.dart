import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:lubby_app/models/password_model.dart';

import 'package:lubby_app/pages/passwords/password_controller.dart';
import 'package:lubby_app/providers/passwords_provider.dart';
import 'package:provider/provider.dart';

class NewPassword extends StatelessWidget {
  final _globalKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _passwordProvider = Provider.of<PasswordsProvider>(context);

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
          _buttonLogin(context, _passwordProvider),
        ],
      ),
    );
  }

  Widget _description() {
    return TextFormField(
      controller: _descriptionController,
      maxLines: 1,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        hintText: "Descipción de la contraseña",
        labelText: 'Descripción',
        suffixIcon: _descriptionController.text.trim().length > 0
            ? IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  _descriptionController.clear();
                },
              )
            : null,
      ),
    );
  }

  Widget _password() {
    return TextFormField(
      controller: _passwordController,
      maxLines: 1,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.visiblePassword,
      // obscureText: _passwordProvider.obscurePassword,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(Icons.remove_red_eye),
          onPressed: () {
            // _passwordController.obscurePassword.toggle();
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        labelText: 'Contraseña',
        hintText: "Contraseña",
      ),
      validator: (_) {
        return _passwordController.text.trim().length > 0
            ? null
            : 'Contraseña requerida';
      },
    );
  }

  Widget _userPassword() {
    return TextFormField(
      controller: _userController,
      maxLines: 1,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        labelText: 'Usuario',
        hintText: "Usuario de la cuenta",
        suffixIcon: _userController.text.trim().length > 0
            ? IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  _userController.clear();
                },
              )
            : null,
      ),
    );
  }

  Widget _titlePassword() {
    return TextFormField(
      controller: _titleController,
      maxLines: 1,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        hintText: 'Titulo de la contraseña',
        labelText: 'Titulo',
        suffixIcon: _titleController.text.trim().length > 0
            ? IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  _titleController.clear();
                },
              )
            : null,
      ),
      validator: (_) {
        return _titleController.text.trim().length > 0
            ? null
            : 'Titulo requerido';
      },
    );
  }

  _buttonLogin(BuildContext context, PasswordsProvider provider) {
    return Container(
      width: double.infinity,
      child: ArgonButton(
        height: 50,
        width: 350,
        child: Text(
          'Guardar',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
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
            final passwordModel = PasswordModel(
              title: _titleController.text.trim(),
              password: _passwordController.text.trim(),
              description: _passwordController.text.trim(),
              user: _userController.text.trim(),
            );
            if (_globalKey.currentState!.validate()) {
              await provider.savePassword(passwordModel);
            }
            stopLoading();
            // navegar
          }
        },
      ),
    );
  }
}
