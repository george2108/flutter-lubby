import 'package:flutter/material.dart';

class NoteStarWidget extends StatefulWidget {
  bool valueInitial;
  final Function(bool value) onStarPressed;

  NoteStarWidget({
    Key? key,
    required this.valueInitial,
    required this.onStarPressed,
  }) : super(key: key);

  @override
  State<NoteStarWidget> createState() => _NoteStarWidgetState();
}

class _NoteStarWidgetState extends State<NoteStarWidget> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: widget.valueInitial
          ? const Icon(Icons.star, color: Colors.yellow)
          : const Icon(Icons.star_outline),
      onPressed: () {
        setState(() {
          widget.valueInitial = !widget.valueInitial;
          widget.onStarPressed(widget.valueInitial);    
        });
      },
    );
  }
}
