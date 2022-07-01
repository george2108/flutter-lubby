import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lubby_app/models/register_model.dart';
import 'package:lubby_app/providers/auth_provider.dart';
import 'package:lubby_app/widgets/show_snackbar_widget.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  final GlobalKey<FormState> _globalKey = GlobalKey();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();

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
              physics: const BouncingScrollPhysics(),
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
                        _password(context),
                        const SizedBox(height: 15),
                        _confirmPassword(context),
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
    final _authProvider = Provider.of<AuthProvider>(context);

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
              final registrado = await _authProvider.register(RegisterModel(
                email: _emailController.text.trim(),
                password: _passwordController.text.trim(),
                nombre: _firstNameController.text.trim(),
                apellidos: _lastNameController.text.trim(),
                telefono: _telefonoController.text.trim(),
              ));
              if (registrado) {
                showCustomSnackBarWidget(
                  title: 'Registrado',
                  content: 'Se ha completado tu registro exitosamente',
                  type: TypeSnackbar.success,
                );
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/passwords',
                  (route) => false,
                );
              }
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
        if (_passwordController.text.trim().length < 1)
          return 'Contraseña requerida';
        if (_passwordController.text.trim().length > 0 &&
            _passwordController.text.trim().length < 8)
          return 'La contraseña debe tener minimo 8 letras';
        return null;
      },
    );
  }

  Widget _confirmPassword(BuildContext context) {
    return TextFormField(
      controller: _confirmPasswordController,
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
        labelText: 'Confirmar contraseña',
        hintText: "Confirma tu nueva contraseña",
      ),
      validator: (_) {
        return _confirmPasswordController.text.trim() !=
                _passwordController.text.trim()
            ? 'La contraseña no coincide'
            : null;
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
        /*  if (!GetUtils.isEmail(_registerController.emailController.text.trim()))
          return 'Email no valido'; */
        return null;
      },
    );
  }

  Widget _nombre() {
    return TextFormField(
      controller: _firstNameController,
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
        if (_firstNameController.text.trim().length < 1)
          return 'nombre requerido';
        return null;
      },
    );
  }

  Widget _apellidos() {
    return TextFormField(
      controller: _lastNameController,
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
      controller: _telefonoController,
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
