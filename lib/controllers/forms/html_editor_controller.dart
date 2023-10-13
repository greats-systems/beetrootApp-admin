import 'package:core_erp/controllers/main_controller.dart';

import 'package:html_editor_enhanced/html_editor.dart';

class EditorController extends MainController {
  HtmlEditorController htmlEditorController = HtmlEditorController();

  Callbacks getCallbacks() {
    return Callbacks(
      onFocus: () {
        htmlEditorController.setFocus();
      },
      onInit: () {
        htmlEditorController.setFullScreen();
      },
    );
  }

  @override
  String getTag() {
    return "editor_controller";
  }
}
