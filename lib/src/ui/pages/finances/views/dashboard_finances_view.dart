part of '../finances_main_page.dart';

class DashboardFinancesView extends StatelessWidget {
  const DashboardFinancesView({super.key});

  @override
  Widget build(BuildContext context) {
    final blocListening = BlocProvider.of<FinancesBloc>(context, listen: true);

    return ListView.builder(
      itemCount: blocListening.state.transactions.length,
      itemBuilder: (context, index) {
        final item = blocListening.state.transactions[index];
        return ListTile(
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
          subtitle: Row(
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
            '\$${item.amount}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        );
      },
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
        children: [
          CircleAvatar(
            radius: 10,
            backgroundColor: item.color,
            child: Icon(
              item.icon,
              color: getContrastingTextColor(item.color),
              size: 15,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            item.name,
            style: TextStyle(
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
