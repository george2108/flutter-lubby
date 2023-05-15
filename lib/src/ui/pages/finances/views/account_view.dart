part of '../finances_main_page.dart';

class AcountView extends StatelessWidget {
  final AccountEntity account;
  final BuildContext financesContext;

  const AcountView({
    super.key,
    required this.account,
    required this.financesContext,
  });

  @override
  Widget build(BuildContext context) {
    final financesRepository = injector.get<FinancesRepository>();

    return Scaffold(
      body: FutureBuilder(
        future: financesRepository.getTransactions(accountId: account.id),
        builder: (context, snapshot) {
          bool loading = snapshot.connectionState == ConnectionState.waiting &&
              !snapshot.hasData;
          bool error = snapshot.hasError;
          final hasData = snapshot.hasData;

          final data = snapshot.data ?? [];

          return CustomScrollView(
            slivers: [
              SliverAppBar.medium(
                title: Text(
                  account.name,
                  style: TextStyle(
                    color: getContrastingTextColor(account.color),
                  ),
                ),
                backgroundColor: account.color,
                pinned: true,
                automaticallyImplyLeading: false,
                leading: BackButton(
                  color: getContrastingTextColor(account.color),
                ),
                surfaceTintColor: account.color,
                actions: [
                  IconButton(
                    icon: Icon(
                      Icons.more_vert,
                      color: getContrastingTextColor(account.color),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              SliverPersistentHeader(
                delegate: AccountHeaderDelegate(account: account),
                pinned: true,
              ),
              if (loading)
                const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              if (error)
                const SliverFillRemaining(
                  child: Center(
                    child: Text('Error'),
                  ),
                ),
              if (data.isEmpty)
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Text('No hay movimientos'),
                  ),
                ),
              if (hasData && data.isNotEmpty)
                SliverList(
                  delegate: SliverChildListDelegate(
                    List.generate(
                      data.length,
                      (index) => ItemTransactionListtileWidget(
                        item: data[index],
                      ),
                    ),
                  ),
                ),
              if (hasData && data.isNotEmpty)
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 100,
                  ),
                ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Nuevo movimiento'),
        icon: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(
            financesNewAccountMovementRoute,
            arguments: NewMovementRouteSettings(
              movementContext: financesContext,
            ),
          );
        },
      ),
    );
  }
}
