import 'package:flutter/material.dart';

import '../../../../core/constants/shape_modal_bottom.dart';
import '../../../../core/utils/get_contrasting_text_color.dart';
import 'show_password_widget.dart';
import '../../entities/password_entity.dart';

class PasswordsItemWidget extends StatelessWidget {
  final PasswordEntity passwordModel;

  const PasswordsItemWidget({
    required this.passwordModel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: passwordModel.color,
        child: Icon(
          passwordModel.icon,
          color: getContrastingTextColor(passwordModel.color),
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
            Container(
              padding: const EdgeInsets.all(3),
              margin: const EdgeInsets.only(top: 5),
              decoration: BoxDecoration(
                color: Theme.of(context).highlightColor,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    backgroundColor: passwordModel.label?.color,
                    radius: 8,
                    child: Icon(
                      passwordModel.label?.icon,
                      size: 10,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    passwordModel.label?.name ?? 'Sin etiqueta',
                    style: const TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: kShapeModalBottom,
          backgroundColor: Theme.of(context).canvasColor,
          elevation: 0,
          builder: (_) => ShowPasswordWidget(
            password: passwordModel,
            passwordsContext: context,
          ),
        );
      },
    );
  }
}
