import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../my_app.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/notes/presentation/views/notes_main_page.dart';
import '../../features/passwords/presentation/views/passwords_main_page.dart';
import '../../features/routing_page.dart';
import 'routes.dart';

mixin RouterMixin on State<MyApp> {
  get router => _router;

  final _router = GoRouter(
    initialLocation: Routes().passwords.path,
    debugLogDiagnostics: true,
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return RoutingPage(child: child);
        },
        routes: [
          GoRoute(
            path: Routes().passwords.path,
            name: Routes().passwords.name,
            builder: (context, state) {
              return const PasswordsMainPage();
            },
          ),
          GoRoute(
            path: Routes().notes.path,
            name: Routes().notes.name,
            builder: (context, state) {
              return const NotesMainPage();
            },
          ),
        ],
      ),
      GoRoute(
        path: Routes().login.path,
        name: Routes().login.name,
        builder: (context, state) {
          return const LoginPage();
        },
      ),
    ],
  );
}
