import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lubby_app/src/presentation/widgets/menu_drawer.dart';

import 'bloc/finances_bloc.dart';

part 'widgets/accounts_page_item_widget.dart';
part 'widgets/balance_page_item_widget.dart';
part 'widgets/dashboard_page_item_widget.dart';
part 'widgets/settings_page_item_widget.dart';

class FinancesPage extends StatelessWidget {
  const FinancesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FinancesBloc(),
      child: _BuildPage(),
    );
  }
}

class _BuildPage extends StatelessWidget {
  _BuildPage({
    Key? key,
  }) : super(key: key);

  final PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<FinancesBloc>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Finanzas'),
      ),
      drawer: const Menu(),
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          DashboardPageItemWidget(),
          BalancePageItemWidget(),
          AccountsPageItemWidget(),
          SettingsPageItemWidget(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          switch (bloc.state.index) {
            case 0:
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bloc.state.index,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          bloc.add(ChangePageEvent(index));
          pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money_outlined),
            label: 'Balance',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wallet),
            label: 'Cuentas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Config.',
          ),
        ],
      ),
    );
  }
}
