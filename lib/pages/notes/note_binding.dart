import 'package:get/get.dart';
import 'package:lubby_app/pages/notes/note_controller.dart';

class NoteBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(NoteController());
  }
}
