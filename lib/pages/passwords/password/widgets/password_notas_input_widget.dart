part of '../password_page.dart';

class PasswordNotasInputWidget extends StatelessWidget {
  const PasswordNotasInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: context.read<PasswordBloc>().state.notasController,
      minLines: 1,
      maxLines: 10,
      maxLength: 1000,
      textInputAction: TextInputAction.newline,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        hintText: "Agregue notas a su contraseña",
        labelText: 'Notas',
      ),
    );
  }
}
