import 'package:sqflite/sqflite.dart';

import 'package:lubby_app/src/core/constants/db_tables_name_constants.dart';
import 'package:lubby_app/src/data/datasources/local/db/database_service.dart';
import 'package:lubby_app/src/data/models/todo_model.dart';

import '../../../../presentation/pages/todos/type_filter_enum.dart';

class TodosLocalService {
  static final TodosLocalService provider = TodosLocalService._internal();

  factory TodosLocalService() {
    return provider;
  }

  TodosLocalService._internal();

  Future<List<ToDoModel>> getTasks({
    required TypeFilterEnum type,
    DateTime? fechaInicio,
    DateTime? fechaFin,
  }) async {
    final db = await DatabaseProvider.db.database;
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
    List<Map<String, dynamic>> tasks = await db.query(
      kTodosTable,
      orderBy: "createdAt DESC",
      where: whereClause,
      whereArgs: whereArgs,
    );
    final resp = tasks.toList();

    List<ToDoModel> resultTasks = [];
    for (var i = 0; i < tasks.length; i++) {
      final task = Map<String, dynamic>.from(resp[i]);
      final taskModel = ToDoModel.fromMap(task);
      resultTasks.add(taskModel);
    }
    return resultTasks;
  }

  Future<List<ToDoDetailModel>> getTaskDetail(int id) async {
    final db = await DatabaseProvider.db.database;
    final detail = await db.query(
      kTodosDetailTable,
      orderBy: "orderDetail ASC",
      where: "toDoId = $id",
    );
    final resp = detail.toList();

    List<ToDoDetailModel> resultDetails = [];

    for (var i = 0; i < resp.length; i++) {
      final detail = Map<String, dynamic>.from(resp[i]);
      final detailModel = ToDoDetailModel.fromMap(detail);
      resultDetails.add(detailModel);
    }
    return resultDetails;
  }

  Future<int> addNewToDo(
    ToDoModel toDoModel,
  ) async {
    final db = await DatabaseProvider.db.database;
    return await db.insert(
      kTodosTable,
      toDoModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> updateDetailTask(ToDoDetailModel detailModel) async {
    final db = await DatabaseProvider.db.database;
    return await db.update(
      kTodosDetailTable,
      detailModel.toMap(),
      where: 'id = ?',
      whereArgs: [detailModel.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> addNewDetailTask(ToDoDetailModel detailModel) async {
    final db = await DatabaseProvider.db.database;
    return await db.insert(
      kTodosDetailTable,
      detailModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> updateTodo(
    ToDoModel todo,
  ) async {
    final db = await DatabaseProvider.db.database;
    return await db.update(kTodosTable, todo.toMap(), where: 'id = ${todo.id}');
  }

  updateOrderDetails(List<ToDoDetailModel> todosList) async {
    final db = await DatabaseProvider.db.database;
    for (var i = 0; i < todosList.length; i++) {
      final element = todosList[i];
      await db.rawUpdate(
        'UPDATE $kTodosDetailTable SET orderDetail = ? WHERE id = ?',
        [element.orderDetail, element.id],
      );
    }
  }

  Future<int> deleteDetail(int detailId) async {
    final db = await DatabaseProvider.db.database;
    return await db.rawDelete(
      "DELETE FROM $kTodosDetailTable WHERE id = ?",
      [detailId],
    );
  }
}
