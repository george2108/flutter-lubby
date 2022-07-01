import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:clipboard/clipboard.dart';

import 'package:lubby_app/db/database_provider.dart';
import 'package:lubby_app/providers/passwords_provider.dart';
import 'package:lubby_app/services/password_service.dart';
import 'package:lubby_app/widgets/show_snackbar_widget.dart';
import 'package:provider/provider.dart';

class ShowPassword extends StatelessWidget {
  final _passService = PasswordService();

  @override
  Widget build(BuildContext context) {
    final _passwordProvider = Provider.of<PasswordsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contraseña'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertaEliminacion(
                    id: _passwordProvider.passwordModelData.id,
                  );
                },
                barrierDismissible: false,
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.pushNamed(context, '/editPassword');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              alignment: Alignment.center,
              child: Text(
                _passwordProvider.passwordModelData.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            _cardInfo(
              context,
              title: 'Usuario',
              value:
                  _passwordProvider.passwordModelData.user ?? '* Sin usuario *',
              snackTitle: 'Usuario copiado',
              snackMessage: 'El usuario ha sido copiado en el portapapeles',
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).backgroundColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Contraseña',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize:
                              Theme.of(context).textTheme.headline6!.fontSize,
                        ),
                      ),
                      TextButton(
                        child: const Text('Mostrar'),
                        onPressed: () {
                          _passwordProvider.showPassword =
                              !_passwordProvider.showPassword;
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _ShowPasswordText(
                        password: _passService.decrypt(
                            _passwordProvider.passwordModelData.password),
                        passwordsProvider: _passwordProvider,
                      ),
                      IconButton(
                        icon: const Icon(Icons.copy),
                        onPressed: () {
                          _copyElement(
                            _passService.decrypt(
                                _passwordProvider.passwordModelData.password),
                            'Contraseña copiada',
                            'La contraseña ha sido copiada en el portapapeles',
                            context,
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            _cardInfo(
              context,
              title: 'Descripción',
              value: _passwordProvider.passwordModelData.description ??
                  '* Sin descripción *',
              snackTitle: '',
              snackMessage: '',
              copy: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardInfo(
    BuildContext context, {
    required String title,
    required String value,
    required String snackTitle,
    required String snackMessage,
    bool copy = true,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).backgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Theme.of(context).textTheme.headline6!.fontSize,
            ),
          ),
          if (!copy) const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  child: Text(
                    value,
                    maxLines: 10,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              if (copy)
                IconButton(
                  icon: const Icon(Icons.copy),
                  onPressed: () {
                    _copyElement(
                      value.toString(),
                      snackTitle,
                      snackMessage,
                      context,
                    );
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }

  void _copyElement(
      String element, String title, String message, BuildContext context) {
    print(element);
    FlutterClipboard.copy(element).then(
      (value) => showCustomSnackBarWidget(
        title: title,
        content: message,
      ),
    );
  }
}

class _ShowPasswordText extends StatelessWidget {
  final String password;
  final PasswordsProvider passwordsProvider;

  _ShowPasswordText({
    required this.password,
    required this.passwordsProvider,
  });

  @override
  Widget build(BuildContext context) {
    passwordsProvider.showPassword = false;

    return Text(
      passwordsProvider.showPassword
          ? password
          : password.replaceAll(RegExp('.'), '*'),
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class AlertaEliminacion extends StatelessWidget {
  final id;

  const AlertaEliminacion({
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Alerta'),
      content: const Text('¿Estás seguro de eliminar esta contraseña?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            DatabaseProvider.db.deletePassword(id);
            Get.offNamedUntil('/passwords', (route) => false);
          },
          child: const Text('Aceptar'),
        ),
      ],
    );
  }
}


/*  Container(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => Text(
                      passProvider.decrypt(
                          passwordController.passwordModelData.value.password),
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.copy),
                    onPressed: () {
                      FlutterClipboard.copy(passProvider.decrypt(
                              passwordController.passwordModel.value.password))
                          .then(
                        (value) => ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Contraseña copiada'),
                            duration: Duration(seconds: 1),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ), */