import 'package:sqflite/sqflite.dart';

import '../../../core/constants/db_tables_name_constants.dart';
import '../../../features/todos/domain/entities/todo_entity.dart';
import '../../../features/todos/presentation/enum/type_filter_enum.dart';
import 'database_service.dart';

class TodosLocalService {
  static final TodosLocalService provider = TodosLocalService._internal();

  factory TodosLocalService() {
    return provider;
  }

  TodosLocalService._internal();

  Future<List<ToDoEntity>> getToDosLists({
    required TypeFilterEnum type,
    DateTime? fechaInicio,
    DateTime? fechaFin,
  }) async {
    String whereClause = "complete = ? ";
    if (fechaInicio != null) {
      whereClause += "AND createdAt BETWEEN ? AND ?";
    }
    final whereArgs = fechaInicio != null
        ? [
            type == TypeFilterEnum.enProceso ? '0' : '1',
            '${fechaInicio.year.toString()}-${fechaInicio.month.toString().padLeft(2, '0')}-${fechaInicio.day.toString().padLeft(2, '0')} 00:00:00',
            '${fechaFin?.year.toString()}-${fechaFin?.month.toString().padLeft(2, '0')}-${fechaFin?.day.toString().padLeft(2, '0')} 23:59:59',
          ]
        : [
            type == TypeFilterEnum.enProceso ? '0' : '1',
          ];
    List<Map<String, dynamic>> tasks = await DatabaseService().find(
      kTodosTable,
      orderBy: "createdAt DESC",
      where: whereClause,
      whereArgs: whereArgs,
    );
    final resp = tasks.toList();

    List<ToDoEntity> resultTasks = [];
    for (var i = 0; i < tasks.length; i++) {
      final task = Map<String, dynamic>.from(resp[i]);
      final taskModel = ToDoEntity.fromMap(task);
      resultTasks.add(taskModel);
    }
    return resultTasks;
  }

  Future<List<ToDoDetailEntity>> getTasks({
    required DateTime fecha,
  }) async {
    List<Map<String, dynamic>> tasks = await DatabaseService().find(
      kTodosDetailTable,
      orderBy: "startDate DESC",
      where: 'startDate BETWEEN ? AND ?',
      whereArgs: [
        '${fecha.year.toString()}-${fecha.month.toString().padLeft(2, '0')}-${fecha.day.toString().padLeft(2, '0')} 00:00:00',
        '${fecha.year.toString()}-${fecha.month.toString().padLeft(2, '0')}-${fecha.day.toString().padLeft(2, '0')} 23:59:59',
      ],
    );
    final resp = tasks.toList();

    List<ToDoDetailEntity> resultTasks = [];
    for (var i = 0; i < tasks.length; i++) {
      final task = Map<String, dynamic>.from(resp[i]);
      final taskModel = ToDoDetailEntity.fromMap(task);
      resultTasks.add(taskModel);
    }
    return resultTasks;
  }

  Future<List<ToDoDetailEntity>> getTaskDetail(int id) async {
    final detail = await DatabaseService().find(
      kTodosDetailTable,
      orderBy: "orderDetail ASC",
      where: "toDoId = $id",
    );
    final resp = detail.toList();

    List<ToDoDetailEntity> resultDetails = [];

    for (var i = 0; i < resp.length; i++) {
      final detail = Map<String, dynamic>.from(resp[i]);
      final detailModel = ToDoDetailEntity.fromMap(detail);
      resultDetails.add(detailModel);
    }
    return resultDetails;
  }

  Future<int> addNewToDo(
    ToDoEntity toDoEntity,
  ) async {
    return await DatabaseService().save(
      kTodosTable,
      toDoEntity.toMap(),
    );
  }

  Future<int> updateDetailTask(ToDoDetailEntity detailModel) async {
    return await DatabaseService().update(
      kTodosDetailTable,
      detailModel.toMap(),
      where: 'id = ?',
      whereArgs: [detailModel.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> addNewDetailTask(ToDoDetailEntity detailModel) async {
    return await DatabaseService().save(
      kTodosDetailTable,
      detailModel.toMap(),
    );
  }

  Future<int> updateTodo(
    ToDoEntity todo,
  ) async {
    return await DatabaseService().update(
      kTodosTable,
      todo.toMap(),
      where: 'id = ${todo.id}',
    );
  }

  updateOrderDetails(List<ToDoDetailEntity> todosList) async {
    for (var i = 0; i < todosList.length; i++) {
      final element = todosList[i];
      await DatabaseService().rawUpdate(
        'UPDATE $kTodosDetailTable SET orderDetail = ? WHERE id = ?',
        [element.orderDetail, element.id],
      );
    }
  }
}
