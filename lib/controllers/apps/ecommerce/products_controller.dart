import 'package:core_erp/controllers/auth/auth_controller.dart';
import 'package:core_erp/models/offerItem.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:core_erp/controllers/main_controller.dart';
import 'package:core_erp/models/http_responses.dart';
import 'package:core_erp/models/product.dart';
import 'dart:convert' as convert;

import 'package:get/get.dart';

class ProductsController extends MainController {
  AuthController authController = Get.put(AuthController());
  List<Product> products = [];
  List<String> itemCategories = [
    'hair style',
    'skin & nail treatment',
    'product'
  ];

  var offerItemList = <OfferItem>[].obs;
  int get totalOfferItemList => offerItemList.length;
  var accountOfferItemList = <OfferItem>[].obs;
  int get totalAccountOfferItemList => accountOfferItemList.length;

  late String serverUrl;
  ProductsController();

  @override
  onInit() async {
    super.onInit();

    Product.dummyList.then((value) {
      products = value;
      update();
    });
    await dotenv.load();
    serverUrl = dotenv.get("ENV") == 'emulator'
        ? dotenv.get("EMMULATOR_API_URL")
        : dotenv.get("ENV") == 'device'
            ? dotenv.get("DEVICE_API_URL")
            : dotenv.get("PRODUCTION_API_URL");
    await getAllItemOffers();
  }

  Future<void> getAllItemOffers() async {
    try {
      debugPrint('getAllItemOffers Method serverUrl $serverUrl');
      isLoading.value = true;
      var body = {
        "search": 'person.value.userID',
      };
      // debugPrint('getAllItemOffers body $body');
      Response<dynamic> response =
          await getConnect.post('$serverUrl/offer-items/get-offer-items', body);
      // debugPrint('getAllItemOffers response ${response.body}');

      ResponseBody responseBody = await processHttpResponse(response);
      // debugPrint('getAllItemOffers responseBody $responseBody');
      // debugPrint(
      //     'getAllItemOffers responseBody status ${responseBody.status}');
      isLoading.value = false;

      if (responseBody.status == 500) {
        errorMessage.value = responseBody.errorMessage!.capitalizeFirst!;
      } else {
        List data = convert.jsonDecode(responseBody.data);
        // debugPrint('jsonDecoded data $data');
        // var jSonData = convert.jsonDecode(data);
        debugPrint('jSonData  ${data[0]['itemID']}');

        if (data.isNotEmpty) {
          for (var item in data) {
            // debugPrint('getAllItemOffers  $item');
            OfferItem offerItem = OfferItem.fromJson(item);
            offerItemList.value = [...offerItemList, offerItem];
          }
        }
      }
      isLoading.value = false;
    } catch (e) {
      isLoading(false);
      formErrors.value = true;
      formErrorMessage.value = 'Error: ${e.toString()}';
      debugPrint(e.toString());
    }
  }

  Future<void> getAccountOfferItems() async {
    try {
      debugPrint('getAccountOfferItems Method serverUrl $serverUrl');
      isLoading.value = true;
      var body = {
        "providerID": authController.person.value.userID,
      };
      // debugPrint('getAccountOfferItems body $body');
      Response<dynamic> response =
          await getConnect.post('$serverUrl/offer-items/get-offer-items', body);
      // debugPrint('getAccountOfferItems response ${response.body}');

      ResponseBody responseBody = await processHttpResponse(response);
      // debugPrint('getAccountOfferItems responseBody $responseBody');
      // debugPrint(
      //     'getAccountOfferItems responseBody status ${responseBody.status}');
      isLoading.value = false;

      if (responseBody.status == 500) {
        errorMessage.value = responseBody.errorMessage!.capitalizeFirst!;
      } else {
        List data = convert.jsonDecode(responseBody.data);
        // debugPrint('jsonDecoded data $data');
        // var jSonData = convert.jsonDecode(data);
        debugPrint('jSonData  ${data[0]['itemID']}');

        if (data.isNotEmpty) {
          for (var item in data) {
            // debugPrint('getAccountOfferItems  $item');
            OfferItem offerItem = OfferItem.fromJson(item);
            offerItemList.value = [...offerItemList, offerItem];
          }
        }
      }
      isLoading.value = false;
    } catch (e) {
      isLoading(false);
      formErrors.value = true;
      formErrorMessage.value = 'Error: ${e.toString()}';
      debugPrint(e.toString());
    }
  }

  void goToCreateProduct() {
    Get.toNamed('/apps/ecommerce/add_product');
  }

  void goToProductDetail() {
    Get.toNamed('/apps/ecommerce/product-detail');
  }

  @override
  String getTag() {
    return "ecommerce_products_controller";
  }
}
