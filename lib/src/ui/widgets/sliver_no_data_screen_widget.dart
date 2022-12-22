import 'package:flutter/material.dart';

class SliverNoDataScreenWidget extends StatelessWidget {
  final Widget child;
  final String appBarTitle;

  const SliverNoDataScreenWidget({
    required this.child,
    required this.appBarTitle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text(appBarTitle),
          actions: [
            IconButton(
              icon: const Icon(Icons.help_outline),
              onPressed: () {},
            ),
          ],
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: child,
          ),
        ),
      ],
    );
  }
}
