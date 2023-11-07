import 'package:flutter/widgets.dart';

import 'package:lubby_app/src/config/routes/routes.dart';
import 'package:lubby_app/src/features/passwords/domain/entities/password_entity.dart';

class PasswordRouteSettings extends RouteSettings {
  final BuildContext passwordContext;
  final PasswordEntity? password;

  const PasswordRouteSettings({
    required this.passwordContext,
    this.password,
  }) : super(name: passwordRoute);
}
