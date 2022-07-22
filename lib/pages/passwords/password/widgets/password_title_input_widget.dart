part of '../password_page.dart';

class PasswordTitleInputWidget extends StatelessWidget {
  const PasswordTitleInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PasswordBloc, PasswordState>(
      builder: (context, state) {
        if (state is PasswordLoadedState) {
          return TextFormField(
            controller: state.titleController,
            maxLines: 1,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              hintText: 'Titulo de la contraseña',
              labelText: 'Titulo',
              suffixIcon: state.titleController.text.trim().length > 0
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        state.titleController.clear();
                      },
                    )
                  : null,
            ),
            validator: (_) {
              return state.titleController.text.trim().length > 0
                  ? null
                  : 'Titulo requerido';
            },
          );
        }
        return Container();
      },
    );
  }
}
