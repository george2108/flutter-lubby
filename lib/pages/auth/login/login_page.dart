import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:lubby_app/pages/auth/login/login_controller.dart';

class LoginPage extends StatelessWidget {
  final LoginController _loginController = Get.find<LoginController>();
  final GlobalKey<FormState> _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).canvasColor,
        actions: [
          TextButton(
            onPressed: () {
              Get.toNamed('/register');
            },
            child: Text('Registrarme'),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30),
                  Form(
                    key: _globalKey,
                    child: Column(
                      children: [
                        SizedBox(height: 15),
                        _email(),
                        SizedBox(height: 15),
                        _password(),
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
        child: Text(
          'Iniciar sesión',
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
            if (_globalKey.currentState!.validate()) {
              // await _passwordController.savePassword();
              print('login');
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
        controller: _loginController.passwordController,
        maxLines: 1,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: TextInputType.visiblePassword,
        obscureText: _loginController.obscurePassword.value,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(Icons.remove_red_eye),
            onPressed: () {
              _loginController.obscurePassword.value =
                  _loginController.obscurePassword.value ? false : true;
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          labelText: 'Contraseña',
          hintText: "Contraseña",
        ),
        validator: (_) {
          return _loginController.passwordController.text.trim().length > 0
              ? null
              : 'Contraseña requerida';
        },
      ),
    );
  }

  Widget _email() {
    return TextFormField(
      controller: _loginController.emailController,
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
        if (_loginController.emailController.text.trim().length < 1)
          return 'Email requerido';
        if (!GetUtils.isEmail(_loginController.emailController.text.trim()))
          return 'Email no valido';
        return null;
      },
    );
  }
}
