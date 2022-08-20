part of '../password_page.dart';

class PasswordDescriptionInputWidget extends StatelessWidget {
  const PasswordDescriptionInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: context.read<PasswordBloc>().state.descriptionController,
      maxLines: 1,
      maxLength: 1000,
      decoration: InputDecoration(
        counterText: '',
        contentPadding: const EdgeInsets.all(8.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        hintText: "Descipción de la contraseña",
        labelText: 'Descripción',
      ),
    );
  }
}
