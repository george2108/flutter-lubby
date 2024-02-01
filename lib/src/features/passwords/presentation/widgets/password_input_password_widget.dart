import 'package:flutter/material.dart';

////////////////////////////////////////////////////////////////////////////////
///
/// Input de password
///
////////////////////////////////////////////////////////////////////////////////
class PasswordInputPasswordWidget extends StatefulWidget {
  final TextEditingController passwordController;

  const PasswordInputPasswordWidget({
    super.key,
    required this.passwordController,
  });

  @override
  State<PasswordInputPasswordWidget> createState() =>
      _PasswordInputPasswordWidgetState();
}

class _PasswordInputPasswordWidgetState
    extends State<PasswordInputPasswordWidget> {
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.passwordController,
      maxLines: 1,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.visiblePassword,
      obscureText: obscurePassword,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: const Icon(Icons.remove_red_eye),
          onPressed: () {
            setState(() {
              obscurePassword = !obscurePassword;
            });
          },
        ),
        labelText: 'Contraseña',
        hintText: "Contraseña",
        prefixIcon: const Icon(Icons.key),
      ),
      validator: (_) => widget.passwordController.text.trim().isNotEmpty
          ? null
          : 'Contraseña requerida',
    );
  }
}
