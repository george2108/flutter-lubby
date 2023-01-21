part of '../finances_main_page.dart';

class AcountView extends StatelessWidget {
  const AcountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: _HeaderDelegate(),
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
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
  final _maxHeaderExtend = 320.0;
  final _minHeaderExtend = 180.0;

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
          child: SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    const SizedBox(width: 10),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color:
                            Theme.of(context).backgroundColor.withOpacity(0.5),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(50),
                        ),
                      ),
                      child: const BackButton(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 0,
          left: 0,
          top: 70,
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
          top: 120,
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
        Positioned(
          left: 70,
          top: 40,
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: 1),
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeIn,
            builder: (context, double value, child) {
              return Transform.translate(
                offset: Offset(50 * (1 - value), 0),
                child: child,
              );
            },
            child: LayoutBuilder(
              builder: (_, p1) {
                print(p1.maxWidth);
                return Column(
                  children: const [
                    Text(
                      'Tarjeta de debito',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                );
              },
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
                  child: const Text('Ingreso'),
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
                  child: const Text('Gasto'),
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
                  child: const Text('Transf.'),
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
