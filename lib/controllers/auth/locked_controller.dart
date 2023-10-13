import 'package:core_erp/controllers/main_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get.dart';

class LockedController extends MainController {
  FxFormValidator basicValidator = FxFormValidator();

  bool showPassword = false, loading = false;

  @override
  onInit() async {
    super.onInit();

    basicValidator.addField(
      'password',
      required: true,
      label: 'Password',
      validators: [FxLengthValidator(min: 6, max: 10)],
      controller: TextEditingController(),
    );
  }

  void onShowPassword() {
    showPassword = !showPassword;
    update();
  }

  // Services
  Future<void> onLock() async {
    if (basicValidator.validateForm()) {
      loading = true;
      update();
      await Future.delayed(Duration(seconds: 1));
      Get.toNamed('/dashboard');

      loading = false;
      update();
    }
  }

  @override
  String getTag() {
    return "locked_controller";
  }
}
