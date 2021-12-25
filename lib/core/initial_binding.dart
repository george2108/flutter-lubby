import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/instance_manager.dart';
import 'package:lubby_app/core/authentication/authentication_controller.dart';
import 'package:lubby_app/services/http_service.dart';
import 'package:lubby_app/services/shared_preferences_service.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(SharedPreferencesService());
    Get.put(HttpService());
    Get.put(AuthenticationController());
  }
}
