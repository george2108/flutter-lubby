import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoDataWidget extends StatelessWidget {
  final String text;
  final String lottie;

  const NoDataWidget({
    super.key,
    required this.text,
    required this.lottie,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        Lottie.asset(lottie),
      ],
    );
  }
}
