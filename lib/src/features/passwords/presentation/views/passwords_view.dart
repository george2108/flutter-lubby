import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/passwords_bloc.dart';
import '../../../../ui/widgets/view_labels_categories_widget.dart';
import '../../../../ui/widgets/no_data_widget.dart';
import '../widgets/passwords_item_widget.dart';

class PasswordsView extends StatelessWidget {
  const PasswordsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PasswordsBloc, PasswordsState>(
      builder: (context, state) {
        if (state.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final passwords = state.passwords;

        if (passwords.isEmpty) {
          return const Center(
            child: NoDataWidget(
              text: 'No tienes contraseñas, crea una',
              lottie: 'assets/password.json',
            ),
          );
        }

        return Column(
          children: [
            ViewLabelsCategoriesWidget(
              labels: state.labels,
              onLabelSelected: (index) {},
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                  thickness: 2,
                  height: 0,
                  indent: 10,
                  endIndent: 10,
                ),
                padding: const EdgeInsets.only(bottom: 100, top: 20.0),
                itemCount: passwords.length,
                itemBuilder: (context, index) {
                  final password = passwords[index];
                  return PasswordsItemWidget(
                    passwordModel: password,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
