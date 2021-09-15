import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:lubby_app/pages/passwords/password_controller.dart';
import 'package:lubby_app/widgets/menu_drawer.dart';
import 'package:lubby_app/widgets/no_data_widget.dart';

class PasswordsPage extends StatelessWidget {
  final passwordController = Get.find<PasswordController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis contraseñas'),
      ),
      drawer: Menu(),
      body: FutureBuilder(
        future: passwordController.getPasswords(),
        builder: (context, AsyncSnapshot snapshotData) {
          if (snapshotData.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (passwordController.passwords.length < 1) {
            return NoDataWidget(
              text: 'No tienes contraseñas, crea una',
              lottie: 'assets/password.json',
            );
          } else {
            return Padding(
              padding: EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: passwordController.passwords.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.password,
                        color: Colors.yellow,
                      ),
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
