import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lubby_app/models/password_model.dart';
import 'package:lubby_app/pages/passwords/password/password_page.dart';
import 'package:lubby_app/pages/passwords/passwords/bloc/passwords_bloc.dart';
import 'package:lubby_app/services/password_service.dart';
import 'package:lubby_app/widgets/copy_clipboard_widget.dart';
import 'package:lubby_app/widgets/menu_drawer.dart';
import 'package:lubby_app/widgets/no_data_widget.dart';
import 'package:lubby_app/widgets/show_snackbar_widget.dart';
import 'package:lubby_app/widgets/sliver_no_data_screen_widget.dart';

part 'widgets/show_password_widget.dart';
part 'widgets/passwords_card_detail_widget.dart';
part 'widgets/passwords_card_detal_password_widget.dart';
part 'widgets/passwords_card_info_widget.dart';
part 'widgets/passwords_alert_delete_widget.dart';
part 'widgets/passwords_data_screen_widget.dart';

class PasswordsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PasswordsBloc()..add(GetPasswordsEvent()),
      child: Scaffold(
        drawer: Menu(),
        body: BlocConsumer<PasswordsBloc, PasswordsState>(
          listenWhen: (previous, current) {
            return previous.lastPassDeleted?.id !=
                    current.lastPassDeleted?.id &&
                current.lastPassDeleted != null;
          },
          listener: (context, state) {
            ScaffoldMessenger.of(context).showSnackBar(
              showCustomSnackBarWidget(
                title: 'Contraseña eliminada',
                content: 'La contraseña ha sido eliminada exitosamente.',
              ),
            );
          },
          builder: (context, state) {
            print('cargando');

            if (state.loading) {
              return const SliverNoDataScreenWidget(
                appBarTitle: 'Mis contraseñas',
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            final passwords = state.passwords;
            if (passwords.length == 0) {
              return const SliverNoDataScreenWidget(
                appBarTitle: 'Mis contraseñas',
                child: NoDataWidget(
                  text: 'No tienes contraseñas, crea una',
                  lottie: 'assets/password.json',
                ),
              );
            }

            return NotificationListener<UserScrollNotification>(
              onNotification: ((notification) {
                if (notification.direction == ScrollDirection.forward) {
                  context
                      .read<PasswordsBloc>()
                      .add(PasswordsHideShowFabEvent(true));
                } else if (notification.direction == ScrollDirection.reverse) {
                  context
                      .read<PasswordsBloc>()
                      .add(PasswordsHideShowFabEvent(false));
                }
                return true;
              }),
              child: PasswordsDataScreenWidget(
                passwords: passwords,
              ),
            );
          },
        ),
        floatingActionButton: BlocBuilder<PasswordsBloc, PasswordsState>(
          builder: (context, state) {
            return AnimatedSlide(
              duration: const Duration(milliseconds: 300),
              curve: Curves.decelerate,
              offset: state.showFab ? Offset.zero : const Offset(0, 2),
              child: FloatingActionButton.extended(
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
              ),
            );
          },
        ),
      ),
    );
  }
}
