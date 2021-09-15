import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:lubby_app/pages/passwords/password_controller.dart';
import 'package:lubby_app/widgets/menu_drawer.dart';
import 'package:lubby_app/widgets/no_data_widget.dart';

class PasswordsPage extends StatelessWidget {
  final _passwordController = Get.find<PasswordController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis contraseñas'),
      ),
      drawer: Menu(),
      body: FutureBuilder(
        future: _passwordController.getPasswords(),
        builder: (context, AsyncSnapshot snapshotData) {
          if (snapshotData.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (_passwordController.passwords.length < 1) {
            return NoDataWidget(
              text: 'No tienes contraseñas, crea una',
              lottie: 'assets/password.json',
            );
          } else {
            return Padding(
              padding: EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: _passwordController.passwords.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.password,
                        color: Colors.yellow,
                      ),
                      title: Text(
                        _passwordController.passwords[index].title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                          _passwordController.passwords[index].description ??
                              ''),
                      onTap: () {
                        _passwordController.passwordModelData.value =
                            _passwordController.passwords[index];
                        Get.toNamed('/showPassword');
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
