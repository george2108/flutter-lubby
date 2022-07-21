import 'package:flutter/material.dart';

class ButtonSaveWidget extends StatelessWidget {
  final String title;
  final VoidCallback action;
  final bool loading;

  const ButtonSaveWidget({
    required this.title,
    required this.action,
    required this.loading,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: loading ? null : action,
      child: Container(
        alignment: Alignment.center,
        height: 50,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Theme.of(context).buttonTheme.colorScheme!.background,
        ),
        width: double.infinity,
        child: loading
            ? const CircularProgressIndicator()
            : Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
      ),
    );
  }
}
