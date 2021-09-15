import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:clipboard/clipboard.dart';

import 'package:lubby_app/db/database_provider.dart';
import 'package:lubby_app/models/password_model.dart';
import 'package:lubby_app/pages/passwords/password_controller.dart';
import 'package:lubby_app/providers/password_provider.dart';

class ShowPassword extends StatelessWidget {
  final passwordController = Get.find<PasswordController>();
  final passProvider = Get.find<PasswordProvider>();

  @override
  Widget build(BuildContext context) {
    passwordController.passwordModelData.value =
        ModalRoute.of(context)!.settings.arguments as PasswordModel;

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
                      id: passwordController.passwordModelData.value.id);
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
      body: Column(
        children: [
          Obx(() =>
              Text(passwordController.passwordModelData.value.id!.toString())),
          Obx(() => Text(passwordController.passwordModelData.value.title)),
          Text(passProvider
              .decrypt(passwordController.passwordModelData.value.password)),
          Text(passwordController.passwordModelData.value.user ?? ''),
          Text(passwordController.passwordModelData.value.description ?? ''),
        ],
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