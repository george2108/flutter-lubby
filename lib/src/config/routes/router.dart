import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../my_app.dart';
import '../../features/activities/activities/activities_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/config/config_page.dart';
import '../../features/diary/presentation/views/diary_main_page.dart';
import '../../features/finances/presentation/views/finances_main_page.dart';
import '../../features/habits/habits_main_page.dart';
import '../../features/notes/presentation/views/notes_main_page.dart';
import '../../features/passwords/presentation/views/password_view.dart';
import '../../features/passwords/presentation/views/passwords_main_page.dart';
import '../../features/qr_reader/qr_reader/qr_reader_page.dart';
import '../../features/remiders/presentation/views/reminders_main_page.dart';
import '../../features/routing_page.dart';
import '../../features/todos/presentation/views/todo_main_page.dart';
import 'routes.dart';

mixin RouterMixin on State<MyApp> {
  get router => _router;

  final _router = GoRouter(
    initialLocation: Routes().passwords.path,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: Routes().login.path,
        name: Routes().login.name,
        builder: (context, state) {
          return const LoginPage();
        },
      ),
      GoRoute(
        path: Routes().register.path,
        name: Routes().register.name,
        builder: (context, state) {
          return const RegisterPage();
        },
      ),
      // home
      ShellRoute(
        builder: (context, state, child) {
          return RoutingPage(child: child);
        },
        routes: [
          // passwords
          GoRoute(
            path: Routes().passwords.path,
            name: Routes().passwords.name,
            builder: (context, state) {
              return const PasswordsMainPage();
            },
            routes: [
              GoRoute(
                path: ':id',
                builder: (context, state) {
                  final id = state.pathParameters['id'];
                  return PasswordView(id: id!);
                },
              ),
            ],
          ),
          // notes
          GoRoute(
            path: Routes().notes.path,
            name: Routes().notes.name,
            builder: (context, state) {
              return const NotesMainPage();
            },
          ),
          // todos
          GoRoute(
            path: Routes().toDos.path,
            name: Routes().toDos.name,
            builder: (context, state) {
              return const TodoMainPage();
            },
          ),
          // agenda
          GoRoute(
            path: Routes().diary.path,
            name: Routes().diary.name,
            builder: (context, state) {
              return const DiaryMainPage();
            },
          ),
          // finances
          GoRoute(
            path: Routes().finances.path,
            name: Routes().finances.name,
            builder: (context, state) {
              return const FinancesMainPage();
            },
          ),
          // activities
          GoRoute(
            path: Routes().activities.path,
            name: Routes().activities.name,
            builder: (context, state) {
              return const ActivitiesPage();
            },
          ),
          // recordatorios
          GoRoute(
            path: Routes().reminders.path,
            name: Routes().reminders.name,
            builder: (context, state) {
              return const RemindersMainPage();
            },
          ),
          // qr
          GoRoute(
            path: Routes().qrReader.path,
            name: Routes().qrReader.name,
            builder: (context, state) {
              return const QRReaderPage();
            },
          ),
          // habits
          GoRoute(
            path: Routes().habits.path,
            name: Routes().habits.name,
            builder: (context, state) {
              return const HabitsMainPage();
            },
          ),
          // config
          GoRoute(
            path: Routes().config.path,
            name: Routes().config.name,
            builder: (context, state) {
              return const ConfigPage();
            },
          ),
        ],
      ),
    ],
  );
}
