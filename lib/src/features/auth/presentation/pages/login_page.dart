import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/routes/routes.dart';
import '../../../../ui/widgets/custom_snackbar_widget.dart';
import '../../domain/dto/login_request_dto.dart';
import '../bloc/auth_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener(
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
              title: 'Bienvenido ${state.user?.firstName}',
            ),
          );

          context.go(Routes().passwords.path);
        }
      },
      bloc: BlocProvider.of<AuthBloc>(context),
      child: const ScaffoldLogin(),
    );
  }
}

///
/// Build login page
///
class ScaffoldLogin extends StatefulWidget {
  const ScaffoldLogin({super.key});

  @override
  State<ScaffoldLogin> createState() => _ScaffoldLoginState();
}

class _ScaffoldLoginState extends State<ScaffoldLogin> {
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
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
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                width: double.infinity,
                alignment: Alignment.center,
                child: const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
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
                obscureText: showPassword,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  hintText: 'Contraseña',
                  suffixIcon: IconButton(
                    tooltip: 'Mostrar contraseña',
                    icon: const Icon(Icons.visibility),
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
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
              Container(
                alignment: Alignment.centerRight,
                child: TextButton(
                  child: const Text('Olvidé mi contraseña'),
                  onPressed: () {},
                ),
              ),
              FilledButton.icon(
                icon: const Icon(Icons.login),
                label: const Text('Iniciar sesión'),
                onPressed: () {
                  if (!globalKey.currentState!.validate()) {
                    return;
                  }

                  final LoginRequestDTO data = LoginRequestDTO(
                    email: emailController.text,
                    password: passwordController.text,
                  );
                  BlocProvider.of<AuthBloc>(context).add(
                    AuthLoginEvent(data: data),
                  );
                },
              ),
              TextButton.icon(
                icon: const Icon(Icons.person_add),
                label: const Text('Registrate'),
                onPressed: () {
                  context.push(Routes().register.path);
                },
              ),
              const SizedBox(height: 15),
              const Row(
                children: [
                  Expanded(child: Divider()),
                  SizedBox(width: 10),
                  Text('O inicia sesión con'),
                  SizedBox(width: 10),
                  Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Image.network(
                      'https://companieslogo.com/img/orig/GOOG-0ed88f7c.png?t=1633218227',
                      width: 30,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/5/51/Facebook_f_logo_%282019%29.svg/1200px-Facebook_f_logo_%282019%29.svg.png',
                      width: 30,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
