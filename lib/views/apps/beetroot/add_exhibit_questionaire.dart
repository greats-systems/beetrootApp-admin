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

// widget for dynamic text field
class DynamicWidget extends StatelessWidget {
  TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: new EdgeInsets.all(8.0),
      child: new TextField(
        controller: controller,
        decoration: new InputDecoration(hintText: 'Enter Data '),
      ),
    );
  }
}

class AddExhibitQuestionaire extends StatefulWidget {
  const AddExhibitQuestionaire({Key? key}) : super(key: key);

  @override
  State<AddExhibitQuestionaire> createState() => _AddExhibitQuestionaireState();
}

class _AddExhibitQuestionaireState extends State<AddExhibitQuestionaire>
    with SingleTickerProviderStateMixin, UIMixin {
  late ProviderAdminController controller;
  late FileUploadController fileUploadController;
  // list to store dynamic text field widgets
  List<DynamicWidget> listDynamic = [];

  // list to store data
  // entered in text fields
  List<String> data = [];

  // icon for floating action button
  Icon floatingIcon = new Icon(Icons.add);

  // function to add dynamic
  // text field widget to list
  addDynamic() {
    // if data is already present, clear
    // it before adding more text fields
    if (data.length != 0) {
      floatingIcon = new Icon(Icons.add);
      data = [];
      listDynamic = [];
    }

    // limit number of text fields to 5
    if (listDynamic.length >= 5) {
      return;
    }

    // add new dynamic text field widget to list
    listDynamic.add(new DynamicWidget());
    setState(() {});
  }

  // function to retrieve data from
  // text fields and display in a list
  submitData() {
    // change icon to back arrow and clear existing data
    floatingIcon = new Icon(Icons.arrow_back);
    data = [];

    // retrieve data from each text field widget and add to data list
    listDynamic.forEach((widget) => data.add(widget.controller.text));

    setState(() {});
    print(data.length);
  }

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
                        FxBreadcrumbItem(
                            name: "New Exhibit Questionaire", active: true),
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
                                                                              controller.onAddExhibitQuestionaire();
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
                                                                      'upload exhibit required files.')
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
                                                                        "Grader particulars are required. Please upload grading certificates, profile image and last reviewed records successful Exhibit grading",
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
                                                                        "Please upload all relevant files",
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
                                                              "editor".tr(),
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
                                                              "stories_category"
                                                                  .tr(),
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
                                                              "title"
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
                                                                    "exhibit main title",
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
                                                                          "\T",
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
                                                              "search_key_words"
                                                                  .tr()
                                                                  .capitalizeWords,
                                                            ),
                                                            FxSpacing.height(8),
                                                            TextFormField(
                                                              validator: controller
                                                                  .basicValidator
                                                                  .getValidation(
                                                                      'search_key_words'),
                                                              controller: controller
                                                                  .basicValidator
                                                                  .getController(
                                                                      'search_key_words'),
                                                              keyboardType:
                                                                  TextInputType
                                                                      .multiline,
                                                              decoration:
                                                                  InputDecoration(
                                                                hintText:
                                                                    "money, data, fashion",
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
                                                        ))
                                                  ]),
                                              FxSpacing.height(30),
                                              FxText.labelMedium(
                                                "add_quations"
                                                    .tr()
                                                    .capitalizeWords,
                                              ),
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
                                                              "main_quote"
                                                                  .tr()
                                                                  .capitalizeWords,
                                                            ),
                                                          ],
                                                        )),
                                                  ]),
                                              FxSpacing.height(30),
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
