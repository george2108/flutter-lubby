import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/enums/type_transactions.enum.dart';

class ChooseMovementTypeWidget extends StatefulWidget {
  final Function(String value)? onValueChanged;

  const ChooseMovementTypeWidget({
    super.key,
    this.onValueChanged,
  });

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
      children: const {
        0: Row(
          children: [
            Icon(Icons.arrow_upward),
            Text('Déposito'),
          ],
        ),
        1: Row(
          children: [
            Icon(Icons.arrow_downward),
            Text('Retiro'),
          ],
        ),
        2: Row(
          children: [
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
