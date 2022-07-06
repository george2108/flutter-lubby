import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lubby_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  final GlobalKey<FormState> _globalKey = GlobalKey();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).canvasColor,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/register');
            },
            child: const Text('Registrarme'),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Text(
                    'Login',
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
                        _email(),
                        const SizedBox(height: 15),
                        _password(context),
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
          'Iniciar sesión',
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
              // await _passwordController.savePassword();
            }
            stopLoading();
            // navegar
          }
        },
      ),
    );
  }

  Widget _password(BuildContext context) {
    return TextFormField(
      controller: _passwordController,
      maxLines: 1,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.visiblePassword,
      obscureText: context.watch<AuthProvider>().obscurePassword,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: const Icon(Icons.remove_red_eye),
          onPressed: () {
            context.read<AuthProvider>().obscurePassword =
                context.watch<AuthProvider>().obscurePassword ? false : true;
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

  Widget _email() {
    return TextFormField(
      controller: _emailController,
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
        if (_emailController.text.trim().length < 1) return 'Email requerido';
        // TODO: USAR OTRA FORMA PARA VALIDAR EMAIL
        if (_emailController.text.trim().length < 1) return 'Email no valido';
        return null;
      },
    );
  }
}
