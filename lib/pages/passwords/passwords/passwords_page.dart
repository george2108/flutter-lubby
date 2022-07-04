import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lubby_app/db/database_provider.dart';
import 'package:lubby_app/models/password_model.dart';
import 'package:lubby_app/pages/passwords/password/password_page.dart';
import 'package:lubby_app/pages/passwords/passwords/bloc/passwords_bloc.dart';
import 'package:lubby_app/pages/passwords/search_password_delegate.dart';
import 'package:lubby_app/services/password_service.dart';
import 'package:lubby_app/widgets/animate_widgets_widget.dart';
import 'package:lubby_app/widgets/menu_drawer.dart';
import 'package:lubby_app/widgets/no_data_widget.dart';
import 'package:lubby_app/widgets/show_snackbar_widget.dart';

part 'widgets/show_password_widget.dart';

class PasswordsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      body: BlocProvider(
        create: (context) => PasswordsBloc()..add(GetPasswordsEvent()),
        child: BlocBuilder<PasswordsBloc, PasswordsState>(
          builder: (context, state) {
            if (state is PasswordsLoadedPasswordsState) {
              final passwords = state.passwords;

              if (passwords.length == 0) {
                return const NoDataWidget(
                  text: 'No tienes contraseñas, crea una',
                  lottie: 'assets/password.json',
                );
              }

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: passwords.length,
                  itemBuilder: (context, index) {
                    return CustomAnimatedWidget(
                      index: index,
                      child: _PasswordCard(
                        passwordModel: passwords[index],
                      ),
                    );
                  },
                ),
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text('Nueva contraseña'),
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (_) => const PasswordPage(),
            ),
          );
        },
      ),
    );
  }
}

class _PasswordCard extends StatelessWidget {
  final PasswordModel passwordModel;

  const _PasswordCard({
    required this.passwordModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext mycontext) {
    return Card(
      child: ListTile(
        leading: const Icon(
          Icons.password,
          color: Colors.yellow,
        ),
        title: Text(
          passwordModel.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(passwordModel.user ?? ''),
        onTap: () {
          showModalBottomSheet(
            context: mycontext,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => ShowPasswordWidget(
              password: passwordModel,
              myContext: mycontext,
            ),
          );
        },
      ),
    );
  }
}
