import '../../data/models/todo_model.dart';
import '../../presentation/pages/todos/enum/type_filter_enum.dart';

abstract class ToDoRepository {
  Future<List<ToDoModel>> getToDos({
    required TypeFilterEnum type,
    DateTime? fechaInicio,
    DateTime? fechaFin,
  });

  Future<List<ToDoDetailModel>> getToDoDetail(int id);

  Future<int> addNewToDo(ToDoModel toDoModel);

  Future<int> updateToDoDetail(ToDoDetailModel detailModel);

  Future<int> addNewToDoDetail(ToDoDetailModel detailModel);

  Future<int> updateTodo(ToDoModel todo);

  Future<void> updateOrderToDoDetails(List<ToDoDetailModel> todosList);

  Future<int> deleteToDoDetail(int detailId);
}
