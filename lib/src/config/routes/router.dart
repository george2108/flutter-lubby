import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

import 'route_builder.dart';
import 'routes.dart';
import '../routes_settings/note_route_settings.dart';
import '../routes_settings/todo_route_settings.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/example/local_notifications_example_page.dart';
import '../../features/finances/presentation/views/finances_main_page.dart';
import '../../features/finances/presentation/views/transaction_detail_view.dart';
import '../../features/passwords/presentation/views/passwords_main_page.dart';
import '../../features/passwords/presentation/views/password_view.dart';
import '../../features/todos/presentation/views/todo_main_page.dart';
import '../../features/todos/presentation/views/todo_page.dart';

import '../../features/notes/presentation/views/notes_main_page.dart';
import '../../features/notes/presentation/views/note_view.dart';
import '../routes_settings/finances_route_settings.dart';
import '../routes_settings/password_route_settings.dart';

Route<dynamic> generateRoutes(RouteSettings settings) {
  Widget page;
  switch (settings.name) {
    // auth
    case loginRoute:
      page = const LoginPage();
      break;
    case registerRoute:
      page = const RegisterPage();
      break;

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
      final financesSettings = settings.arguments as ViewAccountRouteSettings;
      page = AcountView(
        financesContext: financesSettings.financesContext,
        account: financesSettings.account,
      );
      break;
    case financesNewAccountMovementRoute:
      final newMovementSettings =
          settings.arguments as NewMovementRouteSettings;
      page = NewAccountMovementView(
        blocContext: newMovementSettings.movementContext,
      );
      break;
    case financesTransactionDetailRoute:
      final movementDetailSettings =
          settings.arguments as TransactionRouteSettings;
      page = TransactionDetailView(
        transaction: movementDetailSettings.transaction,
      );
      break;

    // Default
    default:
      page = const PasswordsMainPage();
  }

  return RouteBuilder.navigate(page, settings: settings);
}
