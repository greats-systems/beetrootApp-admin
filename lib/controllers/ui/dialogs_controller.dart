import 'package:core_erp/controllers/main_controller.dart';
import 'package:flutx/flutx.dart';

class DialogsController extends MainController {
  List<String> dummyTexts =
      List.generate(12, (index) => FxTextUtils.getDummyText(60));

  DialogsController();

  @override
  String getTag() {
    return "dialogs_controller";
  }
}
