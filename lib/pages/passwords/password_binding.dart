import 'package:get/get.dart';
import 'package:lubby_app/pages/passwords/password_controller.dart';
import 'package:lubby_app/providers/password_provider.dart';

class PasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(PasswordProvider());
    Get.put(PasswordController());
  }
}
