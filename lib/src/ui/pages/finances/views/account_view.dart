part of '../finances_main_page.dart';

class AcountView extends StatefulWidget {
  final AccountEntity account;
  final BuildContext financesContext;

  const AcountView({
    super.key,
    required this.account,
    required this.financesContext,
  });

  @override
  State<AcountView> createState() => _AcountViewState();
}

class _AcountViewState extends State<AcountView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.medium(
            title: Text(
              widget.account.name,
              style: TextStyle(
                color: getContrastingTextColor(widget.account.color),
              ),
            ),
            backgroundColor: widget.account.color,
            pinned: true,
            automaticallyImplyLeading: false,
            leading: BackButton(
              color: getContrastingTextColor(widget.account.color),
            ),
            surfaceTintColor: widget.account.color,
            actions: [
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: getContrastingTextColor(widget.account.color),
                ),
                onPressed: () {},
              ),
            ],
          ),
          SliverPersistentHeader(
            delegate: AccountHeaderDelegate(account: widget.account),
            pinned: true,
          ),
          SliverPersistentHeader(
            delegate: AccountTabHeaderDelegate(tabController: _tabController),
            pinned: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              List.generate(
                15,
                (index) => ListTile(
                  title: Text('Movimiento $index'),
                  subtitle: Text('Subtitulo $index'),
                  trailing: const Text('500.00'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
