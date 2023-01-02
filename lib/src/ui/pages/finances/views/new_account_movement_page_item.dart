part of '../finances_main_page.dart';

class NewAccountMovementPageItem extends StatefulWidget {
  const NewAccountMovementPageItem({super.key});
  @override
  State<NewAccountMovementPageItem> createState() =>
      _NewAccountMovementPageItemState();
}

class _NewAccountMovementPageItemState extends State<NewAccountMovementPageItem>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo movimiento'),
      ),
      body: ListView(
        children: [
          TabBar(
            controller: TabController(length: 3, vsync: this),
            tabs: [
              Tab(
                text: 'Depósito',
                icon: Icon(
                  Icons.trending_up,
                ),
                iconMargin: EdgeInsets.zero,
              ),
              Tab(
                text: 'Retiro',
                iconMargin: EdgeInsets.zero,
                icon: Icon(
                  Icons.trending_down,
                ),
              ),
              Tab(
                iconMargin: EdgeInsets.zero,
                text: 'Transferencia',
                icon: Icon(
                  Icons.change_circle_outlined,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),
                      color: Colors.transparent,
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(10),
                      ),
                    ),
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.trending_down),
                        Text('Retiro'),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      border: Border.all(
                        color: Colors.white,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.trending_up),
                        Text('Déposito'),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),
                      color: Colors.transparent,
                      borderRadius: BorderRadius.horizontal(
                        right: Radius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.change_circle_outlined),
                        Text('Transferencia'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
