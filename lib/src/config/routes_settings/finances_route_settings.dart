import 'package:flutter/widgets.dart';

import 'package:lubby_app/src/config/routes/routes.dart';

class NewAccountRouteSettings extends RouteSettings {
  final BuildContext accountsContext;

  const NewAccountRouteSettings({
    required this.accountsContext,
  }) : super(name: financesNewAccountRoute);
}

class NewMovementRouteSettings extends RouteSettings {
  final BuildContext movementContext;

  const NewMovementRouteSettings({
    required this.movementContext,
  }) : super(name: financesNewAccountRoute);
}
