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
    this._tasks = [];
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
    this._tasks = toDos;
    loading = false;
  }

  Future<void> saveToDo(ToDoModel todo) async {
    /* ToDoModel toDo = ToDoModel(
      title: tituloController.text.toString(),
      description: descriptionController.text.toString(),
      complete: 0,
      createdAt: DateTime.now(),
    ); */
    await DatabaseProvider.db.addNewToDo(todo, items);
    // Get.offNamedUntil('/todo', (route) => false);
  }
}
