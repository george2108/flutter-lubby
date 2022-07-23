part of '../password_page.dart';

class PasswordUserInputWidget extends StatelessWidget {
  const PasswordUserInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PasswordBloc, PasswordState>(
      builder: (context, state) {
        if (state is PasswordLoadedState) {
          return TextFormField(
            controller: state.userController,
            maxLines: 1,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              labelText: 'Usuario',
              hintText: "Usuario de la cuenta",
            ),
          );
        }

        return Container();
      },
    );
  }
}
