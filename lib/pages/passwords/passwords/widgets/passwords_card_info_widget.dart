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
        leading: const Icon(
          Icons.password,
          color: Colors.yellow,
        ),
        title: Text(
          passwordModel.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(passwordModel.user ?? ''),
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
