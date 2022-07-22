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
              suffixIcon: state.userController.text.trim().length > 0
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        state.userController.clear();
                      },
                    )
                  : null,
            ),
          );
        }

        return Container();
      },
    );
  }
}
