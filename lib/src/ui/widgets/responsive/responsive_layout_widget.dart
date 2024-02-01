import 'package:flutter/widgets.dart';

import '../../../core/constants/responsive_breakpoints.dart';

class ResponsiveLayoutWidget extends StatelessWidget {
  final Widget mobile;
  final Widget desktop;

  const ResponsiveLayoutWidget({
    super.key,
    required this.mobile,
    required this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < kMobileBreakpoint) {
          return mobile;
        }

        return desktop;
      },
    );
  }
}
