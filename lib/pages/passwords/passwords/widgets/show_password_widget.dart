part of '../passwords_page.dart';

class ShowPasswordWidget extends StatelessWidget {
  final PasswordModel password;
  final BuildContext myContext;

  const ShowPasswordWidget({
    Key? key,
    required this.password,
    required this.myContext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.8,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      builder: (context, scrollController) => Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                            builder: (context) {
                              return AlertaEliminacion(
                                id: this.password.id,
                              );
                            },
                            barrierDismissible: false,
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
                              builder: (context) => PasswordPage(
                                password: password,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                alignment: Alignment.center,
                child: Text(
                  this.password.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              _cardInfo(
                context,
                title: 'Usuario',
                value: this.password.user ?? '* Sin usuario *',
                snackTitle: 'Usuario copiado',
                snackMessage: 'El usuario ha sido copiado en el portapapeles',
              ),
              _PasswordInfo(password: password),
              _cardInfo(
                context,
                title: 'Descripción',
                value: this.password.description ?? '* Sin descripción *',
                snackTitle: '',
                snackMessage: '',
                copy: false,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cardInfo(
    BuildContext context, {
    required String title,
    required String value,
    required String snackTitle,
    required String snackMessage,
    bool copy = true,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).backgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Theme.of(context).textTheme.headline6!.fontSize,
            ),
          ),
          if (!copy) const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  child: Text(
                    value,
                    maxLines: 10,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              if (copy)
                IconButton(
                  icon: const Icon(Icons.copy),
                  onPressed: () {
                    _copyElement(
                      value.toString(),
                      snackTitle,
                      snackMessage,
                      context,
                    );
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PasswordInfo extends StatefulWidget {
  final PasswordModel password;
  const _PasswordInfo({Key? key, required this.password}) : super(key: key);
  @override
  State<_PasswordInfo> createState() => __PasswordInfoState();
}

class __PasswordInfoState extends State<_PasswordInfo> {
  final PasswordService passwordService = PasswordService();
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).backgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Contraseña',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Theme.of(context).textTheme.headline6!.fontSize,
                ),
              ),
              TextButton(
                child: const Text('Mostrar'),
                onPressed: () {
                  showPassword = !showPassword;
                  print(showPassword);
                  setState(() {});
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                showPassword
                    ? passwordService.decrypt(widget.password.password)
                    : passwordService
                        .decrypt(widget.password.password)
                        .replaceAll(RegExp('.'), '*'),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.copy),
                onPressed: () {
                  _copyElement(
                    passwordService.decrypt(widget.password.password),
                    'Contraseña copiada',
                    'La contraseña ha sido copiada en el portapapeles',
                    context,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AlertaEliminacion extends StatelessWidget {
  final id;

  const AlertaEliminacion({
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Alerta'),
      content: const Text('¿Estás seguro de eliminar esta contraseña?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            DatabaseProvider.db.deletePassword(id);
            // Get.offNamedUntil('/passwords', (route) => false);
          },
          child: const Text('Aceptar'),
        ),
      ],
    );
  }
}

void _copyElement(
    String element, String title, String message, BuildContext context) {
  print(element);
  FlutterClipboard.copy(element).then(
    (value) => showCustomSnackBarWidget(
      title: title,
      content: message,
    ),
  );
}
