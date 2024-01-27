import 'package:flutter/material.dart';

import '../../../../config/routes/routes.dart';
import '../../../../config/routes_settings/finances_route_settings.dart';
import '../../../../core/enums/type_transactions.enum.dart';
import '../../../../core/utils/get_contrasting_text_color.dart';
import '../../domain/entities/account_entity.dart';
import '../../domain/entities/transaction_entity.dart';

class ItemTransactionListtileWidget extends StatelessWidget {
  final TransactionEntity item;

  const ItemTransactionListtileWidget({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).pushNamed(
          financesTransactionDetailRoute,
          arguments: TransactionRouteSettings(transaction: item),
        );
      },
      leading: CircleAvatar(
        backgroundColor: item.type == TypeTransactionsEnum.income.name
            ? Colors.green
            : item.type == TypeTransactionsEnum.expense.name
                ? Colors.red
                : Colors.blue,
        child: Icon(
          item.type == TypeTransactionsEnum.income.name
              ? Icons.arrow_upward
              : item.type == TypeTransactionsEnum.expense.name
                  ? Icons.arrow_downward
                  : Icons.compare_arrows,
        ),
      ),
      title: Text(
        item.title,
        maxLines: 2,
      ),
      subtitle: Wrap(
        children: [
          _accountView(item.account),
          if (item.type == TypeTransactionsEnum.transfer.name)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: CircleAvatar(
                radius: 10,
                child: Icon(
                  Icons.keyboard_double_arrow_right,
                  size: 15,
                ),
              ),
            ),
          if (item.type == TypeTransactionsEnum.transfer.name)
            _accountView(item.accountDest!),
        ],
      ),
      trailing: Text(
        '\$${item.amount.toStringAsFixed(2)}',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _accountView(AccountEntity item) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: item.color.withOpacity(0.2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 10,
            backgroundColor: item.color,
            child: Icon(
              item.icon,
              color: getContrastingTextColor(item.color),
              size: 12,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            item.name,
            style: TextStyle(
              fontSize: 10,
              color: getContrastingTextColor(
                item.color.withOpacity(0.2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
