import 'package:flutter/widgets.dart';

import '../routes/routes.dart';
import '../../features/passwords/entities/password_entity.dart';

class PasswordRouteSettings extends RouteSettings {
  final BuildContext passwordContext;
  final PasswordEntity? password;

  const PasswordRouteSettings({
    required this.passwordContext,
    this.password,
  }) : super(name: passwordRoute);
}
