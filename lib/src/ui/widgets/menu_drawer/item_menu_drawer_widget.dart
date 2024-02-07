import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../config/routes/routes.dart';
import '../../bloc/navigation/navigation_bloc.dart';

BorderRadius borderRadius = BorderRadius.circular(10);

class ItemMenuDrawerWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final IRoute route;
  final Widget? pageWidget;
  final String navigationString;

  final double margin = 6;

  const ItemMenuDrawerWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.route,
    required this.navigationString,
    this.pageWidget,
  });

  @override
  Widget build(BuildContext context) {
    final navigationBloc = BlocProvider.of<NavigationBloc>(
      context,
      listen: false,
    );

    return BlocBuilder<NavigationBloc, String>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: margin,
            vertical: margin / 2,
          ),
          child: InkWell(
            borderRadius: borderRadius,
            onTap: () {
              if (state == navigationString) return;

              navigationBloc.add(ChangeNavigationEvent(item: navigationString));

              context.go(route.path);
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: state == navigationString
                    ? Theme.of(context).highlightColor
                    : Colors.transparent,
                borderRadius: borderRadius,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(icon),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Icon(Icons.chevron_right)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
