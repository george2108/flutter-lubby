part of '../password_page.dart';

class PasswordSaveButtonWidget extends StatelessWidget {
  const PasswordSaveButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<PasswordBloc>(context, listen: false);

    return ButtonSaveWidget(
      title: context.watch<PasswordBloc>().state.editing
          ? 'Guardar contraseña'
          : 'Crear contraseña',
      action: () {
        if (bloc.state.formKey.currentState!.validate()) {
          final passwordProvider = BlocProvider.of<PasswordBloc>(
            context,
            listen: false,
          );
          if (passwordProvider.state.editing) {
            passwordProvider.add(PasswordUpdatedEvent());
          } else {
            passwordProvider.add(PasswordCreatedEvent());
          }
        }
      },
      loading: context.watch<PasswordBloc>().state.loading,
    );
  }
}
