import 'package:flutter/material.dart';

import 'package:lubby_app/src/core/constants/shape_modal_bottom.dart';
import 'package:lubby_app/src/ui/pages/passwords/widgets/show_password_widget.dart';
import '../../../../data/entities/password_entity.dart';

class PasswordsItemWidget extends StatelessWidget {
  final PasswordEntity passwordModel;

  const PasswordsItemWidget({
    required this.passwordModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: passwordModel.color,
        child: Icon(
          passwordModel.icon,
          color: Colors.white,
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
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (passwordModel.description != null &&
              passwordModel.description!.isNotEmpty)
            Text(passwordModel.description ?? ''),
          if (passwordModel.label != null)
            Chip(
              label: Text(
                passwordModel.label?.name ?? 'Sin etiqueta',
              ),
              avatar: CircleAvatar(
                backgroundColor: passwordModel.label?.color,
                child: Icon(
                  passwordModel.label?.icon,
                  size: 16,
                ),
              ),
            ),
        ],
      ),
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
    );
  }
}
