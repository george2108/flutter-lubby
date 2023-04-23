import 'package:flutter/material.dart';
import 'package:lubby_app/src/domain/entities/finances/account_entity.dart';
import 'package:lubby_app/src/ui/pages/finances/widgets/account_action_buttons_widget.dart';

import '../../../../core/utils/get_contrasting_text_color.dart';

class AccountHeaderDelegate extends SliverPersistentHeaderDelegate {
  final _maxHeaderExtend = 250.0;
  final _minHeaderExtend = 110.0;

  final _heightActionBottom = 60.0;
  final AccountEntity account;

  AccountHeaderDelegate({required this.account});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final size = MediaQuery.of(context).size;

    final percent = shrinkOffset / _maxHeaderExtend;

    return Stack(
      children: [
        Container(
          color: account.color,
        ),
        Positioned(
          right: 0,
          left: 0,
          top: 0,
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: 1),
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeIn,
            builder: (context, double value, child) {
              return Opacity(
                opacity: value,
                child: child,
              );
            },
            child: Column(
              children: [
                Text(
                  'MXN ${account.balance.toStringAsFixed(2)}',
                  maxLines: 1,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                    color: getContrastingTextColor(account.color),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 0,
          left: 0,
          top: 50,
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: 1),
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeIn,
            builder: (context, double value, child) {
              return Opacity(
                opacity: value,
                child: child,
              );
            },
            child: Opacity(
              opacity: 1 - percent,
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: account.color,
                    child: Icon(
                      Icons.ac_unit,
                      color: getContrastingTextColor(
                        account.color.withOpacity(0.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Transform.translate(
            offset: const Offset(0, 1),
            child: Container(
              height: _heightActionBottom,
              width: size.width,
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40 * (1 - percent)),
                  topRight: Radius.circular(40 * (1 - percent)),
                ),
              ),
            ),
          ),
        ),
        AccountActionButtonsWidget(
          heightActionBottom: _heightActionBottom,
          percent: percent,
          account: account,
        ),
      ],
    );
  }

  @override
  double get maxExtent => _maxHeaderExtend;

  @override
  double get minExtent => _minHeaderExtend;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
