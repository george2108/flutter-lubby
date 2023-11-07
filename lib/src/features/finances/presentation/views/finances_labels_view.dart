import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lubby_app/src/core/enums/type_labels.enum.dart';
import 'package:lubby_app/src/features/finances/presentation/bloc/finances_bloc.dart';

class FinancesLabelsView extends StatefulWidget {
  const FinancesLabelsView({super.key});
  @override
  State<FinancesLabelsView> createState() => _FinancesLabelsViewState();
}

class _FinancesLabelsViewState extends State<FinancesLabelsView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Depositos'),
              Tab(text: 'Gastos'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                getData(TypeLabels.income),
                getData(TypeLabels.expense),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getData(TypeLabels type) {
    return BlocBuilder<FinancesBloc, FinancesState>(
      builder: (context, state) {
        final categories = state.categories
            .where((element) => element.type == type.name)
            .toList();

        if (categories.isEmpty) {
          return const Center(
            child: Text('No hay categorías'),
          );
        }

        return ListView.separated(
          separatorBuilder: (context, index) => const Divider(),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return ListTile(
              style: ListTileStyle.drawer,
              leading: CircleAvatar(
                backgroundColor: category.color,
                child: Icon(
                  category.icon,
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
              ),
              title: Text(category.name),
              onTap: () {},
            );
          },
        );
      },
    );
  }
}
