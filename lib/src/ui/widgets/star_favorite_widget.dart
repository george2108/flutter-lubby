import 'package:flutter/material.dart';

class StarFavoriteWidget extends StatefulWidget {
  final bool valueInitial;
  final Function(bool value) onStarPressed;

  const StarFavoriteWidget({
    super.key,
    required this.valueInitial,
    required this.onStarPressed,
  });

  @override
  State<StarFavoriteWidget> createState() => _StarFavoriteWidgetState();
}

class _StarFavoriteWidgetState extends State<StarFavoriteWidget> {
  late bool valueInitial;

  @override
  void initState() {
    super.initState();
    valueInitial = widget.valueInitial;
  }

  @override
  Widget build(BuildContext context) {
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
