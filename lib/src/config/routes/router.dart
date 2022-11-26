import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:lubby_app/src/config/routes/route_builder.dart';
import 'package:lubby_app/src/config/routes/routes.dart';
import 'package:lubby_app/src/presentation/pages/passwords/passwords/passwords_page.dart';

import '../../presentation/pages/passwords/password/password_page.dart';

Route<dynamic> generateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case passwordsRoute:
      return RouteBuilder.navigate(const PasswordsPage());
    case passwordRoute:
      final arguments = settings.arguments as BuildContext;
      return RouteBuilder.navigate(PasswordPage(passwordsContext: arguments));
    default:
      return RouteBuilder.navigate(const PasswordsPage());
  }
}
