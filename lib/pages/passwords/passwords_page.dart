import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:lubby_app/providers/passwords_provider.dart';
import 'package:lubby_app/widgets/menu_drawer.dart';
import 'package:lubby_app/widgets/no_data_widget.dart';
import 'package:provider/provider.dart';

class PasswordsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _passwordProvider = Provider.of<PasswordsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Mis contraseñas'),
      ),
      drawer: Menu(),
      body: FutureBuilder(
        future: _passwordProvider.getPasswords(),
        builder: (context, AsyncSnapshot snapshotData) {
          if (snapshotData.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (_passwordProvider.passwords.length < 1) {
            return NoDataWidget(
              text: 'No tienes contraseñas, crea una',
              lottie: 'assets/password.json',
            );
          } else {
            return Padding(
              padding: EdgeInsets.all(8.0),
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: _passwordProvider.passwords.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.password,
                        color: Colors.yellow,
                      ),
                      title: Text(
                        _passwordProvider.passwords[index].title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle:
                          Text(_passwordProvider.passwords[index].user ?? ''),
                      onTap: () {
                        _passwordProvider.passwordModelData =
                            _passwordProvider.passwords[index];
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
