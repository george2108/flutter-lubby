import 'package:get/get.dart';
import 'package:lubby_app/pages/passwords/password_controller.dart';
import 'package:lubby_app/services/password_service.dart';

class PasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(PasswordService());
    Get.put(PasswordController());
  }
}
