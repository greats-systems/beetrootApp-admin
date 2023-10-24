import 'package:core_erp/controllers/apps/provider-admin/provider-admin_controller.dart';
import 'package:core_erp/controllers/apps/provider-admin/job_discover_controller.dart';
import 'package:core_erp/extensions/extensions.dart';
import 'package:core_erp/models/beetroot/questionnaire.dart';
import 'package:core_erp/services/theme/app_style.dart';
import 'package:core_erp/utils/mixins/ui_mixin.dart';
import 'package:core_erp/views/apps/beetroot/build_qsn.dart';
import 'package:core_erp/views/layouts/layout.dart';
import 'package:core_erp/widgets/flexible_autosized_textbox.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class AddExhibitQuestionaire extends StatefulWidget {
  const AddExhibitQuestionaire({Key? key}) : super(key: key);

  @override
  State<AddExhibitQuestionaire> createState() => _AddExhibitQuestionaireState();
}

class _AddExhibitQuestionaireState extends State<AddExhibitQuestionaire>
    with SingleTickerProviderStateMixin, UIMixin {
  late DiscoverController controller;
  late ProviderAdminController providerAdminController;

  List<TextEditingController> _controllers = [];
  List<FxFlex> _fields = [];
  String questions = '';

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller = Get.put(DiscoverController());
    providerAdminController = Get.put(ProviderAdminController());
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
                    //   "Discover",
                    //   fontWeight: 600,
                    //   fontSize: 18,
                    // ),
                    FxBreadcrumb(
                      children: [
                        FxBreadcrumbItem(
                            name: "human_resources_department".tr()),
                        FxBreadcrumbItem(name: "analytics".tr(), active: true),
                      ],
                    ),
                  ],
                ),
              ),
              FxSpacing.height(flexSpacing),
              Padding(
                padding: FxSpacing.x(flexSpacing),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FxFlex(
                      contentPadding: false,
                      children: [
                        FxFlexItem(
                          sizes: "lg-4",
                          child: buildLeftBarMatchingJob(),
                        ),
                        FxFlexItem(
                          sizes: "lg-8",
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _addTile(),
                              buildDiscoveryJobs(),
                            ],
                          ),
                        ),
                      ],
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

  Widget _addTile() {
    return ListTile(
      title: Center(
          child: FxText.titleMedium(
        'Questions',
        fontSize: 14,
        fontWeight: 600,
        color: contentTheme.primary,
      )),
      onTap: () {},
    );
  }





  buildLeftBarMatchingJob() {
    return FxContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FxButton(
                onPressed: () {
                  final controller = TextEditingController();
                  final field = FxFlex(contentPadding: false, children: [
                    FxFlexItem(
                        sizes: 'lg-12 md-12',
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FxText.labelMedium(
                              "Question ${_controllers.length}"
                                  .tr()
                                  .capitalizeWords,
                            ),
                            FxSpacing.height(8),
                            TextFormField(
                              controller: controller,
                              maxLines: 3,
                              validator: providerAdminController.basicValidator
                                  .getValidation('salary'),
                              // controller: providerAdminController.basicValidator
                              //     .getController('salary'),
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                hintText: "exhibit main title",
                                hintStyle: FxTextStyle.bodySmall(xMuted: true),
                                border: outlineInputBorder,
                                enabledBorder: outlineInputBorder,
                                focusedBorder: focusedInputBorder,
                                prefixIcon: FxContainer.none(
                                    margin: FxSpacing.right(12),
                                    alignment: Alignment.center,
                                    color: contentTheme.primary.withAlpha(40),
                                    child: FxText.labelLarge(
                                      "\Q",
                                      color: contentTheme.primary,
                                    )),
                                prefixIconConstraints: BoxConstraints(
                                    maxHeight: 42, minWidth: 50, maxWidth: 50),
                                contentPadding: FxSpacing.all(16),
                                isCollapsed: true,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                              ),
                            ),
                          ],
                        )),
                  ]);

                  setState(() {
                    _controllers.add(controller);
                    _fields.add(field);
                  });
                  String text = _controllers
                      .where((element) => element.text != "")
                      .fold("", (acc, element) => acc += "${element.text};\n");
                  setState(() {
                    questions = text;
                  });
                },
                elevation: 0,
                padding: FxSpacing.xy(20, 16),
                backgroundColor: contentTheme.primary,
                borderRadiusAll: AppStyle.buttonRadius.medium,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.add_outlined,
                      size: 20,
                      color: contentTheme.onPrimary,
                    ),
                    FxSpacing.width(8),
                    FxText.labelMedium(
                      'add_question'.tr().capitalizeWords,
                      color: contentTheme.onPrimary,
                    ),
                  ],
                ),
              ),
              FxButton(
                onPressed: () async {
                  String text = _controllers
                      .where((element) => element.text != "")
                      .fold("", (acc, element) => acc += "${element.text}\n");
                  final alert = AlertDialog(
                    title: Text("Total Questions: ${_controllers.length}"),
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
                elevation: 0,
                padding: FxSpacing.xy(20, 16),
                backgroundColor: contentTheme.primary,
                borderRadiusAll: AppStyle.buttonRadius.medium,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FxSpacing.width(8),
                    FxText.labelMedium(
                      'review_questions'.tr().capitalizeWords,
                      color: contentTheme.onPrimary,
                    ),
                  ],
                ),
              )
            ],
          ),
          FxSpacing.height(20),
          interviewQuestions(),
          FxSpacing.height(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FxButton(
                onPressed: () {},
                elevation: 0,
                padding: FxSpacing.xy(20, 16),
                backgroundColor: Colors.white60,
                borderRadiusAll: AppStyle.buttonRadius.medium,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.add_outlined,
                      size: 20,
                      color: contentTheme.primary,
                    ),
                    FxSpacing.width(8),
                    FxText.labelMedium(
                      'save_draft'.tr().capitalizeWords,
                      color: contentTheme.primary,
                    ),
                  ],
                ),
              ),
              FxButton(
                onPressed: () async {
                  String text = _controllers
                      .where((element) => element.text != "")
                      .fold("", (acc, element) => acc += "${element.text};");
                  providerAdminController.onSaveQuestionaire(text);
                },
                elevation: 0,
                padding: FxSpacing.xy(20, 16),
                backgroundColor: Colors.black87,
                borderRadiusAll: AppStyle.buttonRadius.medium,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.save_as_sharp,
                      size: 20,
                      color: Colors.white,
                    ),
                    FxSpacing.width(8),
                    FxText.labelMedium(
                      'save'.tr().capitalizeWords,
                      color: contentTheme.onPrimary,
                    ),
                  ],
                ),
              )
            ],
          ),
          FxSpacing.height(30),
          FxText.labelMedium(
            "Current Questions".tr(),
          ),
          FxSpacing.height(30),
          // currentQuestionnaire.value
          Obx(() =>
              providerAdminController.currentQuestionnaireLoaded.value == true
                  ? SizedBox(
                      // height: 170,
                      child: ListView.separated(
                        itemCount: providerAdminController
                            .currentQuestionnaire.value.questions!.length,
                        shrinkWrap: true,
                        // scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          Question question = providerAdminController
                              .currentQuestionnaire.value.questions![index];

                          return Container(
                            margin: EdgeInsets.all(5),
                            child: BuildFAQItemWidget(
                              question: question,
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            width: 16,
                          );
                        },
                      ),
                    )
                  : Column()),
          FxText.labelMedium(
            "${questions}",
          ),
        ],
      ),
    );
  }

  Widget interviewQuestions() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      FxFlex(contentPadding: false, children: [
        FxFlexItem(
            sizes: 'lg-6 md-12',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FxText.labelMedium(
                  "editor".tr(),
                ),
                FxSpacing.height(8),
                DropdownButtonFormField<Department>(
                  dropdownColor: colorScheme.background,
                  menuMaxHeight: 200,
                  isDense: true,

                  // itemHeight: 40,
                  items: Department.values
                      .map(
                        (category) => DropdownMenuItem<Department>(
                          value: category,
                          child: FxText.labelMedium(
                            category.name.capitalize,
                          ),
                        ),
                      )
                      .toList(),
                  icon: Icon(
                    Icons.expand_more,
                    size: 20,
                  ),
                  decoration: InputDecoration(
                    hintText: "Select Editor",
                    hintStyle: FxTextStyle.bodySmall(xMuted: true),
                    border: outlineInputBorder,
                    enabledBorder: outlineInputBorder,
                    focusedBorder: focusedInputBorder,
                    contentPadding: FxSpacing.all(14),
                    isCollapsed: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                  ),
                  onChanged: (value) {
                    providerAdminController.onChangeEditor(value);
                  },
                )
              ],
            )),
        FxFlexItem(
            sizes: 'lg-6 md-12',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FxText.labelMedium(
                  "stories_category".tr(),
                ),
                FxSpacing.height(8),
                DropdownButtonFormField<String>(
                  dropdownColor: colorScheme.background,
                  menuMaxHeight: 200,
                  // isDense: true,

                  // itemHeight: 40,
                  items: providerAdminController.industryCategories
                      .map(
                        (category) => DropdownMenuItem<String>(
                          value: category,
                          child: FlexibleAutoSizedText(title: category),
                        ),
                      )
                      .toList(),
                  icon: Icon(
                    Icons.expand_more,
                    size: 20,
                  ),
                  decoration: InputDecoration(
                    hintText: "Select level",
                    hintStyle: FxTextStyle.bodySmall(xMuted: true),
                    border: outlineInputBorder,
                    enabledBorder: outlineInputBorder,
                    focusedBorder: focusedInputBorder,
                    contentPadding: FxSpacing.all(14),
                    isCollapsed: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                  ),
                  onChanged: (value) {
                    providerAdminController.onChangeCategory(value);
                  },
                )
              ],
            )),
      ]),
      FxSpacing.height(30),
      FxFlex(contentPadding: false, children: [
        FxFlexItem(
            sizes: 'lg-6 md-12',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FxText.labelMedium(
                  "title".tr().capitalizeWords,
                ),
                FxSpacing.height(8),
                TextFormField(
                  validator: providerAdminController.basicValidator
                      .getValidation('title'),
                  controller: providerAdminController.basicValidator
                      .getController('title'),
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: "exhibit main title",
                    hintStyle: FxTextStyle.bodySmall(xMuted: true),
                    border: outlineInputBorder,
                    enabledBorder: outlineInputBorder,
                    focusedBorder: focusedInputBorder,
                    prefixIcon: FxContainer.none(
                        margin: FxSpacing.right(12),
                        alignment: Alignment.center,
                        color: contentTheme.primary.withAlpha(40),
                        child: FxText.labelLarge(
                          "\T",
                          color: contentTheme.primary,
                        )),
                    prefixIconConstraints: BoxConstraints(
                        maxHeight: 42, minWidth: 50, maxWidth: 50),
                    contentPadding: FxSpacing.all(16),
                    isCollapsed: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                  ),
                ),
              ],
            )),
        FxFlexItem(
            sizes: 'lg-6 md-12',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FxText.labelMedium(
                  "search_key_words".tr().capitalizeWords,
                ),
                FxSpacing.height(8),
                TextFormField(
                  validator: providerAdminController.basicValidator
                      .getValidation('search_key_words'),
                  controller: providerAdminController.basicValidator
                      .getController('search_key_words'),
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: "money, data, fashion",
                    hintStyle: FxTextStyle.bodySmall(xMuted: true),
                    border: outlineInputBorder,
                    enabledBorder: outlineInputBorder,
                    focusedBorder: focusedInputBorder,
                    prefixIconConstraints: BoxConstraints(
                        maxHeight: 42, minWidth: 50, maxWidth: 50),
                    contentPadding: FxSpacing.all(16),
                    isCollapsed: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                  ),
                ),
              ],
            ))
      ]),
      FxSpacing.height(30),
    ]);
  }

  Widget buildDiscoveryJobs() {
    return SizedBox(
      // height: 170,
      child: ListView.separated(
        itemCount: _fields.length,
        shrinkWrap: true,
        // scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.all(5),
            child: _fields[index],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: 16,
          );
        },
      ),
    );
  }
}
