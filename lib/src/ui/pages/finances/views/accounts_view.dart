part of '../finances_main_page.dart';

class AccountsView extends StatelessWidget {
  const AccountsView({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<FinancesBloc>(context, listen: true);

    if (bloc.state.accounts.isEmpty) {
      return const Center(
        child: Text('No hay cuentas'),
      );
    }

    final accounts = bloc.state.accounts;

    return ListView.separated(
      padding: const EdgeInsets.only(
        top: 8.0,
        left: 8.0,
        right: 8.0,
        bottom: 30.0,
      ),
      separatorBuilder: (_, __) => const SizedBox(height: 10.0),
      itemCount: accounts.length,
      itemBuilder: (_, index) {
        return AccountInListWidget(
          account: accounts[index],
        );
      },
    );
  }
}
