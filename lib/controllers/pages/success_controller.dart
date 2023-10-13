import 'package:core_erp/controllers/main_controller.dart';
import 'package:flutx/flutx.dart';

class SuccessController extends MainController {
  List<String> dummyTexts =
      List.generate(12, (index) => FxTextUtils.getDummyText(60));

  @override
  String getTag() {
    return "success_controller";
  }
}
