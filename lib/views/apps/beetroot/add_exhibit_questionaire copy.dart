import 'dart:typed_data';
import 'package:core_erp/views/apps/beetroot/textfield.dart';
import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:core_erp/views/apps/beetroot/dynamic_Input.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:file_picker/file_picker.dart';
import 'package:core_erp/controllers/apps/provider-admin/provider-admin_controller.dart';
import 'package:core_erp/extensions/string.dart';
import 'package:core_erp/services/theme/app_style.dart';
import 'package:core_erp/utils/mixins/ui_mixin.dart';
import 'package:core_erp/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

import '../../../controllers/apps/files/file_upload_controller.dart';

// widget for dynamic text field
class DynamicWidget extends StatelessWidget {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(hintText: 'Enter Data '),
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
  late ProviderAdminController providerAdminController;
  TextEditingController controller = TextEditingController();
  List<TextEditingController> _controllers = [];
  List<TextField> _fields = [];
  late FileUploadController fileUploadController;
  var _displayWidget = DynamicWidget();
  static List<String> questionList = ['hello', 'munya', 'greats'];

  // list to store dynamic text field widgets
  List<DynamicWidget> listDynamic = [];
  void updateWidget(String option) {
    switch (option) {
      case 'Option A':
        _displayWidget = DynamicWidget();
        break;
      case 'Option B':
        _displayWidget = DynamicWidget();
        break;
      default:
        _displayWidget = DynamicWidget();
        break;
    }
  }

  // list to store data
  // entered in text fields
  List<String> data = [];

  // icon for floating action button
  Icon floatingIcon = Icon(Icons.add);

  // function to add dynamic
  // text field widget to list
  addDynamic() {
    // if data is already present, clear
    // it before adding more text fields
    if (data.length != 0) {
      floatingIcon = Icon(Icons.add);
      data = [];
      listDynamic = [];
    }

    // limit number of text fields to 5
    if (listDynamic.length >= 5) {
      return;
    }

    // add new dynamic text field widget to list
    listDynamic.add(DynamicWidget());
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    providerAdminController = Get.put(ProviderAdminController());
    fileUploadController = Get.put(FileUploadController());
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: providerAdminController,
        builder: (providerAdminController) {
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
                                        Spacer(),
                                        FxButton(
                                          onPressed: () {
                                            addDynamic();
                                          },
                                          elevation: 0,
                                          padding: FxSpacing.xy(20, 16),
                                          backgroundColor: contentTheme.success,
                                          borderRadiusAll:
                                              AppStyle.buttonRadius.medium,
                                          child: FxText.bodySmall(
                                            'Add New Question',
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
                                                                Obx(() => providerAdminController
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
                                                                              providerAdminController.onAddExhibitQuestionaire();
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
                                                                providerAdminController
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
                                                              items: providerAdminController
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
                                                                providerAdminController
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
                                                              validator: providerAdminController
                                                                  .basicValidator
                                                                  .getValidation(
                                                                      'salary'),
                                                              controller: providerAdminController
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
                                                              validator: providerAdminController
                                                                  .basicValidator
                                                                  .getValidation(
                                                                      'search_key_words'),
                                                              controller: providerAdminController
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
                                                            // _displayWidget
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

  Widget _addTile() {
    return ListTile(
      title: Icon(Icons.add),
      onTap: () {
        final controller = TextEditingController();
        final field = TextField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "name${_controllers.length + 1}",
          ),
        );

        setState(() {
          _controllers.add(controller);
          _fields.add(field);
        });
      },
    );
  }

  Widget _listView() {
    return ListView.builder(
      itemCount: _fields.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.all(5),
          child: _fields[index],
        );
      },
    );
  }

  Widget _okButton() {
    return ElevatedButton(
      onPressed: () async {
        String text = _controllers
            .where((element) => element.text != "")
            .fold("", (acc, element) => acc += "${element.text}\n");
        final alert = AlertDialog(
          title: Text("Count: ${_controllers.length}"),
          content: Text(text.trim()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
        await showDialog(
          context: context,
          builder: (BuildContext context) => alert,
        );
        setState(() {});
      },
      child: Text("OK"),
    );
  }

  Widget _textfieldBtn(int index) {
    bool isLast = index == questionList.length - 1;

    return InkWell(
      onTap: () => setState(
        () => isLast ? questionList.add('') : questionList.removeAt(index),
      ),
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: isLast ? Colors.green : Colors.red,
        ),
        child: Icon(
          isLast ? Icons.add : Icons.remove,
          color: Colors.white,
        ),
      ),
    );
  }

  questionFields() {
    return ListView.separated(
      itemCount: questionList.length,
      padding: const EdgeInsets.all(20),
      itemBuilder: (context, index) => Row(
        children: [
          DynamicTextfield(
            key: UniqueKey(),
            initialValue: questionList[index],
            onChanged: (v) => questionList[index] = v,
          ),
          const SizedBox(width: 20),
          _textfieldBtn(index),
        ],
      ),
      separatorBuilder: (context, index) => const SizedBox(
        height: 20,
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
