import 'package:flutter/material.dart';

class AlertConfirmDeletionWidget extends StatelessWidget {
  final String? title;
  final String message;

  const AlertConfirmDeletionWidget({
    super.key,
    required this.message,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      contentPadding: const EdgeInsets.all(12.0),
      title: title != null && title!.isNotEmpty ? Text(title!) : null,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(message),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: const Text('Si, eliminar'),
        ),
      ],
    );
  }
}
