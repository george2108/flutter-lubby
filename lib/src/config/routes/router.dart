import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:lubby_app/src/config/routes/route_builder.dart';
import 'package:lubby_app/src/config/routes/routes.dart';
import 'package:lubby_app/src/presentation/pages/passwords/passwords/passwords_page.dart';

Route<dynamic> generateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case passwordsRoute:
      return RouteBuilder.navigate(const PasswordsPage());
    default:
      return RouteBuilder.navigate(const PasswordsPage());
  }
}
