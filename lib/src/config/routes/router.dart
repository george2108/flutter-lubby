import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:lubby_app/src/config/routes/route_builder.dart';
import 'package:lubby_app/src/config/routes/routes.dart';
import 'package:lubby_app/src/ui/pages/example/local_notifications_example_page.dart';
import 'package:lubby_app/src/ui/pages/finances/finances_main_page.dart';
import 'package:lubby_app/src/ui/pages/passwords/passwords/passwords_page.dart';

import '../../ui/pages/passwords/password/password_page.dart';

Route<dynamic> generateRoutes(RouteSettings settings) {
  switch (settings.name) {
    // Passwords
    case passwordsRoute:
      return RouteBuilder.navigate(const PasswordsPage());
    case passwordRoute:
      final arguments = settings.arguments as BuildContext;
      return RouteBuilder.navigate(PasswordPage(passwordsContext: arguments));

    // Reminders
    case remindersRoute:
      return RouteBuilder.navigate(const LocalNotificationsExamplePage());

    // Finances
    case financesAccountRoute:
      return RouteBuilder.navigate(const AcountView());
    case financesNewAccountMovementRoute:
      return RouteBuilder.navigate(const NewAccountMovementView());

    // Default
    default:
      return RouteBuilder.navigate(const PasswordsPage());
  }
}
