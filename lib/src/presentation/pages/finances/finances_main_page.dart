import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lubby_app/src/config/routes/routes.dart';
import 'package:lubby_app/src/presentation/pages/finances/widgets/account_in_list_widget.dart';
import 'package:lubby_app/src/presentation/widgets/menu_drawer.dart';

import 'bloc/finances_bloc.dart';

part 'views/accounts_page_item.dart';
part 'views/balance_page_item.dart';
part 'views/dashboard_page_item.dart';
part 'views/settings_page_item.dart';
part 'views/new_account_page.dart';
part 'views/new_account_movement_page_item.dart';

class FinancesMainPage extends StatelessWidget {
  const FinancesMainPage({super.key});

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

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<FinancesBloc>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Finanzas'),
      ),
      drawer: const Menu(),
      body: IndexedStack(
        index: bloc.state.index,
        children: const [
          DashboardPageItem(),
          BalancePageItem(),
          AccountsPageItem(),
          SettingsPageItem(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          switch (bloc.state.index) {
            case 2:
              Navigator.pushNamed(context, financesNewAccountRoute);
              break;
            case 0:
            case 1:
            case 3:
              Navigator.of(context).pushNamed(financesNewAccountMovementRoute);
              break;
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bloc.state.index,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          bloc.add(ChangePageEvent(index));
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
