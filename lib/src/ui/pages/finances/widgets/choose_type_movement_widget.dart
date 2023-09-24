import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lubby_app/src/core/enums/type_transactions.enum.dart';

class ChooseTypeMovementWidget extends StatefulWidget {
  final TypeTransactionsEnum typeTransaction;
  final Function(TypeTransactionsEnum value)? onTypeTransactionChanged;
  final bool includeTransfers;
  final bool includeAlls;

  const ChooseTypeMovementWidget({
    Key? key,
    required this.typeTransaction,
    this.onTypeTransactionChanged,
    this.includeTransfers = false,
    this.includeAlls = false,
  }) : super(key: key);

  @override
  State<ChooseTypeMovementWidget> createState() =>
      _ChooseTypeMovementWidgetState();
}

class _ChooseTypeMovementWidgetState extends State<ChooseTypeMovementWidget> {
  late final TextEditingController textController;
  late TypeTransactionsEnum? typeTransactionSelected;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController(
      text: widget.typeTransaction == TypeTransactionsEnum.all
          ? 'Todos'
          : widget.typeTransaction == TypeTransactionsEnum.income
              ? 'Déposito'
              : widget.typeTransaction == TypeTransactionsEnum.expense
                  ? 'Retiro'
                  : 'Transferencia',
    );
    typeTransactionSelected = widget.typeTransaction;
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      onSelected: (value) {
        setState(() {
          typeTransactionSelected = value;
        });
        textController.text =
            typeTransactionSelected == TypeTransactionsEnum.all
                ? 'Todos'
                : typeTransactionSelected == TypeTransactionsEnum.income
                    ? 'Déposito'
                    : typeTransactionSelected == TypeTransactionsEnum.expense
                        ? 'Retiro'
                        : 'Transferencia';
        widget.onTypeTransactionChanged?.call(value);
      },
      itemBuilder: (_) {
        return [
          if (widget.includeAlls)
            const PopupMenuItem(
              value: TypeTransactionsEnum.all,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.yellowAccent,
                    child: Icon(
                      CupertinoIcons.layers_alt_fill,
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Text('Todos'),
                ],
              ),
            ),
          if (widget.includeTransfers)
            const PopupMenuItem(
              value: TypeTransactionsEnum.transfer,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.blue,
                    child: Icon(
                      Icons.change_circle_outlined,
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Text('Transferencias'),
                ],
              ),
            ),
          const PopupMenuItem(
            value: TypeTransactionsEnum.income,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.green,
                  child: Icon(
                    Icons.arrow_downward,
                  ),
                ),
                SizedBox(width: 10.0),
                Text('Déposito'),
              ],
            ),
          ),
          const PopupMenuItem(
            value: TypeTransactionsEnum.expense,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.redAccent,
                  child: Icon(
                    Icons.arrow_upward,
                  ),
                ),
                SizedBox(width: 10.0),
                Text('Retiro'),
              ],
            ),
          ),
        ];
      },
      child: TextField(
        enabled: false,
        controller: textController,
        decoration: const InputDecoration(
          labelText: 'Tipo de movimiento',
          hintText: 'Tipo de movimiento',
          suffixIcon: Icon(Icons.arrow_drop_down_outlined),
        ),
      ),
    );
  }
}
