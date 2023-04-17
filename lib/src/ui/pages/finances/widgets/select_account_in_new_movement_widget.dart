import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lubby_app/src/core/utils/get_contrasting_text_color.dart';
import 'package:lubby_app/src/ui/pages/finances/bloc/finances_bloc.dart';

import '../../../../domain/entities/finances/account_entity.dart';

class SelectAccountInNewMovementWidget extends StatefulWidget {
  final AccountEntity? accountSelected;
  final Function(AccountEntity)? onAccountSelected;
  final BuildContext blocContext;

  const SelectAccountInNewMovementWidget({
    Key? key,
    this.accountSelected,
    this.onAccountSelected,
    required this.blocContext,
  }) : super(key: key);

  @override
  State<SelectAccountInNewMovementWidget> createState() =>
      _SelectAccountInNewMovementWidgetState();
}

class _SelectAccountInNewMovementWidgetState
    extends State<SelectAccountInNewMovementWidget> {
  showDialogAccounts() {
    final bloc = BlocProvider.of<FinancesBloc>(
      widget.blocContext,
      listen: false,
    );

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Seleccionar una cuenta'),
        content: bloc.state.accounts.isEmpty
            ? ListTile(
                title: const Text('Nueva cuenta'),
                leading: const Icon(Icons.add),
                subtitle: const Text('Crear una nueva cuenta'),
                onTap: () {
                  Navigator.pop(context);
                },
              )
            : SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      title: const Text('Nueva cuenta'),
                      leading: const Icon(Icons.add),
                      subtitle: const Text('Crear una nueva cuenta'),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    ...bloc.state.accounts.map(
                      (e) {
                        final account = e;
                        return ListTile(
                          onTap: () {
                            Navigator.pop(context);
                            widget.onAccountSelected?.call(account);
                          },
                          title: Text(account.name),
                          subtitle: Text(account.description ?? ''),
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
            if (widget.accountSelected != null)
              CircleAvatar(
                backgroundColor: Colors.red,
                child: Icon(
                  Icons.cast_connected,
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
              ),
            if (widget.accountSelected == null)
              const Icon(Icons.account_balance_wallet),
            const SizedBox(width: 10.0),
            Expanded(
              child: Text(
                'Seleccionar una cuenta',
                style: widget.accountSelected != null
                    ? const TextStyle(fontWeight: FontWeight.bold)
                    : const TextStyle(),
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
