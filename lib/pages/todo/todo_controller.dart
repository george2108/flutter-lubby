import 'package:get/get.dart';
import 'package:lubby_app/db/database_provider.dart';
import 'package:lubby_app/models/todo_model.dart';
import 'package:lubby_app/pages/todo/type_filter_enum.dart';

class ToDoController extends GetxController {
  ToDoController() {
    this.filters = ['En proceso', 'Finalizadas'];
    this.currentFilter.value = filters[0];
  }
  List<ToDoModel> _tasks = [];

  // filtros de tareas
  List<String> filters = [];
  RxString currentFilter = ''.obs;

  RxBool validTitulo = false.obs;
  RxBool validDescription = false.obs;

  RxBool loading = false.obs;

  List<ToDoModel> get tasks => _tasks;

  void changeFilter(String value) {
    currentFilter.value = value;
    final filter =
        value == filters[0] ? TypeFilter.enProceso : TypeFilter.completado;
    this.getTasks(filter);
  }

  Future<void> getTasks(TypeFilter filter) async {
    loading.value = true;
    final toDos = await DatabaseProvider.db.getTasks(filter);
    this._tasks = toDos;
    loading.value = false;
  }
}
