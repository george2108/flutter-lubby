import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/routes/routes.dart';
import '../../../../ui/widgets/alerts/alert_confirm_deletion_widget.dart';
import '../bloc/passwords_bloc.dart';
import 'passwords_card_detail_widget.dart';
import 'passwords_card_detal_password_widget.dart';
import '../../entities/password_entity.dart';

class ShowPasswordWidget extends StatelessWidget {
  final PasswordEntity password;
  final BuildContext passwordsContext;

  const ShowPasswordWidget({
    super.key,
    required this.password,
    required this.passwordsContext,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<PasswordsBloc>(context, listen: false);

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.9,
      maxChildSize: 0.9,
      minChildSize: 0.5,
      builder: (_, scrollController) => Scaffold(
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        final confirm = await showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) {
                            return const AlertConfirmDeletionWidget(
                              title: 'Eliminar contraseña',
                              message:
                                  '¿Estas seguro de eliminar esta constraseña?',
                            );
                          },
                        );

                        if (confirm == null) return;

                        bloc.add(DeletePasswordEvent(password.appId!));
                        if (context.mounted) {
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        context.push(
                          '${Routes().passwords.path}/${password.appId}',
                        );
                        /* Navigator.of(context).pop();
                        Navigator.of(context).pushNamed(
                          passwordRoute,
                          arguments: PasswordRouteSettings(
                            passwordContext: passwordsContext,
                            password: password,
                          ),
                        ); */
                      },
                    ),
                  ],
                ),
              ],
            ),
            Expanded(
              child: ListView(
                controller: scrollController,
                padding: const EdgeInsets.all(8.0),
                physics: const BouncingScrollPhysics(),
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    alignment: Alignment.center,
                    child: Text(
                      password.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (password.userName != null &&
                      password.userName!.isNotEmpty)
                    PasswordsCardDetailWidget(
                      context: context,
                      title: 'Usuario',
                      value: password.userName ?? '* Sin usuario *',
                      snackTitle: 'Usuario copiado',
                      snackMessage:
                          'El usuario ha sido copiado en el portapapeles',
                    ),
                  PasswordInfo(
                    password: password,
                  ),
                  if (password.url != null && password.url!.isNotEmpty)
                    PasswordsCardDetailWidget(
                      context: context,
                      title: 'URL Sitio web',
                      value: password.url ?? '* Sin URL *',
                      snackTitle: 'URL web copiada.',
                      snackMessage:
                          'La dirección URL del sitio web se ha copiado en el portapapeles',
                    ),
                  if (password.description != null &&
                      password.description!.isNotEmpty)
                    PasswordsCardDetailWidget(
                      context: context,
                      title: 'Descripción',
                      value: password.description ?? '* Sin descripción *',
                      snackTitle: '',
                      snackMessage: '',
                      copy: false,
                    ),
                  if (password.notas == null && password.notas!.isEmpty)
                    PasswordsCardDetailWidget(
                      context: context,
                      title: 'Notas',
                      value: password.notas ?? '* Sin notas *',
                      snackTitle: 'Notas copiadas.',
                      snackMessage:
                          'Las notas se han compiado en el portapapeles',
                      copy: false,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
