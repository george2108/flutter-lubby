import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lubby_app/models/password_model.dart';
import 'package:lubby_app/pages/passwords/password/password_page.dart';
import 'package:provider/provider.dart';

import '../../db/database_provider.dart';
import '../../providers/passwords_provider.dart';

class SearchPasswordDelegate extends SearchDelegate {
  @override
  String? get searchFieldLabel => 'Buscar contraseña';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, []);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final _passwordProvider = Provider.of<PasswordsProvider>(context);

    if (query.trim().length == 0) {
      return const Center(
        child: Text('Aquí aparecera el resultado de tu búsqueda...'),
      );
    }
    return FutureBuilder(
      future: DatabaseProvider.db.searchPassword(query),
      builder:
          (BuildContext context, AsyncSnapshot<List<PasswordModel>> snapshot) {
        print(snapshot.data);
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final data = snapshot.data;
        final primerRegistro = PasswordModel(
          title: '',
          password: 'password',
          favorite: 0,
        );
        primerRegistro.title = data!.length > 0
            ? 'Se encontraron ${data.length} resultado(s)'
            : 'Sin resultados';
        data.insert(0, primerRegistro);
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(data[index].title),
              );
            }
            return ListTile(
              title: Text(data[index].title),
              trailing: const Icon(Icons.arrow_right_sharp),
              leading: const Icon(Icons.key),
              onTap: () {
                /* _passwordProvider.passwordModelData = data[index];
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (_) => const PasswordPage(),
                  ),
                ); */
              },
            );
          },
        );
      },
    );
  }
}
