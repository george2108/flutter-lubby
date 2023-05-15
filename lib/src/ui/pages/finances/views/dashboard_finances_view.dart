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
        return ItemTransactionListtileWidget(item: item);
      },
    );
  }
}
