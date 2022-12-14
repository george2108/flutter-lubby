import '../../data/entities/todo_entity.dart';
import '../../presentation/pages/todos/enum/type_filter_enum.dart';

abstract class ToDoRepository {
  Future<List<ToDoEntity>> getToDos({
    required TypeFilterEnum type,
    DateTime? fechaInicio,
    DateTime? fechaFin,
  });

  Future<List<ToDoDetailEntity>> getToDoDetail(int id);

  Future<int> addNewToDo(ToDoEntity toDoEntity);

  Future<int> updateToDoDetail(ToDoDetailEntity detailModel);

  Future<int> addNewToDoDetail(ToDoDetailEntity detailModel);

  Future<int> updateTodo(ToDoEntity todo);

  Future<void> updateOrderToDoDetails(List<ToDoDetailEntity> todosList);

  Future<int> deleteToDoDetail(int detailId);
}
