import 'dart:io';
import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:file_picker/file_picker.dart';
import 'package:core_erp/controllers/apps/ecommerce/edit_products_controller.dart';
import 'package:core_erp/controllers/apps/provider-admin/provider-admin_controller.dart';
import 'package:core_erp/controllers/pages/profile_controller.dart';
import 'package:core_erp/extensions/string.dart';
import 'package:core_erp/images.dart';
import 'package:core_erp/models/locations.dart';
import 'package:core_erp/services/theme/app_style.dart';
import 'package:core_erp/utils/mixins/ui_mixin.dart';
import 'package:core_erp/utils/utils.dart';
import 'package:core_erp/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:image_picker/image_picker.dart';
import '../../../controllers/apps/files/file_upload_controller.dart';

class AddNewEmployee extends StatefulWidget {
  const AddNewEmployee({Key? key}) : super(key: key);

  @override
  State<AddNewEmployee> createState() => _AddNewEmployeeState();
}

class _AddNewEmployeeState extends State<AddNewEmployee>
    with SingleTickerProviderStateMixin, UIMixin {
  late ProviderAdminController controller;
  late FileUploadController fileUploadController;

  @override
  void initState() {
    super.initState();
    controller = Get.put(ProviderAdminController());
    fileUploadController = Get.put(FileUploadController());
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: FxSpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // FxText.titleMedium(
                    //   "Edit",
                    //   fontWeight: 600,
                    // ),
                    FxBreadcrumb(
                      children: [
                        // FxBreadcrumbItem(name: "UI"),
                        FxBreadcrumbItem(name: "New Employee", active: true),
                      ],
                    ),
                  ],
                ),
              ),
              FxSpacing.height(flexSpacing),
              Padding(
                padding: FxSpacing.x(flexSpacing / 2),
                child: FxFlex(
                  wrapAlignment: WrapAlignment.start,
                  wrapCrossAlignment: WrapCrossAlignment.start,
                  children: [
                    FxFlexItem(
                      sizes: "lg-4 md-12",
                      child: Column(
                        children: [
                          FxContainer(
                            child: Column(
                              children: [
                                Column(
                                  children: [
                                    FxSpacing.height(8),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        FxButton(
                                          onPressed: () {
                                            fileUploadController.removeFiles();
                                          },
                                          elevation: 0,
                                          padding: FxSpacing.xy(20, 16),
                                          backgroundColor: contentTheme.success,
                                          borderRadiusAll:
                                              AppStyle.buttonRadius.medium,
                                          child: FxText.bodySmall(
                                            'Reset Upload window All',
                                            color: contentTheme.onSuccess,
                                          ),
                                        ),
                                        // FxSpacing.width(flexSpacing / 3),
                                        // FxButton(
                                        //   onPressed: () {},
                                        //   elevation: 0,
                                        //   padding: FxSpacing.xy(20, 16),
                                        //   backgroundColor: contentTheme.primary,
                                        //   borderRadiusAll:
                                        //       AppStyle.buttonRadius.medium,
                                        //   child: FxText.bodySmall(
                                        //     'Upload Image Files ',
                                        //     color: contentTheme.onPrimary,
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ],
                                ),
                                FxSpacing.height(8),
                                FxSpacing.height(8),
                                FxContainer(
                                  height: 200,
                                  // width: 600,
                                  paddingAll: 0,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: GetBuilder(
                                      init: fileUploadController,
                                      builder: (fileUploadController) {
                                        return Padding(
                                          padding: FxSpacing.x(flexSpacing),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              FxSpacing.height(16),
                                              InkWell(
                                                onTap: fileUploadController
                                                    .pickFile,
                                                child: FxDottedLine(
                                                  strokeWidth: 0.2,
                                                  color:
                                                      contentTheme.onBackground,
                                                  corner: FxDottedLineCorner(
                                                    leftBottomCorner: 2,
                                                    leftTopCorner: 2,
                                                    rightBottomCorner: 2,
                                                    rightTopCorner: 2,
                                                  ),
                                                  child: Center(
                                                    heightFactor: 1.5,
                                                    child: Padding(
                                                      padding: FxSpacing.all(8),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                              Icons
                                                                  .cloud_upload_outlined,
                                                              size: 22),
                                                          FxContainer(
                                                            alignment: Alignment
                                                                .center,
                                                            // width: 710,
                                                            child: FxText
                                                                .titleMedium(
                                                              "Click to upload .png or .jpeg file formats only.",
                                                              muted: true,
                                                              fontWeight: 500,
                                                              fontSize: 16,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                ),
                                FxSpacing.height(16),
                                itemImageField(context),
                                FxSpacing.height(8),
                              ],
                            ),
                          ),
                          FxSpacing.height(20),
                        ],
                      ),
                    ),
                    FxFlexItem(
                      sizes: "lg-8 md-12",
                      child: Column(
                        children: [
                          FxContainer.bordered(
                            paddingAll: 20,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minHeight: 400,
                                  ),
                                  child: FxCard(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    shadow: FxShadow(
                                        elevation: 0.5,
                                        position: FxShadowPosition.bottom),
                                    paddingAll: 0,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Container(
                                          // width: double.infinity,
                                          color: colorScheme.primary
                                              .withOpacity(0.08),
                                          padding: FxSpacing.xy(16, 12),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        FeatherIcons.server,
                                                        color: contentTheme
                                                            .primary,
                                                        size: 8,
                                                      ),
                                                      FxSpacing.width(12),
                                                      FxText.titleMedium(
                                                        "Create".tr(),
                                                        fontWeight: 600,
                                                        color:
                                                            colorScheme.primary,
                                                      ),
                                                    ],
                                                  ),
                                                  Obx(() =>
                                                      fileUploadController
                                                                  .isImagesAdded
                                                                  .value ==
                                                              true
                                                          ? Row(
                                                              children: [
                                                                Obx(() => controller
                                                                            .isSavingSuccess
                                                                            .value ==
                                                                        true
                                                                    ? Center(
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            CircularProgressIndicator(
                                                                              strokeWidth: 1.0,
                                                                              color: theme.primaryColor,
                                                                            ),
                                                                            FxSpacing.width(16),
                                                                            Text('Saving ...')
                                                                          ],
                                                                        ),
                                                                      )
                                                                    : Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.end,
                                                                        children: [
                                                                          FxButton
                                                                              .text(
                                                                            onPressed:
                                                                                () {},
                                                                            padding:
                                                                                FxSpacing.xy(20, 16),
                                                                            splashColor:
                                                                                contentTheme.secondary.withOpacity(0.1),
                                                                            child:
                                                                                FxText.bodySmall(
                                                                              'cancel'.tr(),
                                                                            ),
                                                                          ),
                                                                          FxSpacing.width(
                                                                              12),
                                                                          FxButton(
                                                                            onPressed:
                                                                                () {
                                                                              controller.onAddNewEmployee();
                                                                            },
                                                                            elevation:
                                                                                0,
                                                                            padding:
                                                                                FxSpacing.xy(20, 16),
                                                                            backgroundColor:
                                                                                contentTheme.primary,
                                                                            borderRadiusAll:
                                                                                AppStyle.buttonRadius.medium,
                                                                            child:
                                                                                FxText.bodySmall(
                                                                              'save'.tr(),
                                                                              color: contentTheme.onPrimary,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      )),
                                                              ],
                                                            )
                                                          : Center(
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  FxSpacing
                                                                      .width(
                                                                          16),
                                                                  Text(
                                                                      'No employee required files uploaded.')
                                                                ],
                                                              ),
                                                            ))
                                                ],
                                              ),
                                              FxSpacing.height(12),
                                              Row(
                                                children: [
                                                  Icon(
                                                    FeatherIcons.info,
                                                    color:
                                                        contentTheme.secondary,
                                                    size: 16,
                                                  ),
                                                  FxSpacing.width(12),
                                                  Expanded(
                                                    child: Obx(() => controller
                                                                .serverReponseError
                                                                .value ==
                                                            true
                                                        ? AutoSizeText(
                                                            "${controller.serverReponseErrorMessage}",
                                                            minFontSize: 8,
                                                            maxFontSize: 12,
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          )
                                                        : controller.serverReponseSuccess
                                                                    .value ==
                                                                true
                                                            ? AutoSizeText(
                                                                "${controller.serverReponseSuccessMessage}",
                                                                minFontSize: 8,
                                                                maxFontSize: 12,
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              )
                                                            : controller.selectedJobRoleCategories
                                                                        .value ==
                                                                    'driver'
                                                                ? AutoSizeText(
                                                                    "Driver particulars are required. Please upload driver license, profile image and medical records for HR Review",
                                                                    minFontSize:
                                                                        8,
                                                                    maxFontSize:
                                                                        12,
                                                                    maxLines: 2,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  )
                                                                : controller.selectedJobRoleCategories
                                                                            .value ==
                                                                        'grader'
                                                                    ? AutoSizeText(
                                                                        "Grader particulars are required. Please upload grading certificates, profile image and last reviewed records successful employee grading",
                                                                        minFontSize:
                                                                            8,
                                                                        maxFontSize:
                                                                            12,
                                                                        maxLines:
                                                                            2,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      )
                                                                    : AutoSizeText(
                                                                        "Please upload academic certificates, profile image, and any relevant medical records for HR Review",
                                                                        minFontSize:
                                                                            8,
                                                                        maxFontSize:
                                                                            12,
                                                                        maxLines:
                                                                            2,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      )),
                                                  ),
                                                  // FxText.titleMedium(

                                                  //       .tr(),
                                                  //   fontWeight: 200,
                                                  //   color: colorScheme
                                                  //       .primary,
                                                  // ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              FxSpacing.xy(flexSpacing, 16),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              FxFlex(
                                                  contentPadding: false,
                                                  children: [
                                                    FxFlexItem(
                                                        sizes: 'lg-6 md-12',
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            FxText.labelMedium(
                                                              "Department".tr(),
                                                            ),
                                                            FxSpacing.height(8),
                                                            DropdownButtonFormField<
                                                                Department>(
                                                              dropdownColor:
                                                                  colorScheme
                                                                      .background,
                                                              menuMaxHeight:
                                                                  200,
                                                              isDense: true,

                                                              // itemHeight: 40,
                                                              items:
                                                                  Department
                                                                      .values
                                                                      .map(
                                                                        (category) =>
                                                                            DropdownMenuItem<Department>(
                                                                          value:
                                                                              category,
                                                                          child:
                                                                              FxText.labelMedium(
                                                                            category.name.capitalize,
                                                                          ),
                                                                        ),
                                                                      )
                                                                      .toList(),
                                                              icon: Icon(
                                                                Icons
                                                                    .expand_more,
                                                                size: 20,
                                                              ),
                                                              decoration:
                                                                  InputDecoration(
                                                                hintText:
                                                                    "Select dept",
                                                                hintStyle: FxTextStyle
                                                                    .bodySmall(
                                                                        xMuted:
                                                                            true),
                                                                border:
                                                                    outlineInputBorder,
                                                                enabledBorder:
                                                                    outlineInputBorder,
                                                                focusedBorder:
                                                                    focusedInputBorder,
                                                                contentPadding:
                                                                    FxSpacing
                                                                        .all(
                                                                            14),
                                                                isCollapsed:
                                                                    true,
                                                                floatingLabelBehavior:
                                                                    FloatingLabelBehavior
                                                                        .never,
                                                              ),
                                                              onChanged:
                                                                  (value) {
                                                                controller
                                                                    .onChangeDepartment(
                                                                        value);
                                                              },
                                                            )
                                                          ],
                                                        )),
                                                    FxFlexItem(
                                                        sizes: 'lg-6 md-12',
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            FxText.labelMedium(
                                                              "deployment_status"
                                                                  .tr(),
                                                            ),
                                                            FxSpacing.height(8),
                                                            DropdownButtonFormField<
                                                                DeploymentStatus>(
                                                              dropdownColor:
                                                                  colorScheme
                                                                      .background,
                                                              menuMaxHeight:
                                                                  200,
                                                              isDense: true,

                                                              // itemHeight: 40,
                                                              items:
                                                                  DeploymentStatus
                                                                      .values
                                                                      .map(
                                                                        (category) =>
                                                                            DropdownMenuItem<DeploymentStatus>(
                                                                          value:
                                                                              category,
                                                                          child:
                                                                              FxText.labelMedium(
                                                                            category.name.capitalize,
                                                                          ),
                                                                        ),
                                                                      )
                                                                      .toList(),
                                                              icon: Icon(
                                                                Icons
                                                                    .expand_more,
                                                                size: 20,
                                                              ),
                                                              decoration:
                                                                  InputDecoration(
                                                                hintText:
                                                                    "Select level",
                                                                hintStyle: FxTextStyle
                                                                    .bodySmall(
                                                                        xMuted:
                                                                            true),
                                                                border:
                                                                    outlineInputBorder,
                                                                enabledBorder:
                                                                    outlineInputBorder,
                                                                focusedBorder:
                                                                    focusedInputBorder,
                                                                contentPadding:
                                                                    FxSpacing
                                                                        .all(
                                                                            14),
                                                                isCollapsed:
                                                                    true,
                                                                floatingLabelBehavior:
                                                                    FloatingLabelBehavior
                                                                        .never,
                                                              ),
                                                              onChanged:
                                                                  (value) {
                                                                controller
                                                                    .onChangeDeploymentStatus(
                                                                        value);
                                                              },
                                                            )
                                                          ],
                                                        ))
                                                  ]),
                                              FxSpacing.height(30),
                                              FxFlex(
                                                  contentPadding: false,
                                                  children: [
                                                    FxFlexItem(
                                                        sizes: 'lg-6 md-12',
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            FxText.labelMedium(
                                                              "job_role".tr(),
                                                            ),
                                                            FxSpacing.height(8),
                                                            DropdownButtonFormField<
                                                                String>(
                                                              dropdownColor:
                                                                  colorScheme
                                                                      .background,
                                                              menuMaxHeight:
                                                                  200,
                                                              isDense: true,

                                                              // itemHeight: 40,
                                                              items: controller
                                                                  .jobRoleCategories
                                                                  .map(
                                                                    (category) =>
                                                                        DropdownMenuItem<
                                                                            String>(
                                                                      value:
                                                                          category,
                                                                      child: FxText
                                                                          .labelMedium(
                                                                        category
                                                                            .capitalize,
                                                                      ),
                                                                    ),
                                                                  )
                                                                  .toList(),
                                                              icon: Icon(
                                                                Icons
                                                                    .expand_more,
                                                                size: 20,
                                                              ),
                                                              decoration:
                                                                  InputDecoration(
                                                                hintText:
                                                                    "Select level",
                                                                hintStyle: FxTextStyle
                                                                    .bodySmall(
                                                                        xMuted:
                                                                            true),
                                                                border:
                                                                    outlineInputBorder,
                                                                enabledBorder:
                                                                    outlineInputBorder,
                                                                focusedBorder:
                                                                    focusedInputBorder,
                                                                contentPadding:
                                                                    FxSpacing
                                                                        .all(
                                                                            14),
                                                                isCollapsed:
                                                                    true,
                                                                floatingLabelBehavior:
                                                                    FloatingLabelBehavior
                                                                        .never,
                                                              ),
                                                              onChanged:
                                                                  (value) {
                                                                controller
                                                                    .onChangeJobRole(
                                                                        value);
                                                              },
                                                            )
                                                          ],
                                                        )),
                                                    FxFlexItem(
                                                        sizes: 'lg-6 md-12',
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            FxText.labelMedium(
                                                              "salary_before_tax"
                                                                  .tr()
                                                                  .capitalizeWords,
                                                            ),
                                                            FxSpacing.height(8),
                                                            TextFormField(
                                                              validator: controller
                                                                  .basicValidator
                                                                  .getValidation(
                                                                      'salary'),
                                                              controller: controller
                                                                  .basicValidator
                                                                  .getController(
                                                                      'salary'),
                                                              keyboardType:
                                                                  TextInputType
                                                                      .multiline,
                                                              decoration:
                                                                  InputDecoration(
                                                                hintText:
                                                                    "20.00",
                                                                hintStyle: FxTextStyle
                                                                    .bodySmall(
                                                                        xMuted:
                                                                            true),
                                                                border:
                                                                    outlineInputBorder,
                                                                enabledBorder:
                                                                    outlineInputBorder,
                                                                focusedBorder:
                                                                    focusedInputBorder,
                                                                prefixIcon: FxContainer
                                                                    .none(
                                                                        margin: FxSpacing.right(
                                                                            12),
                                                                        alignment:
                                                                            Alignment
                                                                                .center,
                                                                        color: contentTheme
                                                                            .primary
                                                                            .withAlpha(
                                                                                40),
                                                                        child: FxText
                                                                            .labelLarge(
                                                                          "\$",
                                                                          color:
                                                                              contentTheme.primary,
                                                                        )),
                                                                prefixIconConstraints:
                                                                    BoxConstraints(
                                                                        maxHeight:
                                                                            42,
                                                                        minWidth:
                                                                            50,
                                                                        maxWidth:
                                                                            50),
                                                                contentPadding:
                                                                    FxSpacing
                                                                        .all(
                                                                            16),
                                                                isCollapsed:
                                                                    true,
                                                                floatingLabelBehavior:
                                                                    FloatingLabelBehavior
                                                                        .never,
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                  ]),
                                              FxSpacing.height(30),
                                              FxFlex(
                                                  contentPadding: false,
                                                  children: [
                                                    FxFlexItem(
                                                        sizes: 'lg-6 md-12',
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            FxText.labelMedium(
                                                              "first_name"
                                                                  .tr()
                                                                  .capitalizeWords,
                                                            ),
                                                            FxSpacing.height(8),
                                                            TextFormField(
                                                              validator: controller
                                                                  .basicValidator
                                                                  .getValidation(
                                                                      'first_name'),
                                                              controller: controller
                                                                  .basicValidator
                                                                  .getController(
                                                                      'first_name'),
                                                              keyboardType:
                                                                  TextInputType
                                                                      .multiline,
                                                              decoration:
                                                                  InputDecoration(
                                                                hintText: "jim",
                                                                hintStyle: FxTextStyle
                                                                    .bodySmall(
                                                                        xMuted:
                                                                            true),
                                                                border:
                                                                    outlineInputBorder,
                                                                enabledBorder:
                                                                    outlineInputBorder,
                                                                focusedBorder:
                                                                    focusedInputBorder,
                                                                prefixIconConstraints:
                                                                    BoxConstraints(
                                                                        maxHeight:
                                                                            42,
                                                                        minWidth:
                                                                            50,
                                                                        maxWidth:
                                                                            50),
                                                                contentPadding:
                                                                    FxSpacing
                                                                        .all(
                                                                            16),
                                                                isCollapsed:
                                                                    true,
                                                                floatingLabelBehavior:
                                                                    FloatingLabelBehavior
                                                                        .never,
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                    FxFlexItem(
                                                        sizes: 'lg-6 md-12',
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            FxText.labelMedium(
                                                              "last_name"
                                                                  .tr()
                                                                  .capitalizeWords,
                                                            ),
                                                            FxSpacing.height(8),
                                                            TextFormField(
                                                              validator: controller
                                                                  .basicValidator
                                                                  .getValidation(
                                                                      'last_name'),
                                                              controller: controller
                                                                  .basicValidator
                                                                  .getController(
                                                                      'last_name'),
                                                              keyboardType:
                                                                  TextInputType
                                                                      .multiline,
                                                              decoration:
                                                                  InputDecoration(
                                                                hintText:
                                                                    "Kuyu",
                                                                hintStyle: FxTextStyle
                                                                    .bodySmall(
                                                                        xMuted:
                                                                            true),
                                                                border:
                                                                    outlineInputBorder,
                                                                enabledBorder:
                                                                    outlineInputBorder,
                                                                focusedBorder:
                                                                    focusedInputBorder,
                                                                prefixIconConstraints:
                                                                    BoxConstraints(
                                                                        maxHeight:
                                                                            42,
                                                                        minWidth:
                                                                            50,
                                                                        maxWidth:
                                                                            50),
                                                                contentPadding:
                                                                    FxSpacing
                                                                        .all(
                                                                            16),
                                                                isCollapsed:
                                                                    true,
                                                                floatingLabelBehavior:
                                                                    FloatingLabelBehavior
                                                                        .never,
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                  ]),
                                              FxSpacing.height(30),
                                              FxFlex(
                                                  contentPadding: false,
                                                  children: [
                                                    FxFlexItem(
                                                        sizes: 'lg-6 md-12',
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            FxText.labelMedium(
                                                              "City".tr(),
                                                            ),
                                                            FxSpacing.height(8),
                                                            DropdownButtonFormField(
                                                              dropdownColor:
                                                                  colorScheme
                                                                      .background,
                                                              menuMaxHeight:
                                                                  200,
                                                              isDense: true,

                                                              // itemHeight: 40,
                                                              items:
                                                                  populatedCities
                                                                      .map(
                                                                        (city) =>
                                                                            DropdownMenuItem(
                                                                          value:
                                                                              city,
                                                                          child:
                                                                              FxText.labelMedium(
                                                                            city.capitalize,
                                                                          ),
                                                                        ),
                                                                      )
                                                                      .toList(),
                                                              icon: Icon(
                                                                Icons
                                                                    .expand_more,
                                                                size: 20,
                                                              ),
                                                              decoration:
                                                                  InputDecoration(
                                                                hintText:
                                                                    "Select city",
                                                                hintStyle: FxTextStyle
                                                                    .bodySmall(
                                                                        xMuted:
                                                                            true),
                                                                border:
                                                                    outlineInputBorder,
                                                                enabledBorder:
                                                                    outlineInputBorder,
                                                                focusedBorder:
                                                                    focusedInputBorder,
                                                                contentPadding:
                                                                    FxSpacing
                                                                        .all(
                                                                            14),
                                                                isCollapsed:
                                                                    true,
                                                                floatingLabelBehavior:
                                                                    FloatingLabelBehavior
                                                                        .never,
                                                              ),
                                                              onChanged:
                                                                  (value) {
                                                                controller
                                                                    .onSelectedCity(
                                                                        value!);
                                                              },
                                                            )
                                                          ],
                                                        )),
                                                    FxFlexItem(
                                                        sizes: 'lg-6 md-12',
                                                        child: Obx(() => Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                FxText
                                                                    .labelMedium(
                                                                  "area (${controller.populatedNeighbourhoodsNames.length})"
                                                                      .tr(),
                                                                ),
                                                                FxSpacing
                                                                    .height(8),
                                                                controller
                                                                        .populatedNeighbourhoodsNames
                                                                        .isNotEmpty
                                                                    ? DropdownButtonFormField<
                                                                        String>(
                                                                        dropdownColor:
                                                                            colorScheme.background,
                                                                        menuMaxHeight:
                                                                            200,
                                                                        isDense:
                                                                            true,

                                                                        // itemHeight: 40,
                                                                        items: controller
                                                                            .populatedNeighbourhoodsNames
                                                                            .map(
                                                                              (neighbourhood) => DropdownMenuItem<String>(
                                                                                value: neighbourhood,
                                                                                child: FxText.labelMedium(
                                                                                  neighbourhood,
                                                                                ),
                                                                              ),
                                                                            )
                                                                            .toList(),
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .expand_more,
                                                                          size:
                                                                              20,
                                                                        ),
                                                                        decoration:
                                                                            InputDecoration(
                                                                          hintText:
                                                                              "Select area e.g Mufakose",
                                                                          hintStyle:
                                                                              FxTextStyle.bodySmall(xMuted: true),
                                                                          border:
                                                                              outlineInputBorder,
                                                                          enabledBorder:
                                                                              outlineInputBorder,
                                                                          focusedBorder:
                                                                              focusedInputBorder,
                                                                          contentPadding:
                                                                              FxSpacing.all(14),
                                                                          isCollapsed:
                                                                              true,
                                                                          floatingLabelBehavior:
                                                                              FloatingLabelBehavior.never,
                                                                        ),
                                                                        onChanged:
                                                                            (value) {
                                                                          controller
                                                                              .onSelectedArea(value!);
                                                                        },
                                                                      )
                                                                    : TextFormField(
                                                                        validator: controller
                                                                            .basicValidator
                                                                            .getValidation('last_name'),
                                                                        controller: controller
                                                                            .basicValidator
                                                                            .getController('last_name'),
                                                                        keyboardType:
                                                                            TextInputType.multiline,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          hintText:
                                                                              "Kuyu",
                                                                          hintStyle:
                                                                              FxTextStyle.bodySmall(xMuted: true),
                                                                          border:
                                                                              outlineInputBorder,
                                                                          enabledBorder:
                                                                              outlineInputBorder,
                                                                          focusedBorder:
                                                                              focusedInputBorder,
                                                                          prefixIconConstraints: BoxConstraints(
                                                                              maxHeight: 42,
                                                                              minWidth: 50,
                                                                              maxWidth: 50),
                                                                          contentPadding:
                                                                              FxSpacing.all(16),
                                                                          isCollapsed:
                                                                              true,
                                                                          floatingLabelBehavior:
                                                                              FloatingLabelBehavior.never,
                                                                        ),
                                                                      )
                                                              ],
                                                            )))
                                                  ]),
                                              FxSpacing.height(30),
                                              FxFlex(
                                                  contentPadding: false,
                                                  children: [
                                                    FxFlexItem(
                                                        sizes: 'lg-6 md-12',
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            FxText.labelMedium(
                                                              "phone_number"
                                                                  .tr()
                                                                  .capitalizeWords,
                                                            ),
                                                            FxSpacing.height(8),
                                                            TextFormField(
                                                              validator: controller
                                                                  .basicValidator
                                                                  .getValidation(
                                                                      'phone_number'),
                                                              controller: controller
                                                                  .basicValidator
                                                                  .getController(
                                                                      'phone_number'),
                                                              keyboardType:
                                                                  TextInputType
                                                                      .multiline,
                                                              decoration:
                                                                  InputDecoration(
                                                                hintText:
                                                                    "+263777757600",
                                                                hintStyle: FxTextStyle
                                                                    .bodySmall(
                                                                        xMuted:
                                                                            true),
                                                                border:
                                                                    outlineInputBorder,
                                                                enabledBorder:
                                                                    outlineInputBorder,
                                                                focusedBorder:
                                                                    focusedInputBorder,
                                                                prefixIconConstraints:
                                                                    BoxConstraints(
                                                                        maxHeight:
                                                                            42,
                                                                        minWidth:
                                                                            50,
                                                                        maxWidth:
                                                                            50),
                                                                contentPadding:
                                                                    FxSpacing
                                                                        .all(
                                                                            16),
                                                                isCollapsed:
                                                                    true,
                                                                floatingLabelBehavior:
                                                                    FloatingLabelBehavior
                                                                        .never,
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                    FxFlexItem(
                                                        sizes: 'lg-6 md-12',
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            FxText.labelMedium(
                                                              "street_address"
                                                                  .tr()
                                                                  .capitalizeWords,
                                                            ),
                                                            FxSpacing.height(8),
                                                            TextFormField(
                                                              validator: controller
                                                                  .basicValidator
                                                                  .getValidation(
                                                                      'street_address'),
                                                              controller: controller
                                                                  .basicValidator
                                                                  .getController(
                                                                      'street_address'),
                                                              keyboardType:
                                                                  TextInputType
                                                                      .multiline,
                                                              decoration:
                                                                  InputDecoration(
                                                                hintText:
                                                                    "240 Mathe Street Mkoba 11",
                                                                hintStyle: FxTextStyle
                                                                    .bodySmall(
                                                                        xMuted:
                                                                            true),
                                                                border:
                                                                    outlineInputBorder,
                                                                enabledBorder:
                                                                    outlineInputBorder,
                                                                focusedBorder:
                                                                    focusedInputBorder,
                                                                prefixIconConstraints:
                                                                    BoxConstraints(
                                                                        maxHeight:
                                                                            42,
                                                                        minWidth:
                                                                            50,
                                                                        maxWidth:
                                                                            50),
                                                                contentPadding:
                                                                    FxSpacing
                                                                        .all(
                                                                            16),
                                                                isCollapsed:
                                                                    true,
                                                                floatingLabelBehavior:
                                                                    FloatingLabelBehavior
                                                                        .never,
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                  ]),
                                              FxSpacing.height(20),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          FxSpacing.height(20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  itemImageField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GetBuilder(
            init: fileUploadController,
            builder: (fileUploadController) {
              return fileUploadController.files.isNotEmpty
                  ? SizedBox(
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 180,
                                childAspectRatio: 3 / 2,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20),
                        itemCount: fileUploadController.files.length,
                        itemBuilder: (context, index) {
                          PlatformFile image =
                              fileUploadController.files[index];
                          return Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.memory(
                                    Uint8List.fromList(image.bytes!),
                                    height: 150,
                                    width: 150,
                                    // width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                    top: 0,
                                    child: FxContainer.roundBordered(
                                      onTap: () => fileUploadController
                                          .removeFile(image),
                                      paddingAll: 4,
                                      child: Icon(
                                        Icons.close,
                                        size: 16,
                                      ),
                                    ))
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  : Column();
            }),
      ],
    );
  }

  buildProfileDetail(String firstName, String lastName) {
    return Row(
      children: [
        FxText.titleSmall(
          firstName,
          fontWeight: 700,
          muted: true,
        ),
        FxSpacing.width(8),
        FxText.titleSmall(
          lastName,
          muted: true,
        ),
      ],
    );
  }

  buildTextField(String fieldTitle, String hintText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FxText.labelMedium(
          fieldTitle,
        ),
        FxSpacing.height(8),
        TextFormField(
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: FxTextStyle.bodySmall(xMuted: true),
            border: outlineInputBorder,
            contentPadding: FxSpacing.all(16),
            isCollapsed: true,
            floatingLabelBehavior: FloatingLabelBehavior.never,
          ),
        ),
      ],
    );
  }

  buildSocialTextField(
    String fieldTitle,
    String hintText,
    IconData icon,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FxText.labelMedium(
          fieldTitle,
        ),
        FxSpacing.height(8),
        TextFormField(
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: FxTextStyle.bodySmall(xMuted: true),
            border: outlineInputBorder,
            enabledBorder: outlineInputBorder,
            // focusedBorder: focusedInputBorder,
            prefixIcon: FxContainer.none(
              margin: FxSpacing.right(12),
              alignment: Alignment.center,
              color: contentTheme.primary.withAlpha(40),
              child: Icon(
                icon,
                color: contentTheme.primary,
                size: 18,
              ),
            ),
            prefixIconConstraints: BoxConstraints(
              maxHeight: 50,
              minWidth: 50,
              maxWidth: 50,
            ),
            contentPadding: FxSpacing.all(16),
            isCollapsed: true,
            floatingLabelBehavior: FloatingLabelBehavior.never,
          ),
        ),
      ],
    );
  }
}
