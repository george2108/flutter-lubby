import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:lubby_app/db/database_provider.dart';
import 'package:lubby_app/models/password_model.dart';
import 'package:lubby_app/pages/passwords/password_controller.dart';
import 'package:lubby_app/widgets/menu_drawer.dart';

class PasswordsPage extends StatelessWidget {
  final passwordController = PasswordController();

  Future<void> getPasswords() async {
    final List<PasswordModel> passwords =
        await DatabaseProvider.db.getAllPasswords();
    passwordController.setPasswords(passwords);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis contraseñas'),
      ),
      drawer: Menu(),
      body: FutureBuilder(
        future: getPasswords(),
        builder: (context, AsyncSnapshot snapshotData) {
          if (snapshotData.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (passwordController.passwords.length < 1) {
            return Center(
              child: Text('No tienes contraseñas aun, crea una'),
            );
          } else {
            return Padding(
              padding: EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: passwordController.passwords.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(passwordController.passwords[index].title),
                      subtitle: Text(
                          passwordController.passwords[index].description ??
                              ''),
                      onTap: () {
                        Get.toNamed(
                          '/showPassword',
                          arguments: passwordController.passwords[index],
                        );
                      },
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Get.toNamed('/newPassword');
        },
      ),
    );
  }
}
