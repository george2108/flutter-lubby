import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lubby_app/src/core/enums/status_crud_enum.dart';

import 'package:lubby_app/src/data/models/password_model.dart';
import 'package:lubby_app/src/data/datasources/password_service.dart';
import 'package:lubby_app/src/presentation/widgets/button_save_widget.dart';
import 'package:lubby_app/src/presentation/widgets/show_color_picker_widget.dart';
import 'package:lubby_app/src/presentation/widgets/show_snackbar_widget.dart';

import '../passwords/bloc/passwords_bloc.dart';
import '../passwords/passwords_page.dart';
import 'bloc/password_bloc.dart';

part 'widgets/password_title_input_widget.dart';
part 'widgets/password_password_input_widget.dart';
part 'widgets/password_user_input_widget.dart';
part 'widgets/password_description_input_widget.dart';
part 'widgets/password_url_input_widget.dart';
part 'widgets/password_notas_input_widget.dart';
part 'widgets/password_save_button_widget.dart';
part 'widgets/password_favorite_widget.dart';

class PasswordPage extends StatelessWidget {
  final PasswordModel? password;
  final BuildContext passwordsContext;

  const PasswordPage({
    Key? key,
    this.password,
    required this.passwordsContext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PasswordBloc(
        RepositoryProvider.of<PasswordService>(context),
        BlocProvider.of<PasswordsBloc>(passwordsContext),
        password,
      ),
      child: BlocListener<PasswordBloc, PasswordState>(
        listener: (context, state) {
          if (state.status == StatusCrudEnum.created) {
            ScaffoldMessenger.of(context).showSnackBar(
              showCustomSnackBarWidget(
                title: 'Contraseña creada.',
                content: '!La contraseña ha sido creada exitosamente¡.',
              ),
            );
            Navigator.pushAndRemoveUntil(
              context,
              CupertinoPageRoute(builder: (_) => const PasswordsPage()),
              (route) => false,
            );
          }
          if (state.status == StatusCrudEnum.updated) {
            ScaffoldMessenger.of(context).showSnackBar(
              showCustomSnackBarWidget(
                title: 'Contraseña actualizada.',
                content: '!La contraseña ha sido actualizada exitosamente¡.',
              ),
            );
          }
        },
        child: const _BuildPage(),
      ),
    );
  }
}

class _BuildPage extends StatelessWidget {
  const _BuildPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<PasswordBloc>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contraseña'),
        actions: [
          const PasswordFavoriteWidget(),
          PopupMenuButton(
            itemBuilder: (_) => [
              PopupMenuItem(
                value: 'color',
                child: Row(
                  children: const [
                    Icon(Icons.color_lens_outlined),
                    SizedBox(width: 5),
                    Text(
                      'Color de contraseña',
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'ayuda',
                child: Row(
                  children: const [
                    Icon(Icons.help_outline),
                    SizedBox(width: 5),
                    Text('Ayuda', textAlign: TextAlign.start),
                  ],
                ),
              ),
              if (bloc.state.editing)
                PopupMenuItem(
                  value: 'eliminar',
                  child: Row(
                    children: const [
                      Icon(Icons.delete_outline),
                      SizedBox(width: 5),
                      Text('Eliminar contraseña'),
                    ],
                  ),
                ),
            ],
            onSelected: (value) async {
              switch (value) {
                case 'color':
                  final pickColor = ShowColorPickerWidget(
                    context: context,
                    color: bloc.state.color,
                  );
                  await pickColor.showDialogPickColor();
                  if (!pickColor.cancelado) {
                    bloc.add(PasswordChangeColorEvent(pickColor.colorPicked));
                  }
                  break;
                default:
                  break;
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
                child: Form(
                  key: context.watch<PasswordBloc>().state.formKey,
                  child: Column(
                    children: const [
                      PasswordTitleInputWidget(),
                      SizedBox(height: 17.0),
                      PasswordUserInputWidget(),
                      SizedBox(height: 17.0),
                      PasswordPasswordInputWidget(),
                      SizedBox(height: 17.0),
                      PasswordURLInputWidget(),
                      SizedBox(height: 17.0),
                      PasswordDescriptionInputWidget(),
                      SizedBox(height: 17.0),
                      PasswordNotasInputWidget(),
                      SizedBox(height: 25.0),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const PasswordSaveButtonWidget(),
        ],
      ),
    );
  }
}
