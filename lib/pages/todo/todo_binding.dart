import 'package:get/get.dart';
import 'package:lubby_app/pages/todo/todo_controller.dart';

class ToDoBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ToDoController());
  }
}
