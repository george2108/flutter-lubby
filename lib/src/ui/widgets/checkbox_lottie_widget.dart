import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CheckboxLottieWidget extends StatefulWidget {
  final bool value;
  final Function(bool)? onChanged;

  const CheckboxLottieWidget({
    Key? key,
    required this.value,
    this.onChanged,
  }) : super(key: key);

  @override
  State<CheckboxLottieWidget> createState() => _CheckboxLottieWidgetState();
}

class _CheckboxLottieWidgetState extends State<CheckboxLottieWidget>
    with TickerProviderStateMixin {
  //
  late final AnimationController _controller;
  late bool currentValue;

  bool animating = false;

  final unCompletedStyle = const TextStyle(
    fontWeight: FontWeight.bold,
  );
  final completedStyle = const TextStyle(
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.lineThrough,
    decorationStyle: TextDecorationStyle.solid,
    decorationThickness: 2,
  );

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    currentValue = widget.value;
    if (currentValue) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: animating
          ? null
          : () async {
              setState(() {
                animating = true;
              });
              if (_controller.status == AnimationStatus.completed) {
                await _controller.reverse();
                setState(() {
                  animating = false;
                });
              } else if (_controller.status == AnimationStatus.dismissed) {
                await _controller.forward();
                setState(() {
                  animating = false;
                });
              }
              setState(() {
                currentValue = !currentValue;
                widget.onChanged?.call(currentValue);
              });
            },
      child: SizedBox(
        width: 30,
        height: 30,
        child: OverflowBox(
          maxHeight: 70,
          maxWidth: 70,
          child: Lottie.asset(
            'assets/checkbox.json',
            repeat: false,
            controller: _controller,
          ),
        ),
      ),
    );
  }
}
