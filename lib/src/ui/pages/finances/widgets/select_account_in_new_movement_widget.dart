import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lubby_app/src/core/enums/type_transactions.enum.dart';
import 'package:lubby_app/src/core/utils/get_contrasting_text_color.dart';
import 'package:lubby_app/src/ui/pages/finances/bloc/finances_bloc.dart';
import 'package:lubby_app/src/ui/pages/finances/widgets/new_account_widget.dart';

import '../../../../domain/entities/finances/account_entity.dart';

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

  @override
  void initState() {
    super.initState();
    accountSelected = widget.accountSelected;
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
        content: bloc.state.accounts.isEmpty
            ? ListTile(
                title: const Text('Nueva cuenta'),
                leading: const Icon(Icons.add),
                subtitle: const Text('Crear una nueva cuenta'),
                onTap: crearNuevaCuenta,
              )
            : SingleChildScrollView(
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
                            });
                            Navigator.pop(context);
                          },
                          title: Text(account.name),
                          subtitle: Text(account.description ?? ''),
                          trailing: Text(account.balance.toString()),
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
    return GestureDetector(
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
    );
  }
}