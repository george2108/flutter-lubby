part of '../passwords_page.dart';

class PasswordsCardInfoWidget extends StatelessWidget {
  final PasswordModel passwordModel;

  const PasswordsCardInfoWidget({
    required this.passwordModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        trailing: passwordModel.favorite == 1
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
            backgroundColor: Colors.transparent,
            builder: (_) => ShowPasswordWidget(
              password: passwordModel,
              blocContext: context,
            ),
          );
        },
      ),
    );
  }
}
