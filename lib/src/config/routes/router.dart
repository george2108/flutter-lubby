import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

import 'package:lubby_app/src/config/routes/route_builder.dart';
import 'package:lubby_app/src/config/routes/routes.dart';
import 'package:lubby_app/src/config/routes_settings/note_route_settings.dart';
import 'package:lubby_app/src/ui/pages/example/local_notifications_example_page.dart';
import 'package:lubby_app/src/ui/pages/finances/finances_main_page.dart';
import 'package:lubby_app/src/ui/pages/passwords/passwords_main_page.dart';
import 'package:lubby_app/src/ui/pages/passwords/views/password_view.dart';

import '../../ui/pages/notes/notes_main_page.dart';
import '../../ui/pages/notes/views/note_view.dart';
import '../routes_settings/password_route_settings.dart';

Route<dynamic> generateRoutes(RouteSettings settings) {
  Widget page;
  switch (settings.name) {
    // Passwords
    case passwordsRoute:
      page = const PasswordsMainPage();
      break;
    case passwordRoute:
      final settingsPassword = settings.arguments as PasswordRouteSettings;
      page = PasswordView(
        passwordContext: settingsPassword.passwordContext,
        password: settingsPassword.password,
      );
      break;

    // notes
    case notesRoute:
      page = const NotesMainPage();
      break;
    case noteRoute:
      final notesSettings = settings.arguments as NoteRouteSettings;
      page = NoteView(
        notesContext: notesSettings.notesContext,
        note: notesSettings.note,
      );
      break;

    // Reminders
    case remindersRoute:
      page = const LocalNotificationsExamplePage();
      break;

    // Finances
    case financesAccountRoute:
      page = const AcountView();
      break;
    case financesNewAccountMovementRoute:
      page = const NewAccountMovementView();
      break;

    // Default
    default:
      page = const PasswordsMainPage();
  }

  return RouteBuilder.navigate(page, settings: settings);
}
