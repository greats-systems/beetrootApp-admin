import 'package:core_erp/controllers/auth/auth_controller.dart';
import 'package:core_erp/controllers/main_controller.dart';
import 'package:core_erp/models/http_responses.dart';
import 'package:core_erp/services/auth_service.dart';
import 'package:core_erp/views/auth/register.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get.dart';

class LoginController extends MainController {
  FxFormValidator basicValidator = FxFormValidator();
  late AuthController authController = Get.put(AuthController());
  bool showPassword = false, loading = false;

  final String _dummyEmail = "admin@umojaxc.io";
  final String _dummyPassword = "1234567";

  @override
  onInit() async {
    super.onInit();
    basicValidator.addField('email',
        required: true,
        label: "Email",
        validators: [FxEmailValidator()],
        controller: TextEditingController(text: _dummyEmail));

    basicValidator.addField('password',
        required: true,
        label: "Password",
        validators: [FxLengthValidator(min: 6)],
        controller: TextEditingController(text: _dummyPassword));
  }

  // UI
  void onChangeShowPassword() {
    showPassword = !showPassword;
    update();
  }

  // Services
  onLogin(LoginDTO loginDTO) async {
    debugPrint('onLogin Method loginDTO ${loginDTO.phone}');
    debugPrint('onLogin Method loginDTO ${loginDTO.email}');
    try {
      Map body;
      isLoading.value = true;
      if (loginDTO.email != null) {
        body = {
          "email": loginDTO.email,
          "password": loginDTO.password,
        };
      } else {
        body = {"phone": loginDTO.phone};
      }

      debugPrint('/authentication/signin apiUrl: $apiUrl');
      var response =
          await getConnect.post('${apiUrl}/authentication/login', body);
      debugPrint('/authentication/signin response: $response');
      if (response.body == null) {
        debugPrint('response.body == null');
        errorMessage.value = 'No connection, Check internet connection';
        isLoading.value = false;
      } else {
        debugPrint('response.body != null');

        ResponseBody responseBody = await processHttpResponse(response);
        if (responseBody.status == 200 && responseBody.data.isNotEmpty) {
          await authController.processUserData(responseBody);
        }
        if (responseBody.error == true || responseBody.status == 404) {
          serverError.value = true;
          errorMessage.value = responseBody.errorMessage!;
        }
        basicValidator.resetForm();
        isLoading(false);
        isLoading.value = false;
      }
    } catch (e) {
      isLoading(false);
      formErrors.value = true;
      formErrorMessage.value = 'Connection Error, Check Network connection.';
      debugPrint('onLogin error $e');
    }
  }

  // Navigation
  void goToForgotPassword() {
    Get.toNamed('/auth/forgot_password');
  }

  void gotoRegister() {
    debugPrint('gotoRegister');
    Get.to(RegisterPage());
  }

  @override
  String getTag() {
    return "login_controller";
  }
}
