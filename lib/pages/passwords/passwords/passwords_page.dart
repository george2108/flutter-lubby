import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lubby_app/models/password_model.dart';
import 'package:lubby_app/pages/passwords/password/password_page.dart';
import 'package:lubby_app/pages/passwords/passwords/bloc/passwords_bloc.dart';
import 'package:lubby_app/pages/passwords/search_password_delegate.dart';
import 'package:lubby_app/services/password_service.dart';
import 'package:lubby_app/widgets/animate_widgets_widget.dart';
import 'package:lubby_app/widgets/copy_clipboard_widget.dart';
import 'package:lubby_app/widgets/menu_drawer.dart';
import 'package:lubby_app/widgets/no_data_widget.dart';
import 'package:lubby_app/widgets/show_snackbar_widget.dart';

part 'widgets/show_password_widget.dart';
part 'widgets/passwords_card_detail_widget.dart';
part 'widgets/passwords_card_detal_password_widget.dart';
part 'widgets/passwords_card_info_widget.dart';
part 'widgets/passwords_alert_delete_widget.dart';

class PasswordsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PasswordsBloc()..add(GetPasswordsEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Mis contraseñas'),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(
                    context: context, delegate: SearchPasswordDelegate());
              },
            ),
          ],
        ),
        drawer: Menu(),
        body: BlocConsumer<PasswordsBloc, PasswordsState>(
          listener: (context, state) {
            if (state is PasswordsDeletedState) {
              ScaffoldMessenger.of(context).showSnackBar(
                showCustomSnackBarWidget(
                  title: 'Contraseña eliminada',
                  content: 'La contraseña ha sido eliminada exitosamente.',
                ),
              );
              context.read<PasswordsBloc>().add(GetPasswordsEvent());
            }
          },
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
                padding: const EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: 8.0,
                ),
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: passwords.length,
                  itemBuilder: (context, index) {
                    return CustomAnimatedWidget(
                      index: index,
                      child: PasswordsCardInfoWidget(
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
        floatingActionButton: BlocBuilder<PasswordsBloc, PasswordsState>(
          builder: (context, state) {
            if (state is PasswordsLoadedPasswordsState) {
              return FloatingActionButton.extended(
                icon: const Icon(Icons.add),
                label: const Text('Nueva contraseña'),
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (_) => PasswordPage(
                        passwordsContext: context,
                      ),
                    ),
                  );
                },
              );
            }

            return Container();
          },
        ),
      ),
    );
  }
}
