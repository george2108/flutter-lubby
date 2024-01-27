import 'package:flutter/material.dart';

class CheckboxAnimatedWidget extends StatefulWidget {
  const CheckboxAnimatedWidget({super.key});
  @override
  State<CheckboxAnimatedWidget> createState() => _CheckboxAnimatedWidgetState();
}

class _CheckboxAnimatedWidgetState extends State<CheckboxAnimatedWidget>
    with TickerProviderStateMixin {
  bool _isChecked = false;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onChanged(bool value) {
    setState(() {
      _isChecked = value;
      if (_isChecked) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            _onChanged(!_isChecked);
          },
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _isChecked ? Colors.green : Colors.transparent,
                  border: Border.all(
                    color: _isChecked ? Colors.green : Colors.grey,
                    width: 2,
                  ),
                ),
                child: _isChecked
                    ? Icon(
                        Icons.check,
                        color: Colors.white,
                        size: _animation.value * 20,
                      )
                    : Container(),
              )
            ],
          ),
        );
      },
    );
  }
}
