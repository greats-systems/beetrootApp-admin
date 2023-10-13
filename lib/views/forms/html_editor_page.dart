import 'package:core_erp/controllers/forms/html_editor_controller.dart';
import 'package:core_erp/utils/mixins/ui_mixin.dart';
import 'package:core_erp/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:html_editor_enhanced/html_editor.dart';

class HtmlEditorPage extends StatefulWidget {
  const HtmlEditorPage({Key? key}) : super(key: key);

  @override
  State<HtmlEditorPage> createState() => _HtmlEditorPageState();
}

class _HtmlEditorPageState extends State<HtmlEditorPage>
    with SingleTickerProviderStateMixin, UIMixin {
  late EditorController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(EditorController());
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        builder: (controller) {
          return Column(
            children: [
              Padding(
                padding: FxSpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FxText.titleMedium(
                      "HTML Editor",
                      fontWeight: 600,
                    ),
                    FxBreadcrumb(
                      children: [
                        FxBreadcrumbItem(name: "Forms"),
                        FxBreadcrumbItem(name: "HTML Editor", active: true),
                      ],
                    ),
                  ],
                ),
              ),
              FxSpacing.height(flexSpacing),
              Padding(
                padding: FxSpacing.x(flexSpacing),
                child: FxContainer.bordered(
                  child: HtmlEditor(
                    callbacks: controller.getCallbacks(),
                    controller: controller.htmlEditorController,
                    htmlEditorOptions: HtmlEditorOptions(
                      adjustHeightForKeyboard: true,
                      hint: 'Your text here...',
                      shouldEnsureVisible: true,
                      // darkMode: ThemeCustomizer.instance.theme==ThemeMode.dark
                    ),
                    htmlToolbarOptions: HtmlToolbarOptions(
                      toolbarPosition: ToolbarPosition.aboveEditor,
                      toolbarType: ToolbarType.nativeScrollable,
                      dropdownBackgroundColor: contentTheme.background,
                      dropdownBoxDecoration: BoxDecoration(
                        color: contentTheme.background,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
