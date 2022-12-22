part of '../password_page.dart';

class PasswordTitleInputWidget extends StatelessWidget {
  const PasswordTitleInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<PasswordBloc>(context, listen: false);
    return TextFormField(
      controller: context.watch<PasswordBloc>().state.titleController,
      maxLines: 1,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: const InputDecoration(
        hintText: 'Titulo de la contraseña',
        labelText: 'Titulo',
      ),
      validator: (_) {
        return bloc.state.titleController.text.trim().isNotEmpty
            ? null
            : 'Titulo requerido';
      },
    );
  }
}
