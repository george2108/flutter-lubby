import 'package:flutter/material.dart';

class StarFavoriteWidget extends StatefulWidget {
  final bool valueInitial;
  final Function(bool value) onStarPressed;

  const StarFavoriteWidget({
    Key? key,
    required this.valueInitial,
    required this.onStarPressed,
  }) : super(key: key);

  @override
  State<StarFavoriteWidget> createState() => _StarFavoriteWidgetState();
}

class _StarFavoriteWidgetState extends State<StarFavoriteWidget> {
  bool valueInitial = false;

  @override
  Widget build(BuildContext context) {
    valueInitial = widget.valueInitial;

    return IconButton(
      icon: valueInitial
          ? const Icon(Icons.star, color: Colors.yellow)
          : const Icon(Icons.star_outline),
      onPressed: () {
        setState(() {
          valueInitial = !valueInitial;
          widget.onStarPressed(valueInitial);
        });
      },
    );
  }
}
