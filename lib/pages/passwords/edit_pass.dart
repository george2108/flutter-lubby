import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lubby_app/providers/passwords_provider.dart';
import 'package:lubby_app/services/password_service.dart';
import 'package:lubby_app/widgets/show_snackbar_widget.dart';
import 'package:provider/provider.dart';

class EditPassword extends StatelessWidget {
  final _globalKey = GlobalKey<FormState>();
  final passService = PasswordService();
  late final PasswordsProvider _passwordProvider;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    /* final PasswordModel pass =
        ModalRoute.of(context)!.settings.arguments as PasswordModel; */
    _passwordProvider = Provider.of<PasswordsProvider>(context);

    _titleController.text = _passwordProvider.passwordModelData.title;
    _userController.text = _passwordProvider.passwordModelData.user ?? '';
    _passwordController.text =
        passService.decrypt(_passwordProvider.passwordModelData.password);
    _descriptionController.text =
        _passwordProvider.passwordModelData.description ?? '';

    _passwordProvider.obscurePassword = true;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar contraseña'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
                child: Form(
                  key: _globalKey,
                  child: Column(
                    children: [
                      _titlePassword(),
                      const SizedBox(height: 17.0),
                      _userPassword(),
                      const SizedBox(height: 17.0),
                      _password(),
                      const SizedBox(height: 17.0),
                      _description(),
                      const SizedBox(height: 17.0),
                    ],
                  ),
                ),
              ),
            ),
          ),
          _buttonLogin(context, _passwordProvider.passwordModelData.id!),
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
                icon: const Icon(Icons.clear),
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
      obscureText: _passwordProvider.obscurePassword,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: const Icon(Icons.remove_red_eye),
          onPressed: () {
            _passwordProvider.obscurePassword =
                !_passwordProvider.obscurePassword;
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
                icon: const Icon(Icons.clear),
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
                icon: const Icon(Icons.clear),
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

  _buttonLogin(BuildContext context, int id) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(5),
      child: ArgonButton(
        height: 50,
        width: 350,
        child: const Text('Actualizar'),
        borderRadius: 5.0,
        color: Theme.of(context).buttonColor,
        loader: Container(
          padding: const EdgeInsets.all(10),
          child: const CircularProgressIndicator(
            backgroundColor: Colors.red,
          ),
        ),
        onTap: (startLoading, stopLoading, btnState) async {
          if (btnState == ButtonState.Idle) {
            startLoading();
            if (_globalKey.currentState!.validate()) {
              final resp = await _passwordProvider.editPassword(id);
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
