import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lubby_app/src/core/enums/type_transactions.enum.dart';
import 'package:lubby_app/src/core/utils/get_contrasting_text_color.dart';
import 'package:lubby_app/src/features/finances/domain/entities/account_entity.dart';
import 'package:lubby_app/src/features/finances/presentation/bloc/finances_bloc.dart';
import 'package:lubby_app/src/features/finances/presentation/widgets/new_account_widget.dart';

class SelectAccountInNewMovementWidget extends StatefulWidget {
  final AccountEntity? accountSelected;
  final Function(AccountEntity account)? onAccountSelected;
  final BuildContext blocContext;
  final TypeTransactionsEnum type;
  final bool isDest;

  const SelectAccountInNewMovementWidget({
    Key? key,
    this.accountSelected,
    this.onAccountSelected,
    required this.blocContext,
    required this.type,
    this.isDest = false,
  }) : super(key: key);

  @override
  State<SelectAccountInNewMovementWidget> createState() =>
      _SelectAccountInNewMovementWidgetState();
}

class _SelectAccountInNewMovementWidgetState
    extends State<SelectAccountInNewMovementWidget> {
  AccountEntity? accountSelected;
  late final TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    accountSelected = widget.accountSelected;

    _textEditingController = TextEditingController(
      text: widget.isDest
          ? 'Seleccionar cuenta de destino'
          : 'Seleccionar cuenta de origen',
    );
    if (accountSelected != null) {
      _textEditingController.text = accountSelected!.name;
    }
  }

  crearNuevaCuenta() async {
    final account = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => NewAccountWidget(blocContext: widget.blocContext),
    );

    if (account != null) {
      widget.onAccountSelected?.call(account);
      setState(() {
        accountSelected = account;
        _textEditingController.text =
            '${accountSelected!.name} (\$${accountSelected!.balance.toStringAsFixed(2)})';
      });
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
  }

  /// Muestra un dialogo con las cuentas disponibles
  /// para seleccionar una
  showDialogAccounts() {
    final bloc = BlocProvider.of<FinancesBloc>(
      widget.blocContext,
      listen: false,
    );

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Seleccionar una cuenta'),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 0.0,
          vertical: 10,
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Nueva cuenta'),
                leading: const Icon(Icons.add),
                subtitle: const Text('Crear una nueva cuenta'),
                onTap: crearNuevaCuenta,
              ),
              ...bloc.state.accounts.map(
                (e) {
                  final account = e;
                  return ListTile(
                    onTap: () {
                      widget.onAccountSelected?.call(account);
                      setState(() {
                        accountSelected = account;
                        _textEditingController.text =
                            '${accountSelected!.name} (\$${accountSelected!.balance.toStringAsFixed(2)})';
                      });
                      Navigator.pop(context);
                    },
                    title: Text(account.name),
                    subtitle: Text(account.description ?? ''),
                    trailing: Text(account.balance.toStringAsFixed(2)),
                    leading: CircleAvatar(
                      backgroundColor: account.color,
                      child: Icon(
                        account.icon,
                        color: getContrastingTextColor(account.color),
                      ),
                    ),
                  );
                },
              ).toList(),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      onTap: showDialogAccounts,
      controller: _textEditingController,
      decoration: InputDecoration(
        labelText: widget.isDest ? 'Cuenta destino' : 'Cuenta origen',
        hintText: 'Fecha del movimiento',
        prefixIcon: const Icon(Icons.account_balance_wallet),
        suffixIcon: accountSelected != null
            ? CircleAvatar(
                backgroundColor: accountSelected!.color,
                child: Icon(
                  accountSelected!.icon,
                  color: getContrastingTextColor(accountSelected!.color),
                ),
              )
            : const Icon(Icons.arrow_drop_down),
      ),
    );
    /* return GestureDetector(
      onTap: showDialogAccounts,
      child: Container(
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          border: Border.all(
            color: Theme.of(context).highlightColor,
          ),
        ),
        child: Row(
          children: [
            if (accountSelected != null)
              CircleAvatar(
                backgroundColor: accountSelected!.color,
                child: Icon(
                  accountSelected!.icon,
                  color: getContrastingTextColor(accountSelected!.color),
                ),
              ),
            if (accountSelected == null)
              const Icon(Icons.account_balance_wallet),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (accountSelected != null)
                    Text(widget.isDest ? 'Cuenta de destino' : 'Cuenta'),
                  if (accountSelected != null) const SizedBox(height: 5.0),
                  Text(
                    accountSelected != null
                        ? '${accountSelected!.name} (${accountSelected!.balance})'
                        : widget.isDest
                            ? 'Seleccionar una cuenta de destino'
                            : 'Seleccionar una cuenta',
                    style: accountSelected != null
                        ? const TextStyle(fontWeight: FontWeight.bold)
                        : const TextStyle(),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.arrow_drop_down),
            )
          ],
        ),
      ),
    ); */
  }
}
