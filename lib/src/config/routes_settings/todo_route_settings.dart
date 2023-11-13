import 'package:flutter/material.dart';

import '../routes/routes.dart';
import '../../features/todos/domain/entities/todo_entity.dart';

class TodoRouteSettings extends RouteSettings {
  final BuildContext todoContext;
  final ToDoEntity todo;

  const TodoRouteSettings({
    required this.todoContext,
    required this.todo,
  }) : super(name: toDoRoute);
}
