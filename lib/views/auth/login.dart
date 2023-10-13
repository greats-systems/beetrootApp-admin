import 'package:core_erp/controllers/auth/auth_controller.dart';
import 'package:core_erp/controllers/auth/login_controller.dart';
import 'package:core_erp/extensions/extensions.dart';
import 'package:core_erp/models/http_responses.dart';
import 'package:core_erp/utils/mixins/ui_mixin.dart';
import 'package:core_erp/views/layouts/auth_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin, UIMixin {
  late LoginController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(LoginController());
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
        child: GetBuilder<LoginController>(
            init: controller,
            builder: (controller) {
              return Padding(
                padding: FxSpacing.all(flexSpacing),
                child: Form(
                  key: controller.basicValidator.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                          child: FxText.titleLarge(
                        "login".tr(),
                        fontWeight: 700,
                      )),
                      FxSpacing.height(4),
                      Obx(() => controller.serverError.value == true
                          ? Center(
                              child: FxText.bodySmall(
                              "${controller.errorMessage.value}".tr(),
                              muted: true,
                              color: Colors.red,
                              fontWeight: 3,
                            ))
                          : Center(
                              child: FxText.bodySmall(
                              "provide_email_and_password_to_access_admin_panel"
                                  .tr(),
                              muted: true,
                            ))),
                      FxSpacing.height(64),
                      FxText.labelMedium(
                        "email_address".tr().capitalizeWords,
                      ),
                      FxSpacing.height(8),
                      TextFormField(
                        validator:
                            controller.basicValidator.getValidation('email'),
                        controller:
                            controller.basicValidator.getController('email'),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: "Email Address",
                            labelStyle: FxTextStyle.bodySmall(xMuted: true),
                            border: outlineInputBorder,
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              size: 20,
                            ),
                            contentPadding: FxSpacing.all(16),
                            isCollapsed: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never),
                      ),
                      FxSpacing.height(16),
                      FxText.labelMedium(
                        "password".tr(),
                      ),
                      FxSpacing.height(8),
                      TextFormField(
                        validator:
                            controller.basicValidator.getValidation('password'),
                        controller:
                            controller.basicValidator.getController('password'),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: !controller.showPassword,
                        decoration: InputDecoration(
                            labelText: "Password",
                            labelStyle: FxTextStyle.bodySmall(xMuted: true),
                            border: outlineInputBorder,
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              size: 20,
                            ),
                            suffixIcon: InkWell(
                              onTap: controller.onChangeShowPassword,
                              child: Icon(
                                controller.showPassword
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                size: 20,
                              ),
                            ),
                            contentPadding: FxSpacing.all(16),
                            isCollapsed: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: FxButton.text(
                          onPressed: controller.goToForgotPassword,
                          elevation: 0,
                          padding: FxSpacing.xy(8, 0),
                          splashColor: contentTheme.secondary.withOpacity(0.1),
                          child: FxText.labelSmall(
                            'forgot_password?'.tr().capitalizeWords,
                            color: contentTheme.secondary,
                          ),
                        ),
                      ),
                      FxSpacing.height(28),
                      Center(
                        child: FxButton.rounded(
                          onPressed: () {
                            if (controller.basicValidator.validateForm()) {
                              var valData = controller.basicValidator.getData();
                              var email = valData['email'];
                              var password = valData['password'];
                              LoginDTO loginDTO =
                                  LoginDTO(email: email, password: password);
                              controller.onLogin(loginDTO);
                            }
                          },
                          elevation: 0,
                          padding: FxSpacing.xy(20, 16),
                          backgroundColor: contentTheme.primary,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              controller.loading
                                  ? SizedBox(
                                      height: 14,
                                      width: 14,
                                      child: CircularProgressIndicator(
                                        color: colorScheme.onPrimary,
                                        strokeWidth: 1.2,
                                      ),
                                    )
                                  : Container(),
                              if (controller.loading) FxSpacing.width(16),
                              FxText.bodySmall(
                                'login'.tr(),
                                color: contentTheme.onPrimary,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Center(
                        child: FxButton.text(
                          onPressed: () {
                            controller.gotoRegister();
                          },
                          elevation: 0,
                          padding: FxSpacing.x(16),
                          splashColor: contentTheme.secondary.withOpacity(0.1),
                          child: FxText.labelMedium(
                            'i_haven_t_account'.tr(),
                            color: contentTheme.secondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}
