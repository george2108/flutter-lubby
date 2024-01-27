import '../../presentation/enum/type_filter_enum.dart';
import '../entities/todo_entity.dart';

abstract class ToDoRepositoryAbstract {
  Future<List<ToDoEntity>> getToDosLists({
    required TypeFilterEnum type,
    DateTime? fechaInicio,
    DateTime? fechaFin,
  });

  Future<List<ToDoDetailEntity>> getToDoDetails(int id);

  Future<int> addNewToDo(ToDoEntity toDoEntity);

  Future<int> updateToDoDetail(ToDoDetailEntity detailModel);

  Future<int> addNewToDoDetail(ToDoDetailEntity detailModel);

  Future<int> updateTodo(ToDoEntity todo);

  Future<void> updateOrderToDoDetails(List<ToDoDetailEntity> todosList);

  Future<int> deleteToDoDetail(int detailId);

  Future<List<ToDoDetailEntity>> getTasks({
    required DateTime fecha,
  });
}
