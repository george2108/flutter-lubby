import 'package:get/instance_manager.dart';
import 'package:lubby_app/pages/auth/login/login_controller.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}
