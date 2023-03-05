import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeaderModalBottomWidget extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onSave;
  final String title;

  const HeaderModalBottomWidget({
    Key? key,
    required this.onCancel,
    required this.onSave,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton.icon(
            icon: const Icon(CupertinoIcons.xmark_circle),
            onPressed: onCancel,
            label: const Text('Cancelar'),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.red),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 10),
          TextButton.icon(
            onPressed: onSave,
            label: const Text('Guardar'),
            icon: const Icon(CupertinoIcons.checkmark_circle),
          ),
        ],
      ),
    );
  }
}
