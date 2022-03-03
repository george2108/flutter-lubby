import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:get/route_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:lubby_app/pages/auth/register/register_controller.dart';
import 'package:lubby_app/widgets/show_snackbar_widget.dart';

class RegisterPage extends StatelessWidget {
  final RegisterController _registerController = Get.find<RegisterController>();
  final GlobalKey<FormState> _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).canvasColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Text(
                    'Registro',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Form(
                    key: _globalKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 15),
                        _nombre(),
                        const SizedBox(height: 15),
                        _apellidos(),
                        const SizedBox(height: 15),
                        _telefono(),
                        const SizedBox(height: 15),
                        _email(),
                        const SizedBox(height: 15),
                        _password(),
                        const SizedBox(height: 15),
                        _confirmPassword(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          _buttonLogin(context)
        ],
      ),
    );
  }

  Widget _buttonLogin(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ArgonButton(
        height: 50,
        width: 350,
        child: const Text(
          'Registrarme',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
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
              final registrado = await _registerController.register();
              if (registrado) {
                showSnackBarWidget(
                  title: 'Registrado',
                  message: 'Se ha completado tu registro exitosamente',
                  type: TypeSnackbar.success,
                );
                Get.offNamedUntil('/passwords', (route) => false);
              }
            }
            stopLoading();
            // navegar
          }
        },
      ),
    );
  }

  Widget _password() {
    return Obx(
      () => TextFormField(
        controller: _registerController.passwordController,
        maxLines: 1,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: TextInputType.visiblePassword,
        obscureText: _registerController.obscurePassword.value,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: const Icon(Icons.remove_red_eye),
            onPressed: () {
              _registerController.obscurePassword.value =
                  _registerController.obscurePassword.value ? false : true;
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          labelText: 'Contraseña',
          hintText: "Contraseña",
        ),
        validator: (_) {
          if (_registerController.passwordController.text.trim().length < 1)
            return 'Contraseña requerida';
          if (_registerController.passwordController.text.trim().length > 0 &&
              _registerController.passwordController.text.trim().length < 8)
            return 'La contraseña debe tener minimo 8 letras';
          return null;
        },
      ),
    );
  }

  Widget _confirmPassword() {
    return Obx(
      () => TextFormField(
        controller: _registerController.confirmPasswordController,
        maxLines: 1,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: TextInputType.visiblePassword,
        obscureText: _registerController.obscurePassword.value,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: const Icon(Icons.remove_red_eye),
            onPressed: () {
              _registerController.obscurePassword.value =
                  _registerController.obscurePassword.value ? false : true;
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          labelText: 'Confirmar contraseña',
          hintText: "Confirma tu nueva contraseña",
        ),
        validator: (_) {
          return _registerController.confirmPasswordController.text.trim() !=
                  _registerController.passwordController.text.trim()
              ? 'La contraseña no coincide'
              : null;
        },
      ),
    );
  }

  Widget _email() {
    return TextFormField(
      controller: _registerController.emailController,
      maxLines: 1,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        labelText: 'Correo electrónico',
        hintText: "Escribe tu correo electrónico",
      ),
      validator: (_) {
        if (_registerController.emailController.text.trim().length < 1)
          return 'Email requerido';
        if (!GetUtils.isEmail(_registerController.emailController.text.trim()))
          return 'Email no valido';
        return null;
      },
    );
  }

  Widget _nombre() {
    return TextFormField(
      controller: _registerController.firstNameController,
      maxLines: 1,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        labelText: 'Nombre(s)',
        hintText: "Escribe tu(s) nombre(s)",
      ),
      validator: (_) {
        if (_registerController.firstNameController.text.trim().length < 1)
          return 'nombre requerido';
        return null;
      },
    );
  }

  Widget _apellidos() {
    return TextFormField(
      controller: _registerController.lastNameController,
      maxLines: 1,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        labelText: 'Apellido(s)',
        hintText: "Escribe tu(s) apellido(s)",
      ),
    );
  }

  Widget _telefono() {
    return TextFormField(
      controller: _registerController.telefonoController,
      maxLines: 1,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        labelText: 'Teléfono',
        hintText: "Escribe número de teléfono",
      ),
    );
  }
}
