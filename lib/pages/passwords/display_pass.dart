import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:clipboard/clipboard.dart';

import 'package:lubby_app/db/database_provider.dart';
import 'package:lubby_app/pages/passwords/password_controller.dart';
import 'package:lubby_app/services/password_service.dart';
import 'package:lubby_app/widgets/show_snackbar_widget.dart';

class ShowPassword extends StatelessWidget {
  final _passwordController = Get.find<PasswordController>();
  final _passProvider = Get.find<PasswordService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contraseña'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertaEliminacion(
                      id: _passwordController.passwordModelData.id);
                },
                barrierDismissible: false,
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Get.toNamed('/editPassword');
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
              padding: EdgeInsets.all(15),
              alignment: Alignment.center,
              child: Text(
                _passwordController.passwordModelData.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            _cardInfo(
              context,
              title: 'Usuario',
              value: _passwordController.passwordModelData.user ??
                  '* Sin usuario *',
              snackTitle: 'Usuario copiado',
              snackMessage: 'El usuario ha sido copiado en el portapapeles',
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(bottom: 15, left: 10, right: 10),
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
                        child: Text('Mostrar'),
                        onPressed: () {
                          _passwordController.showPassword.toggle();
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _ShowPasswordText(
                        password: _passProvider.decrypt(
                            _passwordController.passwordModelData.password),
                      ),
                      IconButton(
                        icon: Icon(Icons.copy),
                        onPressed: () {
                          _copyElement(
                            _passProvider.decrypt(
                                _passwordController.passwordModelData.password),
                            'Contraseña copiada',
                            'La contraseña ha sido copiada en el portapapeles',
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
              value: _passwordController.passwordModelData.description ??
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
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 15, left: 10, right: 10),
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
          if (!copy) SizedBox(height: 10),
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
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              if (copy)
                IconButton(
                  icon: Icon(Icons.copy),
                  onPressed: () {
                    _copyElement(value.toString(), snackTitle, snackMessage);
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }

  void _copyElement(String element, String title, String message) {
    print(element);
    FlutterClipboard.copy(element).then(
      (value) => showSnackBarWidget(
        title: title,
        message: message,
      ),
    );
  }
}

class _ShowPasswordText extends StatelessWidget {
  final String password;
  final _passwordController = Get.find<PasswordController>();

  _ShowPasswordText({required this.password});

  @override
  Widget build(BuildContext context) {
    _passwordController.showPassword.value = false;

    return Obx(
      () => Text(
        _passwordController.showPassword.value
            ? password
            : password.replaceAll(RegExp('.'), '*'),
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
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
      title: Text('Alerta'),
      content: Text('¿Estás seguro de eliminar esta contraseña?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            DatabaseProvider.db.deletePassword(id);
            Get.offNamedUntil('/passwords', (route) => false);
          },
          child: Text('Aceptar'),
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