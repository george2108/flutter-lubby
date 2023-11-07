import 'package:flutter/material.dart';
import 'package:lubby_app/src/config/routes/routes.dart';
import 'package:lubby_app/src/config/routes_settings/finances_route_settings.dart';
import 'package:lubby_app/src/core/utils/get_contrasting_text_color.dart';
import 'package:lubby_app/src/features/finances/domain/entities/account_entity.dart';

class AccountInListWidget extends StatelessWidget {
  final AccountEntity account;

  const AccountInListWidget({
    Key? key,
    required this.account,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          financesAccountRoute,
          arguments: ViewAccountRouteSettings(
            financesContext: context,
            account: account,
          ),
        );
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Theme.of(context).hintColor),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: account.color,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(10),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: getContrastingTextColor(account.color),
                          ),
                        ),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Icon(
                            account.icon,
                            color: getContrastingTextColor(account.color),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Text(
                        account.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: getContrastingTextColor(account.color),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '\$${account.balance.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: getContrastingTextColor(account.color),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Column(
                      children: [
                        Text('ingresos'),
                        SizedBox(height: 5.0),
                        Text(
                          '\$635.55',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    width: 1,
                    height: 20,
                  ),
                  const Expanded(
                    child: Column(
                      children: [
                        Text('Gastos'),
                        SizedBox(height: 5.0),
                        Text(
                          '\$635.55',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
