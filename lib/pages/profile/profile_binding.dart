import 'package:get/instance_manager.dart';
import 'package:lubby_app/pages/profile/profile_controller.dart';

class ProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController());
  }
}
