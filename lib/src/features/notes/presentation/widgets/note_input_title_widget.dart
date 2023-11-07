import 'package:flutter/material.dart';

class NoteInputTitleWidget extends StatelessWidget {
  final TextEditingController titleController;
  final void Function()? touched;

  const NoteInputTitleWidget({
    Key? key,
    required this.titleController,
    this.touched,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: titleController,
      onTap: () {
        touched?.call();
      },
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      maxLength: 500,
      decoration: const InputDecoration(
        border: InputBorder.none,
        counterText: '',
        hintText: "Titulo de la nota",
      ),
    );
  }
}
