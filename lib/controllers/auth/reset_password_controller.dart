import 'package:core_erp/controllers/main_controller.dart';
import 'package:core_erp/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get.dart';

class ResetPasswordController extends MainController {
  FxFormValidator basicValidator = FxFormValidator();

  bool showPassword = false, loading = false;

  bool confirmPassword = false;

  @override
  onInit() async {
    super.onInit();
    basicValidator.addField(
      'password',
      required: true,
      validators: [
        FxLengthValidator(min: 6, max: 10),
      ],
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'confirm_password',
      required: true,
      label: "Confirm password",
      validators: [
        FxLengthValidator(min: 6, max: 10),
      ],
      controller: TextEditingController(),
    );
  }

  Future<void> onLogin() async {
    if (basicValidator.validateForm()) {
      loading = true;
      update();
      var errors = await AuthService.loginUser(basicValidator.getData());
      if (errors != null) {
        basicValidator.addErrors(errors);
        basicValidator.validateForm();
        basicValidator.clearErrors();
      }
      Get.toNamed('/starter');
      loading = false;
      update();
    }
  }

  void onChangeShowPassword() {
    showPassword = !showPassword;
    update();
  }

  void onResetPasswordPassword() {
    confirmPassword = !confirmPassword;
    update();
  }

  @override
  String getTag() {
    return "reset_password";
  }
}
