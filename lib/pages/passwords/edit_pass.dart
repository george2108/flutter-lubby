import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lubby_app/pages/passwords/password_controller.dart';
import 'package:lubby_app/providers/password_provider.dart';
import 'package:lubby_app/widgets/show_snackbar_widget.dart';

class EditPassword extends StatelessWidget {
  final _passwordController = Get.find<PasswordController>();
  final _globalKey = GlobalKey<FormState>();
  final passProvider = Get.find<PasswordProvider>();

  @override
  Widget build(BuildContext context) {
    /* final PasswordModel pass =
        ModalRoute.of(context)!.settings.arguments as PasswordModel; */

    _passwordController.obscurePassword.value = true;

    _passwordController.titleController.text =
        _passwordController.passwordModelData.value.title;
    _passwordController.descriptionController.text =
        _passwordController.passwordModelData.value.description ?? '';
    _passwordController.userController.text =
        _passwordController.passwordModelData.value.user ?? '';
    _passwordController.passwordController.text = passProvider
        .decrypt(_passwordController.passwordModelData.value.password);

    return Scaffold(
      appBar: AppBar(
        title: Text('Editar contraseña'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
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
          _buttonLogin(
              context, _passwordController.passwordModelData.value.id!),
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

  _buttonLogin(BuildContext context, int id) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(5),
      child: ArgonButton(
        height: 50,
        width: 350,
        child: Text('Actualizar'),
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
              final resp = await _passwordController.editPassword(id);
              if (resp) {
                Get.offNamedUntil('/passwords', (route) => false);
                showSnackBarWidget(
                  title: 'Contraseña actualizada',
                  message: 'Se ha actualizado correctamente tu constraseña',
                );
              } else {
                Get.snackbar('No se pudo', 'hola');
              }
            }
            stopLoading();
            // navegar
          }
        },
      ),
    );
  }
}
