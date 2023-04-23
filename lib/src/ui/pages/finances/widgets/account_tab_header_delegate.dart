import 'package:flutter/material.dart';

class AccountTabHeaderDelegate extends SliverPersistentHeaderDelegate {
  final TabController tabController;

  AccountTabHeaderDelegate({required this.tabController});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: TabBar(
        controller: tabController,
        tabs: const [
          Tab(
            text: 'Ingresos',
          ),
          Tab(
            text: 'Gastos',
          ),
          Tab(
            text: 'Transferencias',
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 48;

  @override
  double get minExtent => 48;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
