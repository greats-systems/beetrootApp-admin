import 'dart:io';
import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:core_erp/controllers/apps/provider-admin/provider-admin_controller.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:file_picker/file_picker.dart';
import 'package:core_erp/controllers/apps/ecommerce/edit_products_controller.dart';
import 'package:core_erp/controllers/pages/profile_controller.dart';
import 'package:core_erp/extensions/string.dart';
import 'package:core_erp/images.dart';
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

class AllocateVehicle extends StatefulWidget {
  const AllocateVehicle({Key? key}) : super(key: key);

  @override
  State<AllocateVehicle> createState() => _AllocateVehicleState();
}

class _AllocateVehicleState extends State<AllocateVehicle>
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
                    FxBreadcrumb(
                      children: [
                        FxBreadcrumbItem(
                            name: "Allocate Vehicle", active: true),
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
                                            'Reset upload window All',
                                            color: contentTheme.onSuccess,
                                          ),
                                        ),
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
                                                        "Allocate Vehicle".tr(),
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
                                                                              controller.onAddNewTruck();
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
                                                                      'No vehicle image files uploaded.')
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
                                                    child: AutoSizeText(
                                                      "Please upload vehicle, images insurance, ownership certificate, and any relevant files",
                                                      minFontSize: 8,
                                                      maxFontSize: 12,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
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
                                                              "Vehicle Class"
                                                                  .tr(),
                                                            ),
                                                            FxSpacing.height(8),
                                                            DropdownButtonFormField<
                                                                VehicleCategory>(
                                                              dropdownColor:
                                                                  colorScheme
                                                                      .background,
                                                              menuMaxHeight:
                                                                  200,
                                                              isDense: true,

                                                              // itemHeight: 40,
                                                              items:
                                                                  VehicleCategory
                                                                      .values
                                                                      .map(
                                                                        (category) =>
                                                                            DropdownMenuItem<VehicleCategory>(
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
                                                                    "Select appropriate class",
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
                                                                    .onChangeSelectVehicle(
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
                                                              "Manufacturer"
                                                                  .tr(),
                                                            ),
                                                            FxSpacing.height(8),
                                                            DropdownButtonFormField<
                                                                Manufacturer>(
                                                              dropdownColor:
                                                                  colorScheme
                                                                      .background,
                                                              menuMaxHeight:
                                                                  200,
                                                              isDense: true,

                                                              // itemHeight: 40,
                                                              items:
                                                                  Manufacturer
                                                                      .values
                                                                      .map(
                                                                        (category) =>
                                                                            DropdownMenuItem<Manufacturer>(
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
                                                                    "Select brand",
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
                                                                    .onChangeManufacturer(
                                                                        value);
                                                              },
                                                            )
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
                                                              "Carrying Weight Min"
                                                                  .tr()
                                                                  .capitalizeWords,
                                                            ),
                                                            FxSpacing.height(8),
                                                            TextFormField(
                                                              validator: controller
                                                                  .basicValidator
                                                                  .getValidation(
                                                                      'carrying_weight_min'),
                                                              controller: controller
                                                                  .basicValidator
                                                                  .getController(
                                                                      'carrying_weight_min'),
                                                              keyboardType:
                                                                  TextInputType
                                                                      .multiline,
                                                              decoration:
                                                                  InputDecoration(
                                                                hintText:
                                                                    "200.00",
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
                                                                          "\KG",
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
                                                    FxFlexItem(
                                                        sizes: 'lg-6 md-12',
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            FxText.labelMedium(
                                                              "Carrying Weight Max"
                                                                  .tr()
                                                                  .capitalizeWords,
                                                            ),
                                                            FxSpacing.height(8),
                                                            TextFormField(
                                                              validator: controller
                                                                  .basicValidator
                                                                  .getValidation(
                                                                      'carrying_weight_max'),
                                                              controller: controller
                                                                  .basicValidator
                                                                  .getController(
                                                                      'carrying_weight_max'),
                                                              keyboardType:
                                                                  TextInputType
                                                                      .multiline,
                                                              decoration:
                                                                  InputDecoration(
                                                                hintText:
                                                                    "2000.00",
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
                                                                          "\KG",
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
                                              FxSpacing.height(25),
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
                                                              "engine_number"
                                                                  .tr()
                                                                  .capitalizeWords,
                                                            ),
                                                            FxSpacing.height(8),
                                                            TextFormField(
                                                              validator: controller
                                                                  .basicValidator
                                                                  .getValidation(
                                                                      'engine_number'),
                                                              controller: controller
                                                                  .basicValidator
                                                                  .getController(
                                                                      'engine_number'),
                                                              keyboardType:
                                                                  TextInputType
                                                                      .multiline,
                                                              decoration:
                                                                  InputDecoration(
                                                                hintText:
                                                                    "ZW00000090",
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
                                                              "gvt_reg_number"
                                                                  .tr()
                                                                  .capitalizeWords,
                                                            ),
                                                            FxSpacing.height(8),
                                                            TextFormField(
                                                              validator: controller
                                                                  .basicValidator
                                                                  .getValidation(
                                                                      'gvt_reg_number'),
                                                              controller: controller
                                                                  .basicValidator
                                                                  .getController(
                                                                      'gvt_reg_number'),
                                                              keyboardType:
                                                                  TextInputType
                                                                      .multiline,
                                                              decoration:
                                                                  InputDecoration(
                                                                hintText:
                                                                    "GVT Reg  Number",
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
                                              FxSpacing.height(25),
                                              FxText.labelMedium(
                                                "description".tr(),
                                              ),
                                              FxSpacing.height(8),
                                              TextFormField(
                                                validator: controller
                                                    .basicValidator
                                                    .getValidation(
                                                        'description'),
                                                controller: controller
                                                    .basicValidator
                                                    .getController(
                                                        'description'),
                                                keyboardType:
                                                    TextInputType.multiline,
                                                maxLines: 3,
                                                decoration: InputDecoration(
                                                  hintText: "more information",
                                                  hintStyle:
                                                      FxTextStyle.bodySmall(
                                                          xMuted: true),
                                                  border: outlineInputBorder,
                                                  enabledBorder:
                                                      outlineInputBorder,
                                                  focusedBorder:
                                                      focusedInputBorder,
                                                  contentPadding:
                                                      FxSpacing.all(16),
                                                  isCollapsed: true,
                                                  floatingLabelBehavior:
                                                      FloatingLabelBehavior
                                                          .never,
                                                ),
                                              ),
                                              FxSpacing.height(25),
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
                      height: 400,
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
