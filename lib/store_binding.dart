import 'package:core_erp/controllers/auth/auth_controller.dart';
import 'package:core_erp/controllers/main_controller.dart';
import 'package:core_erp/services/storage/local_storage.dart';
import 'package:get/get.dart';

class StoreBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(MainController());
    Get.lazyPut(() => AuthController());
    LocalStorage.init();
  }
}
