import 'dart:io';
import 'dart:typed_data';

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

class EditProduct extends StatefulWidget {
  const EditProduct({Key? key}) : super(key: key);

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct>
    with SingleTickerProviderStateMixin, UIMixin {
  late AddProductsController controller;
  late FileUploadController fileUploadController;

  @override
  void initState() {
    super.initState();
    controller = Get.put(AddProductsController());
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
                        FxBreadcrumbItem(name: "New Item", active: true),
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
                                            'Remove All',
                                            color: contentTheme.onSuccess,
                                          ),
                                        ),
                                        FxSpacing.width(flexSpacing / 3),
                                        FxButton(
                                          onPressed: () {},
                                          elevation: 0,
                                          padding: FxSpacing.xy(20, 16),
                                          backgroundColor: contentTheme.primary,
                                          borderRadiusAll:
                                              AppStyle.buttonRadius.medium,
                                          child: FxText.bodySmall(
                                            'Upload Images ',
                                            color: contentTheme.onPrimary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                FxSpacing.height(8),
                                FxSpacing.height(8),
                                FxContainer(
                                  height: 160,
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
                                                              "Click to upload.",
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
                                SizedBox(
                                  height: 700,
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
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    FeatherIcons.server,
                                                    color: contentTheme.primary,
                                                    size: 8,
                                                  ),
                                                  FxSpacing.width(12),
                                                  FxText.titleMedium(
                                                    "Create".tr(),
                                                    fontWeight: 600,
                                                    color: colorScheme.primary,
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Obx(() => controller
                                                              .isSavingSuccess
                                                              .value ==
                                                          true
                                                      ? Center(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              CircularProgressIndicator(
                                                                strokeWidth:
                                                                    1.0,
                                                                color: theme
                                                                    .primaryColor,
                                                              ),
                                                              FxSpacing.width(
                                                                  16),
                                                              Text('Saving ...')
                                                            ],
                                                          ),
                                                        )
                                                      : Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            FxButton.text(
                                                              onPressed: () {},
                                                              padding:
                                                                  FxSpacing.xy(
                                                                      20, 16),
                                                              splashColor:
                                                                  contentTheme
                                                                      .secondary
                                                                      .withOpacity(
                                                                          0.1),
                                                              child: FxText
                                                                  .bodySmall(
                                                                'cancel'.tr(),
                                                              ),
                                                            ),
                                                            FxSpacing.width(12),
                                                            FxButton(
                                                              onPressed: () {
                                                                controller
                                                                    .onAddNewItem();
                                                              },
                                                              elevation: 0,
                                                              padding:
                                                                  FxSpacing.xy(
                                                                      20, 16),
                                                              backgroundColor:
                                                                  contentTheme
                                                                      .primary,
                                                              borderRadiusAll:
                                                                  AppStyle
                                                                      .buttonRadius
                                                                      .medium,
                                                              child: FxText
                                                                  .bodySmall(
                                                                'save'.tr(),
                                                                color: contentTheme
                                                                    .onPrimary,
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                ],
                                              )
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
                                                              "category".tr(),
                                                            ),
                                                            FxSpacing.height(8),
                                                            DropdownButtonFormField<
                                                                Category>(
                                                              dropdownColor:
                                                                  colorScheme
                                                                      .background,
                                                              menuMaxHeight:
                                                                  200,
                                                              isDense: true,

                                                              // itemHeight: 40,
                                                              items:
                                                                  Category
                                                                      .values
                                                                      .map(
                                                                        (category) =>
                                                                            DropdownMenuItem<Category>(
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
                                                                    "Select category",
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
                                                                    .onChangeCategory(
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
                                                              "common_name"
                                                                  .tr()
                                                                  .capitalizeWords,
                                                            ),
                                                            FxSpacing.height(8),
                                                            TextFormField(
                                                              validator: controller
                                                                  .basicValidator
                                                                  .getValidation(
                                                                      'common_name'),
                                                              controller: controller
                                                                  .basicValidator
                                                                  .getController(
                                                                      'common_name'),
                                                              keyboardType:
                                                                  TextInputType
                                                                      .multiline,
                                                              decoration:
                                                                  InputDecoration(
                                                                hintText:
                                                                    "one one braids",
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
                                                              "trending_status"
                                                                  .tr(),
                                                            ),
                                                            FxSpacing.height(8),
                                                            DropdownButtonFormField<
                                                                Trending>(
                                                              dropdownColor:
                                                                  colorScheme
                                                                      .background,
                                                              menuMaxHeight:
                                                                  200,
                                                              isDense: true,

                                                              // itemHeight: 40,
                                                              items:
                                                                  Trending
                                                                      .values
                                                                      .map(
                                                                        (category) =>
                                                                            DropdownMenuItem<Trending>(
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
                                                                    .onChangeTrending(
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
                                                              "minimun_price"
                                                                  .tr()
                                                                  .capitalizeWords,
                                                            ),
                                                            FxSpacing.height(8),
                                                            TextFormField(
                                                              validator: controller
                                                                  .basicValidator
                                                                  .getValidation(
                                                                      'minimun_price'),
                                                              controller: controller
                                                                  .basicValidator
                                                                  .getController(
                                                                      'minimun_price'),
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
                                              FxText.labelMedium(
                                                "status".tr(),
                                              ),
                                              FxSpacing.height(4),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Wrap(
                                                        spacing: 16,
                                                        children: Status.values
                                                            .map(
                                                              (publishStatus) =>
                                                                  InkWell(
                                                                onTap: () => controller
                                                                    .onChangePublishStatus(
                                                                        publishStatus),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    Radio<
                                                                        Status>(
                                                                      value:
                                                                          publishStatus,
                                                                      activeColor: theme
                                                                          .colorScheme
                                                                          .primary,
                                                                      groupValue:
                                                                          controller
                                                                              .selectedPublishStatus,
                                                                      onChanged:
                                                                          controller
                                                                              .onChangePublishStatus,
                                                                      visualDensity:
                                                                          getCompactDensity,
                                                                      materialTapTargetSize:
                                                                          MaterialTapTargetSize
                                                                              .shrinkWrap,
                                                                    ),
                                                                    FxSpacing
                                                                        .width(
                                                                            8),
                                                                    FxText
                                                                        .labelMedium(
                                                                      publishStatus
                                                                          .name
                                                                          .capitalize,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                            .toList()),
                                                  )
                                                ],
                                              ),
                                              // FxSpacing.height(25),
                                              // FxText.labelMedium(
                                              //   "tags".tr(),
                                              // ),
                                              // FxSpacing.height(8),
                                              // Container(
                                              //   alignment: Alignment.topLeft,
                                              //   child: TextFormField(
                                              //     maxLines: 3,
                                              //     validator: controller
                                              //         .basicValidator
                                              //         .getValidation('tags'),
                                              //     controller: controller
                                              //         .basicValidator
                                              //         .getController('tags'),
                                              //     keyboardType:
                                              //         TextInputType.multiline,
                                              //     decoration: InputDecoration(
                                              //       hintText:
                                              //           "trending, queens, loved",
                                              //       hintStyle:
                                              //           FxTextStyle.bodySmall(
                                              //               xMuted: true),
                                              //       border: outlineInputBorder,
                                              //       enabledBorder:
                                              //           outlineInputBorder,
                                              //       focusedBorder:
                                              //           focusedInputBorder,
                                              //       contentPadding:
                                              //           FxSpacing.all(16),
                                              //       isCollapsed: true,
                                              //       floatingLabelBehavior:
                                              //           FloatingLabelBehavior
                                              //               .never,
                                              //     ),
                                              //   ),
                                              // ),
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
