import '../../../../core/constants/db_tables_name_constants.dart';
import '../../../../data/datasources/local/database_service.dart';
import '../../domain/entities/todo_entity.dart';
import '../../domain/repositories/todo_repository_abstract.dart';
import '../../presentation/enum/type_filter_enum.dart';

class TodoRepository extends ToDoRepositoryAbstract {
  @override
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

  @override
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

  @override
  Future<List<ToDoDetailEntity>> getToDoDetails(int id) async {
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

  @override
  Future<int> addNewToDo(
    ToDoEntity toDoEntity,
  ) async {
    return await DatabaseService().save(
      kTodosTable,
      toDoEntity.toMap(),
    );
  }

  @override
  Future<int> updateToDoDetail(ToDoDetailEntity detailModel) async {
    return await DatabaseService().update(
      kTodosDetailTable,
      detailModel.toMap(),
      where: 'id = ?',
      whereArgs: [detailModel.id],
    );
  }

  @override
  Future<int> addNewToDoDetail(ToDoDetailEntity detailModel) async {
    return await DatabaseService().save(
      kTodosDetailTable,
      detailModel.toMap(),
    );
  }

  @override
  Future<int> updateTodo(
    ToDoEntity todo,
  ) async {
    return await DatabaseService().update(
      kTodosTable,
      todo.toMap(),
      where: 'id = ${todo.id}',
    );
  }

  @override
  updateOrderToDoDetails(List<ToDoDetailEntity> todosList) async {
    for (var i = 0; i < todosList.length; i++) {
      final element = todosList[i];
      await DatabaseService().rawUpdate(
        'UPDATE $kTodosDetailTable SET orderDetail = ? WHERE id = ?',
        [element.orderDetail, element.id],
      );
    }
  }

  @override
  Future<int> deleteToDoDetail(int detailId) async {
    return await DatabaseService().rawDelete(
      "DELETE FROM $kTodosDetailTable WHERE id = ?",
      [detailId],
    );
  }
}
