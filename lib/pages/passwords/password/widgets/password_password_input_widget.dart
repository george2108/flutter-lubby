part of '../password_page.dart';

class PasswordPasswordInputWidget extends StatelessWidget {
  const PasswordPasswordInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PasswordBloc, PasswordState>(
      builder: (context, state) {
        if (state is PasswordLoadedState) {
          return TextFormField(
            controller: state.passwordController,
            maxLines: 1,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.visiblePassword,
            obscureText: state.obscurePassword,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: const Icon(Icons.remove_red_eye),
                onPressed: () {
                  context.read<PasswordBloc>().add(PasswordShowedEvent());
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              labelText: 'Contraseña',
              hintText: "Contraseña",
            ),
            validator: (_) {
              return state.passwordController.text.trim().length > 0
                  ? null
                  : 'Contraseña requerida';
            },
          );
        }

        return Container();
      },
    );
  }
}
