import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../../../injector.dart';
import '../../../../config/routes/routes.dart';
import '../../../../config/routes_settings/finances_route_settings.dart';
import '../../../../core/enums/type_labels.enum.dart';
import '../../../../core/enums/type_transactions.enum.dart';
import '../../../../core/utils/get_contrasting_text_color.dart';
import '../../../labels/domain/entities/label_entity.dart';
import '../../data/repositories/finances_repository.dart';
import '../../domain/entities/account_entity.dart';
import '../../domain/entities/transaction_entity.dart';
import '../bloc/finances_bloc.dart';
import 'finances_labels_view.dart';
import '../widgets/account_header_delegate.dart';
import '../widgets/choose_movement_type_widget.dart';
import '../widgets/item_transaction_listtile_widget.dart';
import '../widgets/new_account_widget.dart';
import '../widgets/account_in_list_widget.dart';
import '../widgets/select_account_in_new_movement_widget.dart';
import '../widgets/select_category_movement_widget.dart';
import '../../../../ui/widgets/custom_snackbar_widget.dart';
import '../../../../ui/widgets/menu_drawer.dart';
import '../../../labels/data/repositories/label_repository.dart';
import '../../../../ui/widgets/modal_new_tag_widget.dart';

part 'accounts_view.dart';
part 'balance_view.dart';
part 'dashboard_finances_view.dart';
part 'settings_finances_view.dart';
part 'account_view.dart';
part 'new_account_movement_view.dart';

class FinancesMainPage extends StatelessWidget {
  const FinancesMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FinancesBloc(
        injector<LabelRepository>(),
        injector<FinancesRepository>(),
      )
        ..add(GetCategoriesEvent())
        ..add(GetAccountsEvent())
        ..add(GetTransactionsEvent()),
      child: const _BuildPage(),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////
class _BuildPage extends StatefulWidget {
  const _BuildPage();

  @override
  State<_BuildPage> createState() => _BuildPageState();
}

class _BuildPageState extends State<_BuildPage> {
  int index = 0;

  getTextFAB() {
    switch (index) {
      case 0:
        return 'Nuevo movimiento';
      case 1:
        return 'Nuevo balance';
      case 2:
        return 'Nueva cuenta';
      case 3:
        return 'Nueva categoría';
      case 4:
        return 'Nueva configuración';
      default:
        return 'Nuevo movimiento';
    }
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<FinancesBloc>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Finanzas'),
      ),
      drawer: const Menu(),
      body: IndexedStack(
        index: index,
        children: const [
          DashboardFinancesView(),
          BalanceView(),
          AccountsView(),
          FinancesLabelsView(),
          SettingsFinancesView(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text(getTextFAB()),
        icon: const Icon(Icons.add),
        onPressed: () async {
          switch (index) {
            case 0:
              Navigator.of(context).pushNamed(
                financesNewAccountMovementRoute,
                arguments: NewMovementRouteSettings(movementContext: context),
              );
              break;
            case 1:
              break;
            case 2:
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (_) => NewAccountWidget(
                  blocContext: context,
                ),
              );
              /* Navigator.of(context).pushNamed(
                financesNewAccountRoute,
                arguments: NewAccountRouteSettings(accountsContext: context),
              ); */
              break;
            case 3:
              final LabelEntity? result = await showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                elevation: 0,
                builder: (_) => const ModalNewTagWidget(
                  type: TypeLabels.finances,
                ),
              );

              if (result != null) bloc.add(AddLabelEvent(result));

              break;
          }
        },
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: index,
        onTap: (index) {
          setState(() {
            this.index = index;
          });
        },
        items: [
          SalomonBottomBarItem(
            icon: const Icon(CupertinoIcons.home),
            title: const Text('Inicio'),
            selectedColor: Theme.of(context).indicatorColor,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.attach_money_outlined),
            title: const Text('Balance'),
            selectedColor: Theme.of(context).indicatorColor,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.wallet),
            title: const Text('Cuentas'),
            selectedColor: Theme.of(context).indicatorColor,
          ),
          SalomonBottomBarItem(
            icon: const Icon(CupertinoIcons.tag),
            title: const Text('Categorías'),
            selectedColor: Theme.of(context).indicatorColor,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.settings),
            title: const Text('Config.'),
            selectedColor: Theme.of(context).indicatorColor,
          ),
        ],
      ),
    );
  }
}
