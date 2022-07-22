part of '../password_page.dart';

class PasswordSaveButtonWidget extends StatelessWidget {
  const PasswordSaveButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PasswordBloc, PasswordState>(
      builder: (context, state) {
        if (state is PasswordLoadedState) {
          return ButtonSaveWidget(
            title: state.editing ? 'Guardar contraseña' : 'Crear contraseña',
            action: () {
              if (state.formKey.currentState!.validate()) {
                /* final respuesta = await provider.savePassword(passwordModel);
              if (respuesta) {
                Navigator.pop(context);
              } */
                final passwordProvider = BlocProvider.of<PasswordBloc>(context);
                if (state.editing) {
                  passwordProvider.add(PasswordUpdatedEvent());
                } else {
                  passwordProvider.add(PasswordCreatedEvent());
                }
              }
            },
            loading: state.loading,
          );
        }

        return Container();
      },
    );
  }
}
