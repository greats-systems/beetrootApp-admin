import 'package:core_erp/controllers/main_controller.dart';
import 'package:core_erp/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends MainController {
  FxFormValidator basicValidator = FxFormValidator();
  bool showPassword = false, loading = false;

  @override
  onInit() async {
    super.onInit();
    basicValidator.addField(
      'email',
      required: true,
      label: "Email",
      validators: [FxEmailValidator()],
      controller: TextEditingController(),
    );
  }

  Future<void> onLogin() async {
    if (basicValidator.validateForm()) {
      loading = true;
      update();
      var errors = await AuthService.loginUser(basicValidator.getData());
      if (errors != null) {
        basicValidator.validateForm();
        basicValidator.clearErrors();
      }
      Get.toNamed('/auth/reset_password');
      loading = false;
      update();
    }
  }

  void gotoLogIn() {
    Get.toNamed('/auth/login');
  }

  @override
  String getTag() {
    return "forgot_password";
  }
}
