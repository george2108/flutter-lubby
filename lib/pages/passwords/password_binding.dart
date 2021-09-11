import 'package:get/get.dart';
import 'package:lubby_app/pages/passwords/password_controller.dart';

class PasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(PasswordController());
  }
}
