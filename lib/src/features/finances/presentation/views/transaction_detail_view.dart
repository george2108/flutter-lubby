import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/enums/type_transactions.enum.dart';
import '../../../../core/utils/get_contrasting_text_color.dart';
import '../../domain/entities/transaction_entity.dart';

class TransactionDetailView extends StatelessWidget {
  final TransactionEntity transaction;

  const TransactionDetailView({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de transacción'),
      ),
      // body para ver el detalle de la transacción seleccionada
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: Text(
              'MXN ${transaction.amount.toString()}',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: transaction.type == 'income'
                    ? Colors.green
                    : transaction.type == 'expense'
                        ? Colors.red
                        : Colors.blue,
              ),
            ),
          ),
          const SizedBox(height: 15),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      transaction.type == TypeTransactionsEnum.expense.name
                          ? 'Gasto'
                          : transaction.type == TypeTransactionsEnum.income.name
                              ? 'Ingreso'
                              : 'Transferencia',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: transaction.type == 'income'
                            ? Colors.green
                            : transaction.type == 'expense'
                                ? Colors.red
                                : Colors.blue,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      const Text(
                        'Fecha: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        DateFormat('dd/MM/yyyy').format(transaction.createdAt),
                      ),
                    ],
                  ),
                  if (transaction.description != null &&
                      transaction.description!.isNotEmpty)
                    const SizedBox(height: 5),
                  if (transaction.description != null &&
                      transaction.description!.isNotEmpty)
                    Row(
                      children: [
                        const Text(
                          'Descripción: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(transaction.description!),
                      ],
                    ),
                ],
              ),
            ),
          ),
          if (transaction.label != null) const SizedBox(height: 10),
          if (transaction.label != null)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Categoria',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      leading: CircleAvatar(
                        backgroundColor: transaction.label!.color,
                        child: Icon(
                          transaction.label!.icon,
                          color:
                              getContrastingTextColor(transaction.label!.color),
                        ),
                      ),
                      title: Text(transaction.label!.name),
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 10),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Cuenta de origen',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    leading: CircleAvatar(
                      backgroundColor: transaction.account.color,
                      child: Icon(
                        transaction.account.icon,
                        color:
                            getContrastingTextColor(transaction.account.color),
                      ),
                    ),
                    title: Text(transaction.account.name),
                    subtitle: Text(transaction.account.description ?? ''),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          if (transaction.accountDest != null)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Cuenta de destino',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      leading: CircleAvatar(
                        backgroundColor: transaction.accountDest!.color,
                        child: Icon(
                          transaction.accountDest!.icon,
                          color: getContrastingTextColor(
                            transaction.accountDest!.color,
                          ),
                        ),
                      ),
                      title: Text(transaction.accountDest!.name),
                      subtitle:
                          Text(transaction.accountDest!.description ?? ''),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
