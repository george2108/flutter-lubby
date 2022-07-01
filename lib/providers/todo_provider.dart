import 'package:flutter/widgets.dart';
import 'package:lubby_app/db/database_provider.dart';
import 'package:lubby_app/models/todo_model.dart';
import 'package:lubby_app/pages/todo/type_filter_enum.dart';

class ToDoProvider with ChangeNotifier {
  List<ToDoModel> _tasks = [];

  // filtros de tareas
  List<String> filters = [
    TypeFilter.enProceso.name,
    TypeFilter.completado.name,
  ];
  String currentFilter = TypeFilter.enProceso.name;

  bool loading = false;

  final List<ToDoDetailModel> items = [];

  List<ToDoModel> get tasks => _tasks;

  void resetProvider() {
    currentFilter = TypeFilter.enProceso.name;
    this.loading = false;
    this.items.clear();
  }

  void changeFilter(String value) {
    currentFilter = value;
    final filter =
        value == filters[0] ? TypeFilter.enProceso : TypeFilter.completado;
    this.getTasks(filter: filter);
    notifyListeners();
  }

  void removeTaskFromTasks(int index) {
    this.items.removeAt(index);
    notifyListeners();
  }

  /**
   * Marcar una tarea como completada
   */
  void checkTask(int index, bool value) {
    this.items[index].complete =
        value ? this.items[index].complete = 1 : this.items[index].complete = 0;
    notifyListeners();
  }

  Future<void> getTasks({
    required TypeFilter filter,
    DateTime? fechaInicio,
    DateTime? fechaFin,
  }) async {
    loading = true;
    List<ToDoModel> toDos;
    if (fechaInicio != null) {
      toDos = await DatabaseProvider.db.getTasks(
        type: filter,
        fechaInicio: fechaInicio,
        fechaFin: fechaFin,
      );
    } else {
      toDos = await DatabaseProvider.db.getTasks(type: filter);
    }
    print(toDos.length > 0 ? toDos[0] : 's');
    this._tasks = toDos;
    loading = false;
  }

  Future<void> saveToDo(ToDoModel todo) async {
    final idToDo = await DatabaseProvider.db.addNewToDo(todo);
    for (var i = 0; i < items.length; i++) {
      final item = items[i];
      item.toDoId = idToDo;
      await DatabaseProvider.db.addNewDetailTask(item);
    }
    this._tasks.add(todo);
    this.resetProvider();
    notifyListeners();
  }
}
