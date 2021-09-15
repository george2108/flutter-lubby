import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/instance_manager.dart';
import 'package:lubby_app/pages/auth_local/auth_local_controller.dart';

class AuthLocalBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthLocalController());
  }
}
