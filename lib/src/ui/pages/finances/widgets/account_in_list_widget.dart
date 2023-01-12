import 'package:flutter/material.dart';
import 'package:lubby_app/src/config/routes/routes.dart';

class AccountInListWidget extends StatelessWidget {
  const AccountInListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          financesAccountRoute,
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
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.vertical(
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
                          border: Border.all(color: Colors.white),
                        ),
                        child: const FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Icon(Icons.credit_card),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      const Text(
                        'Bancoppel',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const Text(
                    '50.00',
                    style: textStileTextIndicator,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      children: const [
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
                  Expanded(
                    child: Column(
                      children: const [
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

const textStileTextIndicator = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 16,
);
