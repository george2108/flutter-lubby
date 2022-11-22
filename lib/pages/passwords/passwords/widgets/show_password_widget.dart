part of '../passwords_page.dart';

class ShowPasswordWidget extends StatelessWidget {
  final PasswordModel password;
  final BuildContext blocContext;

  const ShowPasswordWidget({
    Key? key,
    required this.password,
    required this.blocContext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.8,
      maxChildSize: 0.9,
      minChildSize: 0.4,
      builder: (_, scrollController) => Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          height: double.infinity,
          child: Column(
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
                        onPressed: () {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) {
                              return PasswordsAlertDeleteWidget(
                                id: password.id!,
                                blocContext: blocContext,
                              );
                            },
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (_) => PasswordPage(
                                password: password,
                                passwordsContext: blocContext,
                              ),
                            ),
                          );
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
                    PasswordsCardDetailWidget(
                      context: context,
                      title: 'Usuario',
                      value: password.user ?? '* Sin usuario *',
                      snackTitle: 'Usuario copiado',
                      snackMessage:
                          'El usuario ha sido copiado en el portapapeles',
                    ),
                    PasswordInfo(password: password),
                    PasswordsCardDetailWidget(
                      context: context,
                      title: 'URL Sitio web',
                      value: password.url ?? '* Sin URL *',
                      snackTitle: 'URL web copiada.',
                      snackMessage:
                          'La dirección URL del sitio web se ha copiado en el portapapeles',
                    ),
                    PasswordsCardDetailWidget(
                      context: context,
                      title: 'Descripción',
                      value: password.description ?? '* Sin descripción *',
                      snackTitle: '',
                      snackMessage: '',
                      copy: false,
                    ),
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
      ),
    );
  }
}
