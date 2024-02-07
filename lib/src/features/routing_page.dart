import 'package:flutter/material.dart';
import '../core/constants/responsive_breakpoints.dart';
import '../ui/widgets/menu_drawer/menu_drawer.dart';

class RoutingPage extends StatefulWidget {
  final Widget child;

  const RoutingPage({super.key, required this.child});

  @override
  State<RoutingPage> createState() => _RoutingPageState();
}

class _RoutingPageState extends State<RoutingPage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final showDrawer = width > kMobileBreakpoint;

    return Scaffold(
      body: Row(
        children: [
          Visibility(
            visible: showDrawer,
            child: const SizedBox(
              width: 250,
              height: double.infinity,
              child: MenuDrawerContent(),
            ),
          ),
          Expanded(child: widget.child),
        ],
      ),
    );
  }
}
