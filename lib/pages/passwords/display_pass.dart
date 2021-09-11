import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:lubby_app/db/database_provider.dart';
import 'package:lubby_app/models/password_model.dart';
import 'package:lubby_app/providers/password_provider.dart';

class ShowPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PasswordModel pass =
        ModalRoute.of(context)!.settings.arguments as PasswordModel;

    final passProvider = PasswordProvider();

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
                  return AlertaEliminacion(id: pass.id);
                },
                barrierDismissible: false,
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.pushNamed(context, "editPassword");
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              child: Text(
                pass.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  pass.user ?? '',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.copy),
                  onPressed: () {
                    FlutterClipboard.copy(pass.user ?? '').then(
                      (value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Usuario copiado'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  passProvider.decrypt(pass.password),
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.copy),
                  onPressed: () {
                    FlutterClipboard.copy(passProvider.decrypt(pass.password))
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
            SizedBox(height: 16.0),
            Text(
              pass.description ?? '',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
          ],
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
      title: Text('HOla'),
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
            Navigator.pushNamedAndRemoveUntil(
              context,
              "passwords",
              (route) => false,
            );
          },
          child: Text('Aceptar'),
        ),
      ],
    );
  }
}
