import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lubby_app/src/core/constants/shape_modal_bottom.dart';
import 'package:lubby_app/src/ui/pages/passwords/widgets/show_password_widget.dart';

import '../../../../data/entities/password_entity.dart';
import '../bloc/passwords_bloc.dart';

class PasswordsItemWidget extends StatelessWidget {
  final PasswordEntity passwordModel;

  const PasswordsItemWidget({
    required this.passwordModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<PasswordsBloc>(context);

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: passwordModel.color,
          child: Text(
            passwordModel.title.trim().toUpperCase()[0],
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        trailing: passwordModel.favorite
            ? const Icon(Icons.star, color: Colors.yellow)
            : null,
        title: Text(
          passwordModel.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(passwordModel.description ?? ''),
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: kShapeModalBottom,
            builder: (_) => ShowPasswordWidget(
              password: passwordModel,
              passwordsContext: context,
            ),
          );
        },
      ),
    );
  }
}
