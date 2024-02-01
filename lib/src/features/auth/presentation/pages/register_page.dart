import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/routes/routes.dart';
import '../../../../ui/widgets/custom_snackbar_widget.dart';
import '../../domain/dto/register_request_dto.dart';
import '../bloc/auth_bloc.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: BlocProvider.of<AuthBloc>(context, listen: false),
      listenWhen: (previous, current) {
        if (current is AuthSuccess) {
          return true;
        }

        if (current is AuthFailure) {
          return true;
        }

        return false;
      },
      listener: (context, state) {
        if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            CustomSnackBarWidget(
              title: state.message,
              type: TypeSnackbar.error,
            ),
          );
        }

        if (state is AuthSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            CustomSnackBarWidget(
              title: 'Registro exitoso, Bienvenido ${state.user?.firstName}',
            ),
          );

          Navigator.pushNamedAndRemoveUntil(
            context,
            passwordsRoute,
            (route) => false,
          );
        }
      },
      child: const ScaffolPage(),
    );
  }
}

///
///  Page
///
class ScaffolPage extends StatefulWidget {
  const ScaffolPage({super.key});

  @override
  State<ScaffolPage> createState() => _ScaffolPageState();
}

class _ScaffolPageState extends State<ScaffolPage> {
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  bool acceptTerms = false;
  bool acceptPrivacy = false;

  _register() {
    if (!mounted) {
      return;
    }

    if (globalKey.currentState == null ||
        !globalKey.currentState!.validate() ||
        !acceptTerms ||
        !acceptPrivacy) {
      return;
    }

    final bloc = BlocProvider.of<AuthBloc>(context, listen: false);

    final RegisterRequestDTO dto = RegisterRequestDTO(
      email: emailController.text,
      password: passwordController.text,
      firstName: firstNameController.text,
      lastName: lastNameController.text,
    );

    bloc.add(AuthRegisterEvent(data: dto));
  }

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
              textInputAction: TextInputAction.next,
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
              textInputAction: TextInputAction.next,
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
              textInputAction: TextInputAction.next,
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
              textInputAction: TextInputAction.next,
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
              textInputAction: TextInputAction.done,
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
              onPressed: _register,
              child: const Text('Registrarse'),
            ),
            Container(
              alignment: Alignment.center,
              child: TextButton(
                child: const Text('¿Ya tienes una cuenta? Inicia sesión'),
                onPressed: () {
                  context.push(Routes().login.path);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
