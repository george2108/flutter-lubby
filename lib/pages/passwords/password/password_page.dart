import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';

import 'package:lubby_app/models/password_model.dart';
import 'package:lubby_app/pages/passwords/password/bloc/password_bloc.dart';
import 'package:lubby_app/pages/passwords/passwords/passwords_page.dart';
import 'package:lubby_app/services/password_service.dart';

part 'widgets/create_password_widget.dart';

class PasswordPage extends StatelessWidget {
  final PasswordModel? password;

  const PasswordPage({Key? key, this.password}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contraseña'),
        elevation: 0,
        backgroundColor: Theme.of(context).canvasColor,
      ),
      body: BlocProvider(
        create: (context) => PasswordBloc(
          RepositoryProvider.of<PasswordService>(context),
        )..add(
            LoadInitialPasswordEvent(password),
          ),
        child: CreateOrUpdatePasswordWidget(password: password),
      ),
    );
  }
}
