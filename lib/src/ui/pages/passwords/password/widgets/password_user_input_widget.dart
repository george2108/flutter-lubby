part of '../password_page.dart';

class PasswordUserInputWidget extends StatelessWidget {
  const PasswordUserInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: context.watch<PasswordBloc>().state.userController,
      maxLines: 1,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        labelText: 'Usuario',
        hintText: "Usuario de la cuenta",
      ),
    );
  }
}
