import 'package:get/get.dart';
import 'package:lubby_app/models/password_model.dart';

class PasswordController extends GetxController {
  final RxInt id = 0.obs;
  final RxString title = ''.obs;
  final RxString user = ''.obs;
  final RxString password = ''.obs;
  final RxString description = ''.obs;

  List<PasswordModel> _passwords = [];

  setPasswords(List<PasswordModel> passwords) {
    this._passwords = passwords;
  }

  get passwords => this._passwords;
}
