import 'package:flutter/material.dart';
import 'package:lubby_app/src/config/routes/routes.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  bool acceptTerms = false;
  bool acceptPrivacy = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: globalKey,
        child: ListView(
          padding: const EdgeInsets.all(10.0),
          children: [
            Container(
              width: 200,
              height: 200,
              padding: const EdgeInsets.all(20.0),
              child: Image.network(
                'https://upload.wikimedia.org/wikipedia/commons/9/97/Avast_Passwords_logo.png',
              ),
            ),
            TextFormField(
              controller: firstNameController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(
                labelText: 'Nombre (s)',
                hintText: 'Nombre (s)',
              ),
              validator: (value) {
                if (value == null || value.toString().isEmpty) {
                  return 'Por favor ingresa tu nombre';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: lastNameController,
              decoration: const InputDecoration(
                labelText: 'Apellidos',
                hintText: 'Apellidos',
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: emailController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Correo electrónico',
                hintText: 'Correo electrónico',
              ),
              validator: (value) {
                if (value == null || value.toString().isEmpty) {
                  return 'Por favor ingresa tu correo electrónico';
                }

                const regexp = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                final regex = RegExp(regexp);
                if (!regex.hasMatch(value.toString())) {
                  return 'Por favor ingresa un correo electrónico válido';
                }

                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: passwordController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                hintText: 'Contraseña',
                suffixIcon: IconButton(
                  tooltip: 'Mostrar contraseña',
                  icon: const Icon(Icons.visibility),
                  onPressed: () {},
                ),
              ),
              validator: (value) {
                if (value == null || value.toString().isEmpty) {
                  return 'Por favor ingresa tu contraseña';
                }

                if (value.toString().length < 8) {
                  return 'La contraseña debe tener al menos 8 caracteres';
                }

                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              obscureText: true,
              controller: confirmPasswordController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                labelText: 'Confirmar contraseña',
                hintText: 'Confirmar contraseña',
                suffixIcon: IconButton(
                  tooltip: 'Mostrar contraseña',
                  icon: const Icon(Icons.visibility),
                  onPressed: () {},
                ),
              ),
              validator: (value) {
                if (value == null || value.toString().isEmpty) {
                  return 'Por favor confirma tu contraseña';
                }

                if (value.toString().length < 8) {
                  return 'La contraseña debe tener al menos 8 caracteres';
                }

                if (value.toString() != passwordController.text) {
                  return 'Las contraseñas no coinciden';
                }

                return null;
              },
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Checkbox(
                  value: acceptTerms,
                  onChanged: (value) {
                    setState(() {
                      acceptTerms = value!;
                    });
                  },
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Acepto los términos y condiciones'),
                )
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: acceptPrivacy,
                  onChanged: (value) {
                    setState(() {
                      acceptPrivacy = value!;
                    });
                  },
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Acepto la política de privacidad'),
                )
              ],
            ),
            const SizedBox(height: 10),
            FilledButton(
              onPressed: globalKey.currentState != null &&
                      globalKey.currentState!.validate() &&
                      acceptTerms &&
                      acceptPrivacy
                  ? () {}
                  : null,
              child: const Text('Registrarse'),
            ),
            Container(
              alignment: Alignment.center,
              child: TextButton(
                child: const Text('¿Ya tienes una cuenta? Inicia sesión'),
                onPressed: () {
                  Navigator.pushNamed(context, loginRoute);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
