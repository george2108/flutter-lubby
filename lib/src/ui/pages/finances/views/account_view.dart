part of '../finances_main_page.dart';

class AcountView extends StatelessWidget {
  const AcountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.medium(
            title: const Text('Tarjeta de debito'),
            backgroundColor: Colors.blueAccent,
            pinned: true,
            surfaceTintColor: Colors.blueAccent,
          ),
          SliverPersistentHeader(
            delegate: _HeaderDelegate(),
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: Text(
                'Movimientos bancarios',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              List.generate(
                15,
                (index) => Text('Item $index'),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 1000,
              color: Theme.of(context).canvasColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderDelegate extends SliverPersistentHeaderDelegate {
  final _maxHeaderExtend = 250.0;
  final _minHeaderExtend = 110.0;

  final _heightActionBottom = 60.0;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final size = MediaQuery.of(context).size;

    final percent = shrinkOffset / _maxHeaderExtend;

    return Stack(
      children: [
        Container(
          color: Colors.blueAccent,
        ),
        Positioned(
          right: 0,
          left: 0,
          top: 0,
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: 1),
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeIn,
            builder: (context, double value, child) {
              return Opacity(
                opacity: value,
                child: child,
              );
            },
            child: Column(
              children: const [
                Text(
                  '\$450',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 0,
          left: 0,
          top: 50,
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: 1),
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeIn,
            builder: (context, double value, child) {
              return Opacity(
                opacity: value,
                child: child,
              );
            },
            child: Opacity(
              opacity: 1 - percent,
              child: Column(
                children: const [
                  CircleAvatar(
                    backgroundColor: Colors.amber,
                    child: Icon(Icons.ac_unit),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Transform.translate(
            offset: const Offset(0, 1),
            child: Container(
              height: _heightActionBottom,
              width: size.width,
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40 * (1 - percent)),
                  topRight: Radius.circular(40 * (1 - percent)),
                ),
              ),
            ),
          ),
        ),
        _ActionButtons(
          heightActionBottom: _heightActionBottom,
          percent: percent,
        ),
      ],
    );
  }

  @override
  double get maxExtent => _maxHeaderExtend;

  @override
  double get minExtent => _minHeaderExtend;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}

class _ActionButtons extends StatelessWidget {
  final double _heightActionBottom;
  final double percent;

  const _ActionButtons({
    Key? key,
    required double heightActionBottom,
    required this.percent,
  })  : _heightActionBottom = heightActionBottom,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      left: 0,
      bottom: _heightActionBottom * (1 - percent) + 10,
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 0, end: 1),
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeIn,
        builder: (context, double value, child) {
          return Transform.translate(
            offset: Offset(0, 70 * (1 - value)),
            child: child,
          );
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Opacity(
                  opacity: 1 - percent,
                  child: const Text('Nuevo ingreso'),
                ),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).highlightColor,
                  ),
                  child: const Icon(CupertinoIcons.hand_thumbsup),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Opacity(
                  opacity: 1 - percent,
                  child: const Text('nuevo gasto'),
                ),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).highlightColor,
                  ),
                  child: const Icon(CupertinoIcons.hand_thumbsdown),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Opacity(
                  opacity: 1 - percent,
                  child: const Text('Nueva transf.'),
                ),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).highlightColor,
                  ),
                  child: const Icon(CupertinoIcons.arrowshape_turn_up_right),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
