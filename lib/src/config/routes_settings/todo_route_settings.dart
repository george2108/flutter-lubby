import 'package:flutter/material.dart';
import 'package:lubby_app/src/config/routes/routes.dart';
import 'package:lubby_app/src/domain/entities/todo_entity.dart';

class TodoRouteSettings extends RouteSettings {
  final BuildContext todoContext;
  final ToDoEntity todo;

  const TodoRouteSettings({
    required this.todoContext,
    required this.todo,
  }) : super(name: toDoRoute);
}
