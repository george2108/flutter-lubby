part of '../password_page.dart';

class PasswordPasswordInputWidget extends StatelessWidget {
  const PasswordPasswordInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<PasswordBloc>(context, listen: false);
    return TextFormField(
      controller: context.watch<PasswordBloc>().state.passwordController,
      maxLines: 1,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.visiblePassword,
      obscureText: context.watch<PasswordBloc>().state.obscurePassword,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: const Icon(Icons.remove_red_eye),
          onPressed: () {
            context.read<PasswordBloc>().add(PasswordShowedEvent());
          },
        ),
        labelText: 'Contraseña',
        hintText: "Contraseña",
      ),
      validator: (_) {
        return bloc.state.passwordController.text.trim().isNotEmpty
            ? null
            : 'Contraseña requerida';
      },
    );
  }
}
