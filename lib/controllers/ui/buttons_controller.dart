import 'package:core_erp/controllers/main_controller.dart';

class ButtonsController extends MainController {
  List<bool> selected = List.filled(3, false);

  ButtonsController() {
    selected[0] = true;
  }

  void onSelect(int index) {
    selected = List.filled(3, false);
    selected[index] = true;
    update();
  }

  @override
  String getTag() {
    return "buttons_controller";
  }
}
