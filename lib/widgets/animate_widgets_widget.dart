import 'package:flutter/material.dart';

class CustomAnimatedWidget extends StatefulWidget {
  final Widget child;
  final int index;
  const CustomAnimatedWidget({
    required this.child,
    required this.index,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomAnimatedWidget> createState() => CustomAnimatedWidgetState();
}

class CustomAnimatedWidgetState extends State<CustomAnimatedWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController? controller;
  late Animation<double> opacity;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);

    animation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: controller!,
        curve: Curves.easeIn,
      ),
    );

    opacity = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: controller!, curve: const Interval(0, 0.65)));

    Future.delayed(Duration(milliseconds: widget.index * 100), () {
      controller?.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnimatedBuilder(
      animation: controller!,
      builder: (context, _) => Transform.translate(
        offset: Offset(0.0, size.width / 2 * animation.value),
        child: Opacity(
          opacity: opacity.value,
          child: widget.child,
        ),
      ),
    );
  }
}
