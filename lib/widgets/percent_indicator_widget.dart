import 'dart:math';

import 'package:flutter/material.dart';

class PercentIndicatorWidget extends StatelessWidget {
  final double? size;
  final Widget? child;
  final int currentProgress;
  final Color? backgroundIndicator;
  final Color? indicatorColor;

  const PercentIndicatorWidget({
    required this.currentProgress,
    this.size = 200,
    this.child,
    this.backgroundIndicator = Colors.black45,
    this.indicatorColor = Colors.blue,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: CircleProgress(
        currentProgress: currentProgress,
        indicatorColor: indicatorColor!,
        backgroundIndicator: backgroundIndicator!,
      ),
      child: SizedBox(
        width: size,
        height: size,
        child: Center(child: child),
      ),
    );
  }
}

class CircleProgress extends CustomPainter {
  final int currentProgress;
  final Color backgroundIndicator;
  final Color indicatorColor;

  CircleProgress({
    required this.backgroundIndicator,
    required this.indicatorColor,
    required this.currentProgress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint outerCircle = Paint()
      ..strokeWidth = 7
      ..color = backgroundIndicator
      ..style = PaintingStyle.stroke;

    Paint completeCircle = Paint()
      ..strokeWidth = 7
      ..style = PaintingStyle.stroke
      ..color = indicatorColor
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2) - 7;
    double angle = 2 * pi * (currentProgress / 100);

    canvas.drawCircle(center, radius, outerCircle);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      angle,
      false,
      completeCircle,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
