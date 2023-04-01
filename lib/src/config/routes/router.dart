import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

import 'package:lubby_app/src/config/routes/route_builder.dart';
import 'package:lubby_app/src/config/routes/routes.dart';
import 'package:lubby_app/src/config/routes_settings/note_route_settings.dart';
import 'package:lubby_app/src/config/routes_settings/todo_route_settings.dart';
import 'package:lubby_app/src/ui/pages/example/local_notifications_example_page.dart';
import 'package:lubby_app/src/ui/pages/finances/finances_main_page.dart';
import 'package:lubby_app/src/ui/pages/finances/views/new_account_view.dart';
import 'package:lubby_app/src/ui/pages/passwords/passwords_main_page.dart';
import 'package:lubby_app/src/ui/pages/passwords/views/password_view.dart';
import 'package:lubby_app/src/ui/pages/todos/todo_main_page.dart';
import 'package:lubby_app/src/ui/pages/todos/views/todo_page.dart';

import '../../ui/pages/notes/notes_main_page.dart';
import '../../ui/pages/notes/views/note_view.dart';
import '../routes_settings/new_acount_route_settings.dart';
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

    // todos
    case toDosRoute:
      page = const TodoMainPage();
      break;
    case toDoRoute:
      final todosSettings = settings.arguments as TodoRouteSettings;
      page = TodoPage(
        toDo: todosSettings.todo,
        todoContext: todosSettings.todoContext,
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
    case financesNewAccountRoute:
      final newAccountSettings = settings.arguments as NewAccountRouteSettings;
      page = NewAccountView(
        blocContext: newAccountSettings.accountsContext,
      );
      break;

    // Default
    default:
      page = const PasswordsMainPage();
  }

  return RouteBuilder.navigate(page, settings: settings);
}
