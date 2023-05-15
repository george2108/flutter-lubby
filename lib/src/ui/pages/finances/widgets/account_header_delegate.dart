import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lubby_app/src/core/enums/type_transactions.enum.dart';
import 'package:lubby_app/src/domain/entities/finances/account_entity.dart';
import 'package:lubby_app/src/ui/pages/finances/widgets/choose_type_movement_widget.dart';

import '../../../../core/utils/get_contrasting_text_color.dart';

class AccountHeaderDelegate extends SliverPersistentHeaderDelegate {
  final _maxHeaderExtend = 220.0;
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
          bottom: _heightActionBottom + 10,
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
            child: Opacity(
              opacity: clampDouble(1 - percent * 5, 0, 1),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
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
          bottom: 0,
          child: Transform.translate(
            offset: const Offset(0, 1),
            child: Container(
              padding: const EdgeInsets.all(10),
              height: _heightActionBottom,
              width: size.width,
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30 * (1 - percent)),
                  topRight: Radius.circular(30 * (1 - percent)),
                ),
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: ChooseTypeMovementWidget(
                      typeTransaction: TypeTransactionsEnum.all,
                      includeTransfers: true,
                      includeAlls: true,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        final dates = await showDateRangePicker(
                          context: context,
                          firstDate: DateTime(1990),
                          lastDate: DateTime(3000),
                        );
                        print(dates);
                      },
                      child: TextField(
                        enabled: false,
                        controller: TextEditingController(
                          text: '21/10/2023 - 15/11/2023',
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Fechas',
                          hintText: 'Filtros de fechas',
                          suffixIcon: Icon(Icons.arrow_drop_down_outlined),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
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
