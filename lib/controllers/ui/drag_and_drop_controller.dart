import 'package:core_erp/controllers/main_controller.dart';
import 'package:core_erp/models/customer.dart';

class DragDropController extends MainController {
  List<Customer> customers = [];

  DragDropController();

  @override
  onInit() async {
    super.onInit();
    Customer.dummyList.then((value) {
      customers = value;
      update();
    });
  }

  void onReorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    Customer customer = customers.removeAt(oldIndex);
    customers.insert(newIndex, customer);
    update();
  }

  @override
  String getTag() {
    return "drag_drop_controller";
  }
}
