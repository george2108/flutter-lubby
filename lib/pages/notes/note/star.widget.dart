import 'package:flutter/material.dart';

class NoteStarWidget extends StatelessWidget {
  const NoteStarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.star_outline),
      onPressed: () {},
    );
  }
}
