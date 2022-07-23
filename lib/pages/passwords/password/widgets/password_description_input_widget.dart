part of '../password_page.dart';

class PasswordDescriptionInputWidget extends StatelessWidget {
  const PasswordDescriptionInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PasswordBloc, PasswordState>(
      builder: (context, state) {
        if (state is PasswordLoadedState) {
          return TextFormField(
            controller: state.descriptionController,
            maxLines: 1,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              hintText: "Descipción de la contraseña",
              labelText: 'Descripción',
            ),
          );
        }

        return Container();
      },
    );
  }
}
