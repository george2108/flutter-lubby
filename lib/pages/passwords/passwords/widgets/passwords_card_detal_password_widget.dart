part of '../passwords_page.dart';

class PasswordInfo extends StatefulWidget {
  final PasswordModel password;
  const PasswordInfo({Key? key, required this.password}) : super(key: key);
  @override
  State<PasswordInfo> createState() => _PasswordInfoState();
}

class _PasswordInfoState extends State<PasswordInfo> {
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
                  copyClipboardWidget(
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
