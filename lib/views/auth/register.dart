import 'package:core_erp/controllers/apps/provider-admin/provider-admin_controller.dart';
import 'package:core_erp/controllers/auth/auth_controller.dart';
import 'package:core_erp/extensions/extensions.dart';
import 'package:core_erp/models/locations.dart';
import 'package:core_erp/utils/mixins/ui_mixin.dart';
import 'package:core_erp/views/layouts/auth_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with SingleTickerProviderStateMixin, UIMixin {
  late AuthController controller;
  GlobalKey<FormState> signUpProfileKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    debugPrint('======RegisterPage----');
    controller = Get.put(AuthController());
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      child: GetBuilder<AuthController>(
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
                    "register".tr(),
                    fontWeight: 700,
                  )),
                  FxSpacing.height(10),
                  Obx(() => controller.serverError.value == true
                      ? Center(
                          child: FxText.bodySmall(
                          "${controller.errorMessage.value}".tr(),
                          color: Colors.red,
                          muted: true,
                        ))
                      : Center(
                          child: FxText.bodySmall(
                          "don't_have_an_account?_create_your_\naccount,_it_takes_less_than_a_minute"
                              .tr(),
                          muted: true,
                        ))),
                  FxSpacing.height(45),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FxText.labelMedium(
                              "first_name".tr().capitalizeWords,
                            ),
                            FxSpacing.height(4),
                            TextFormField(
                              validator: controller.basicValidator
                                  .getValidation('first_name'),
                              controller: controller.basicValidator
                                  .getController('first_name'),
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: "First Name",
                                labelStyle: FxTextStyle.bodySmall(xMuted: true),
                                border: outlineInputBorder,
                                prefixIcon: Icon(
                                  Icons.person_outline,
                                  size: 20,
                                ),
                                contentPadding: FxSpacing.all(16),
                                isCollapsed: true,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                              ),
                            ),
                          ],
                        ),
                      ),
                      FxSpacing.width(20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FxText.labelMedium(
                              "last_name".tr().capitalizeWords,
                            ),
                            FxSpacing.height(4),
                            TextFormField(
                              validator: controller.basicValidator
                                  .getValidation('last_name'),
                              controller: controller.basicValidator
                                  .getController('last_name'),
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: "Last Name",
                                labelStyle: FxTextStyle.bodySmall(xMuted: true),
                                border: outlineInputBorder,
                                prefixIcon: Icon(
                                  Icons.person_outline,
                                  size: 20,
                                ),
                                contentPadding: FxSpacing.all(16),
                                isCollapsed: true,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  FxSpacing.height(20),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FxText.labelMedium(
                              "City".tr(),
                            ),
                            FxSpacing.height(8),
                            DropdownButtonFormField(
                              dropdownColor: colorScheme.background,
                              menuMaxHeight: 200,
                              isDense: true,

                              // itemHeight: 40,
                              items: populatedCities
                                  .map(
                                    (city) => DropdownMenuItem(
                                      value: city,
                                      child: FxText.labelMedium(
                                        city.capitalize,
                                      ),
                                    ),
                                  )
                                  .toList(),
                              icon: Icon(
                                Icons.expand_more,
                                size: 20,
                              ),
                              decoration: InputDecoration(
                                hintText: "Select city",
                                hintStyle: FxTextStyle.bodySmall(xMuted: true),
                                border: outlineInputBorder,
                                enabledBorder: outlineInputBorder,
                                focusedBorder: focusedInputBorder,
                                contentPadding: FxSpacing.all(14),
                                isCollapsed: true,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                              ),
                              onChanged: (value) {
                                controller.onSelectedCity(value!);
                              },
                            )
                          ],
                        ),
                      ),
                      FxSpacing.width(20),
                      Expanded(
                        child: Obx(() => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FxText.labelMedium(
                                  "Neighbourhood (${controller.populatedNeighbourhoodsNames.length})"
                                      .tr(),
                                ),
                                FxSpacing.height(8),
                                controller
                                        .populatedNeighbourhoodsNames.isNotEmpty
                                    ? DropdownButtonFormField<String>(
                                        dropdownColor: colorScheme.background,
                                        menuMaxHeight: 200,
                                        isDense: true,

                                        // itemHeight: 40,
                                        items: controller
                                            .populatedNeighbourhoodsNames
                                            .map(
                                              (neighbourhood) =>
                                                  DropdownMenuItem<String>(
                                                value: neighbourhood,
                                                child: FxText.labelMedium(
                                                  neighbourhood,
                                                ),
                                              ),
                                            )
                                            .toList(),
                                        icon: Icon(
                                          Icons.expand_more,
                                          size: 20,
                                        ),
                                        decoration: InputDecoration(
                                          hintText: "Select area e.g Mufakose",
                                          hintStyle: FxTextStyle.bodySmall(
                                              xMuted: true),
                                          border: outlineInputBorder,
                                          enabledBorder: outlineInputBorder,
                                          focusedBorder: focusedInputBorder,
                                          contentPadding: FxSpacing.all(14),
                                          isCollapsed: true,
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.never,
                                        ),
                                        onChanged: (value) {
                                          controller.onSelectedArea(value!);
                                        },
                                      )
                                    : TextFormField(
                                        validator: controller.basicValidator
                                            .getValidation('neighbourhood'),
                                        controller: controller.basicValidator
                                            .getController('neighbourhood'),
                                        keyboardType: TextInputType.multiline,
                                        decoration: InputDecoration(
                                          hintText: "neighbourhood",
                                          hintStyle: FxTextStyle.bodySmall(
                                              xMuted: true),
                                          border: outlineInputBorder,
                                          enabledBorder: outlineInputBorder,
                                          focusedBorder: focusedInputBorder,
                                          prefixIconConstraints: BoxConstraints(
                                              maxHeight: 42,
                                              minWidth: 50,
                                              maxWidth: 50),
                                          contentPadding: FxSpacing.all(16),
                                          isCollapsed: true,
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.never,
                                        ),
                                      )
                              ],
                            )),
                      ),
                    ],
                  ),
                  FxSpacing.height(20),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FxText.labelMedium(
                              "Accont Type".tr().capitalizeWords,
                            ),
                            FxSpacing.height(4),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FxSpacing.height(8),
                                DropdownButtonFormField<String>(
                                  dropdownColor: colorScheme.background,
                                  menuMaxHeight: 200,
                                  isDense: true,

                                  // itemHeight: 40,
                                  items: controller.accontTypes
                                      .map(
                                        (category) => DropdownMenuItem<String>(
                                          value: category,
                                          child: FxText.labelMedium(
                                            category.capitalize,
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  icon: Icon(
                                    Icons.expand_more,
                                    size: 20,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "Select Accont Type",
                                    hintStyle:
                                        FxTextStyle.bodySmall(xMuted: true),
                                    border: outlineInputBorder,
                                    enabledBorder: outlineInputBorder,
                                    focusedBorder: focusedInputBorder,
                                    contentPadding: FxSpacing.all(14),
                                    isCollapsed: true,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                  ),
                                  onChanged: (value) {
                                    controller.onChangeAccontType(value!);
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      FxSpacing.width(20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FxSpacing.height(4),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FxText.labelMedium(
                                  "Trading Category".tr(),
                                ),
                                FxSpacing.height(8),
                                DropdownButtonFormField<String>(
                                  dropdownColor: colorScheme.background,
                                  menuMaxHeight: 200,
                                  isDense: true,

                                  // itemHeight: 40,
                                  items: controller.tradingAsCategories
                                      .map(
                                        (category) => DropdownMenuItem<String>(
                                          value: category,
                                          child: FxText.labelMedium(
                                            category.capitalize,
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  icon: Icon(
                                    Icons.expand_more,
                                    size: 20,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "Select Trading Category",
                                    hintStyle:
                                        FxTextStyle.bodySmall(xMuted: true),
                                    border: outlineInputBorder,
                                    enabledBorder: outlineInputBorder,
                                    focusedBorder: focusedInputBorder,
                                    contentPadding: FxSpacing.all(14),
                                    isCollapsed: true,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                  ),
                                  onChanged: (value) {
                                    controller
                                        .onChangeTradingAsCategory(value!);
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  FxSpacing.height(20),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FxText.labelMedium(
                              "email_address".tr().capitalizeWords,
                            ),
                            FxSpacing.height(4),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FxSpacing.height(8),
                                // FxSpacing.height(4),
                                TextFormField(
                                  validator: controller.basicValidator
                                      .getValidation('email'),
                                  controller: controller.basicValidator
                                      .getController('email'),
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    labelText: "Email Address",
                                    labelStyle:
                                        FxTextStyle.bodySmall(xMuted: true),
                                    border: outlineInputBorder,
                                    prefixIcon: Icon(
                                      Icons.email_outlined,
                                      size: 20,
                                    ),
                                    contentPadding: FxSpacing.all(16),
                                    isCollapsed: true,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      FxSpacing.width(20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FxSpacing.height(4),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FxText.labelMedium(
                                  "Phone Number".tr(),
                                ),
                                FxSpacing.height(8),
                                TextFormField(
                                  validator: controller.basicValidator
                                      .getValidation('phone'),
                                  controller: controller.basicValidator
                                      .getController('phone'),
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    labelText: "+263",
                                    labelStyle:
                                        FxTextStyle.bodySmall(xMuted: true),
                                    border: outlineInputBorder,
                                    prefixIcon: Icon(
                                      Icons.person_outline,
                                      size: 20,
                                    ),
                                    contentPadding: FxSpacing.all(16),
                                    isCollapsed: true,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  FxSpacing.height(20),
                  FxText.labelMedium(
                    "email_password".tr().capitalizeWords,
                  ),
                  FxSpacing.height(4),
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
                  FxSpacing.height(30),
                  Center(
                    child: FxButton.rounded(
                      onPressed: controller.onHandleSignUp,
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
                            'register'.tr(),
                            color: contentTheme.onPrimary,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: FxButton.text(
                      onPressed: controller.gotoLogin,
                      elevation: 0,
                      padding: FxSpacing.x(16),
                      splashColor: contentTheme.secondary.withOpacity(0.1),
                      child: FxText.labelMedium(
                        'already_have_account_?'.tr(),
                        color: contentTheme.secondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
