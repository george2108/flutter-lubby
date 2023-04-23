import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lubby_app/src/core/enums/type_transactions.enum.dart';

class ChooseMovementTypeWidget extends StatefulWidget {
  final Function(String value)? onValueChanged;

  const ChooseMovementTypeWidget({
    Key? key,
    this.onValueChanged,
  }) : super(key: key);

  @override
  State<ChooseMovementTypeWidget> createState() =>
      ChooseMovementTypeWidgetState();
}

class ChooseMovementTypeWidgetState extends State<ChooseMovementTypeWidget> {
  int optionSelected = 0;

  @override
  Widget build(BuildContext context) {
    return CupertinoSegmentedControl(
      groupValue: optionSelected,
      unselectedColor: Theme.of(context).canvasColor,
      children: {
        0: Row(
          children: const [
            Icon(Icons.arrow_upward),
            Text('Déposito'),
          ],
        ),
        1: Row(
          children: const [
            Icon(Icons.arrow_downward),
            Text('Retiro'),
          ],
        ),
        2: Row(
          children: const [
            Icon(Icons.swap_horiz),
            Text('Transferencia'),
          ],
        ),
      },
      onValueChanged: (value) {
        setState(() {
          optionSelected = value;
        });
        widget.onValueChanged?.call(
          optionSelected == 0
              ? TypeTransactionsEnum.income.name
              : optionSelected == 1
                  ? TypeTransactionsEnum.expense.name
                  : TypeTransactionsEnum.transfer.name,
        );
      },
    );
  }
}
