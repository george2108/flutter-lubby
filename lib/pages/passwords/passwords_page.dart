import 'package:flutter/material.dart';

import 'package:lubby_app/pages/passwords/search_password_delegate.dart';

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
        title: const Text('Mis contraseñas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: SearchPasswordDelegate());
            },
          ),
        ],
      ),
      drawer: Menu(),
      body: FutureBuilder(
        future: _passwordProvider.getPasswords(),
        builder: (context, AsyncSnapshot snapshotData) {
          if (snapshotData.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (_passwordProvider.passwords.length < 1) {
            return const NoDataWidget(
              text: 'No tienes contraseñas, crea una',
              lottie: 'assets/password.json',
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: _passwordProvider.passwords.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: const Icon(
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
                        Navigator.pushNamed(context, '/showPassword');
                      },
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text('Nueva contraseña'),
        onPressed: () {
          Navigator.pushNamed(context, '/newPassword');
        },
      ),
    );
  }
}
