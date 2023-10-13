import 'dart:convert';

import 'package:core_erp/controllers/auth/auth_controller.dart';
import 'package:core_erp/models/person.dart';
import 'package:core_erp/models/vendor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:core_erp/controllers/apps/ecommerce/products_controller.dart';
import 'package:core_erp/controllers/apps/files/file_upload_controller.dart';
import 'package:core_erp/controllers/main_controller.dart';
import 'package:core_erp/models/customer.dart';

import 'package:get/get.dart';
import 'package:core_erp/models/http_responses.dart';

class CustomersController extends MainController {
  List<Customer> customers = [];
  late FileUploadController fileUploadController =
      Get.put(FileUploadController());
  late AuthController authController = Get.put(AuthController());
  late ProductsController productsController = Get.put(ProductsController());
  var isSavingSuccess = false.obs;

  var selectedEmpoyee = Person(
    firstName: '',
    lastName: '',
    accountType: '',
    phone: '',
    city: '',
    neighbourhood: '',
    createdDate: DateTime.now().toString(),
  ).obs;
  @override
  CustomersController();
  late String serverUrl;
  @override
  onInit() async {
    super.onInit();
    Customer.dummyList.then((value) {
      customers = value;
      update();
    });
    await dotenv.load();
    serverUrl = dotenv.get("ENV") == 'emulator'
        ? dotenv.get("EMMULATOR_API_URL")
        : dotenv.get("ENV") == 'device'
            ? dotenv.get("DEVICE_API_URL")
            : dotenv.get("PRODUCTION_API_URL");
    await getAllVendors();
  }

  void goToDashboard() {
    Get.toNamed('/dashboard');
  }

  @override
  String getTag() {
    return 'customers_controller';
  }

  getAllVendors() async {
    try {
      debugPrint('get  All providers $apiUrl');
      isLoading.value = true;
      // Map body = {"text": 'all-providers'};

      var response = await getConnect.get('$serverUrl/users/get-all-providers');
      // debugPrint('searchForStylist res: $response');
      ResponseBody responseBody = await processHttpResponse(response);
      debugPrint('getAllproviders $responseBody');
      if (responseBody.status == 200) {
        // debugPrint(
        //     'searchForStylist responseBody.status == 200 ${responseBody.data} ');
        List jsonDecodedVendors = await jsonDecode(responseBody.data);
        // debugPrint('searchForStylist jsonDecode $jsonDecodedVendors');
        // debugPrint('jsonDecodedVendors length ${jsonDecodedVendors.length}');
        var searchResults = <Provider>[];
        if (jsonDecodedVendors.isNotEmpty) {
          debugPrint('providers is Not Empty');
          for (var req in jsonDecodedVendors) {
            Provider user = await Provider.fromJson(req);
            // debugPrint('provider userID ${user.provider.userID}');

            var providerLoaded = searchResults.firstWhereOrNull(
                (vendr) => vendr.provider.userID == user.provider.userID);
            if (providerLoaded != null) {
              searchResults[searchResults.indexWhere((vendr) =>
                  vendr.provider.userID == user.provider.userID)] = user;
            } else {
              searchResults = [...searchResults, user];
            }
            authController.providers.value = searchResults;
            authController.providers.refresh();
            debugPrint('providers length ${authController.providers.length}');
          }
        } else {
          authController.providers.value = searchResults;
          authController.providers.refresh();
          debugPrint('providers is empty');
        }
      }
      isLoading.value = false;
    } catch (e) {
      debugPrint('$e');
    }
  }
}
