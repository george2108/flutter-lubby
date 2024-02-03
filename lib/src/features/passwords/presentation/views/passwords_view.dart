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
    final bloc = BlocProvider.of<PasswordsBloc>(context, listen: false);

    return Column(
      children: [
        BlocBuilder<PasswordsBloc, PasswordsState>(
          buildWhen: (previous, current) {
            return previous.labels.length != current.labels.length;
          },
          builder: (context, state) {
            return ViewLabelsCategoriesWidget(
              initialLabel: state.filters.label,
              labels: state.labels,
              onLabelSelected: (label) {
                bloc.add(GetPasswordsEvent(label: label));
              },
            );
          },
        ),
        Expanded(
          child: BlocBuilder<PasswordsBloc, PasswordsState>(
            buildWhen: (previous, current) {
              return previous != current;
            },
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
              return ListView.separated(
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
              );
            },
          ),
        ),
      ],
    );
  }
}
