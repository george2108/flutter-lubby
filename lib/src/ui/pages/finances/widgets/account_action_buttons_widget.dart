import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lubby_app/src/core/utils/get_contrasting_text_color.dart';
import 'package:lubby_app/src/domain/entities/finances/account_entity.dart';

class AccountActionButtonsWidget extends StatelessWidget {
  final double _heightActionBottom;
  final double percent;
  final AccountEntity account;

  const AccountActionButtonsWidget({
    Key? key,
    required double heightActionBottom,
    required this.percent,
    required this.account,
  })  : _heightActionBottom = heightActionBottom,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle style = TextStyle(
      color: getContrastingTextColor(account.color),
      fontWeight: FontWeight.bold,
    );

    return Positioned(
      right: 0,
      left: 0,
      bottom: _heightActionBottom * (1 - percent) + 10,
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 0, end: 1),
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeIn,
        builder: (context, double value, child) {
          return Transform.translate(
            offset: Offset(0, 70 * (1 - value)),
            child: child,
          );
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Opacity(
                  opacity: 1 - percent,
                  child: Text('Nuevo ingreso', style: style),
                ),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).highlightColor,
                  ),
                  child: Icon(
                    CupertinoIcons.hand_thumbsup,
                    color: getContrastingTextColor(account.color),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Opacity(
                  opacity: 1 - percent,
                  child: Text('nuevo gasto', style: style),
                ),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).highlightColor,
                  ),
                  child: Icon(
                    CupertinoIcons.hand_thumbsdown,
                    color: getContrastingTextColor(account.color),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Opacity(
                  opacity: 1 - percent,
                  child: Text('Nueva transf.', style: style),
                ),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).highlightColor,
                  ),
                  child: Icon(
                    Icons.swap_horiz,
                    color: getContrastingTextColor(account.color),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
