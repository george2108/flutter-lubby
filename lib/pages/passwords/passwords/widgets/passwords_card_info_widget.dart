part of '../passwords_page.dart';

class PasswordsCardInfoWidget extends StatelessWidget {
  final PasswordModel passwordModel;

  const PasswordsCardInfoWidget({
    required this.passwordModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext mycontext) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Text(passwordModel.title.toUpperCase().substring(0, 1)),
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
            context: mycontext,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (_) => ShowPasswordWidget(
              password: passwordModel,
              blocContext: mycontext,
            ),
          );
        },
      ),
    );
  }
}
