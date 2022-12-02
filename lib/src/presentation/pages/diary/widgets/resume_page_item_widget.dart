part of '../diary_main_page.dart';

class ResumePageItemWidget extends StatelessWidget {
  const ResumePageItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween(begin: 100.0, end: 0.0),
      curve: Curves.easeInOutCirc,
      duration: const Duration(milliseconds: 500),
      child: const Center(
        child: Text('resume'),
      ),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, value),
          child: child,
        );
      },
    );
  }
}
