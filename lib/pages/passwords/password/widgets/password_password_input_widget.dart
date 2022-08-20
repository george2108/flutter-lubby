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
        contentPadding: const EdgeInsets.all(8.0),
        suffixIcon: IconButton(
          icon: const Icon(Icons.remove_red_eye),
          onPressed: () {
            context.read<PasswordBloc>().add(PasswordShowedEvent());
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        labelText: 'Contraseña',
        hintText: "Contraseña",
      ),
      validator: (_) {
        return bloc.state.passwordController.text.trim().length > 0
            ? null
            : 'Contraseña requerida';
      },
    );
  }
}
