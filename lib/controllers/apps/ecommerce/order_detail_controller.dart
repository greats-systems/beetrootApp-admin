import 'dart:convert';

import 'package:core_erp/controllers/auth/auth_controller.dart';
import 'package:core_erp/models/http_responses.dart';
import 'package:core_erp/models/offerItem.dart';
import 'package:core_erp/models/person.dart';
import 'package:core_erp/models/vendor.dart';
import 'package:core_erp/services/storage/local_storage.dart';
import 'package:get/get.dart';
import 'package:core_erp/controllers/main_controller.dart';
import 'package:core_erp/images.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

import '../../../models/offerItemImage.dart';
import '../../../models/order.dart';
// import 'package:core_erp/models/http_responses.dart';

enum Size {
  small,
  medium,
  large,
  xl;

  const Size();
}

class OrderDetailController extends MainController {
  AuthController authController = Get.put(AuthController());
  FxFormValidator basicValidator = FxFormValidator();
  var order = Order().obs;

  String selectedImage = Images.squareImages[2];
  OfferItemImage get selectedOrderOfferItemImage =>
      order.value.offerItem!.images![0];
  var selectedOrderOfferItemImagePath = '';
  List<String> dummyTexts =
      List.generate(12, (index) => FxTextUtils.getDummyText(60));

  List<String> images = [
    Images.squareImages[2],
    Images.squareImages[3],
    Images.squareImages[5],
    Images.squareImages[4],
  ];

  var defaultIndex = 0.obs;
  int selectedQuntity = 1;
  String selectSize = "Small";
  var orderRequestResponse = ''.obs;
  @override
  onInit() async {
    super.onInit();

    // defaultTabController.addListener(handleTabSelection());
    // if (order.value.offerItem!.images != null) {
    //   selectedOrderOfferItemImagePath =
    //       order.value.offerItem!.images![0].filename.toString();
    //   update();
    // }
  }

  void goToOrderDetail() async {
    String rawJson = jsonEncode(order.toJson());
    LocalStorage.setCurrentSelectedOrder(rawJson);
    order.value = (await LocalStorage.getCurrentSelectedOrder())!;
    debugPrint('order.value orderID: ${order.value.orderID}');
    isLoading.value = true;
    Get.toNamed('/apps/ecommerce/order-detail');
  }

  void onChangeImage(String image) {
    selectedOrderOfferItemImagePath = image;
    update();
  }

  void onSelectedQty(int qty) {
    selectedQuntity = qty;
    update();
  }

  void onSelectedSize(String size) {
    selectSize = size;
    update();
  }

  @override
  String getTag() {
    return "product_detail_controller";
  }

  Future<List<Provider>?> processRequest(Map body) async {
    try {
      var response = await getConnect.post(
          '$apiUrl/offer-items/get-trade-providers', body);
      if (response.body == null) {
        errorMessage.value = 'No connection, Check internet connection';
        isLoading.value = false;
        return null;
      } else {
        ResponseBody responseBody = await processHttpResponse(response);
        if (responseBody.status == 200) {
          // debugPrint(
          //     'searchForStylist responseBody.status == 200 ${responseBody.data} ');
          List jsonDecodedProvider = await jsonDecode(responseBody.data);
          // debugPrint('searchForStylist jsonDecode $jsonDecodedProvider');
          debugPrint('jsonDecodedProvider  ${jsonDecodedProvider}');
          var searchResults = <Provider>[];
          if (jsonDecodedProvider.isNotEmpty) {
            debugPrint('getWarehouseProviders is Not Empty');
            for (var req in jsonDecodedProvider) {
              Provider user = await decodeProvider(req);
              debugPrint(
                  'processRequest provider userID ${user.provider.userID}');
              var providerLoaded = searchResults.firstWhereOrNull(
                  (vendr) => vendr.provider.userID == user.provider.userID);
              if (providerLoaded != null) {
                searchResults[searchResults.indexWhere((vendr) =>
                    vendr.provider.userID == user.provider.userID)] = user;
              } else {
                searchResults = [...searchResults, user];
              }
            }
          }
          debugPrint('processRequest searchResults ${searchResults.length}');
          return searchResults;
        }
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  requestGrading(String trade) async {
    try {
      await getTradeProviders(trade);
      Get.toNamed('/requestGrading');
    } catch (e) {}
  }

// Deserialize a JSON List to create a List of VendorOfferItems
  List<Provider> listFromJson(String jsonStr) {
    final List jsonDataList = jsonDecode(jsonStr);
    return jsonDataList.map((jsonItem) => Provider.fromJson(jsonItem)).toList();
  }

  getTradeProviders(String trade) async {
    try {
      debugPrint('getTradeProviders trade $trade');
      isLoading.value = true;
      Map body = {"tradingAs": trade};
      var providerLoaded = authController.serviceProviders
          .firstWhereOrNull((vendr) => vendr.provider.tradingAs == trade);
      if (providerLoaded == null) {
        var res = (await processRequest(body))!;
        authController.queriedServiceProviders.value = res;
        res.map((e) => authController.serviceProviders.add(e));
        authController.queriedServiceProviders.refresh();
        debugPrint(
            'queriedServiceProviders length ${authController.queriedServiceProviders.length}');
      } else {
        List<Provider> providers = authController.serviceProviders
            .where((Provider provider) => provider.provider.tradingAs == trade)
            .toList();
        authController.queriedServiceProviders.value = providers;
        debugPrint(
            'queriedServiceProviders length ${authController.queriedServiceProviders.length}');
      }

      debugPrint(
          'get Trade Providers length ${authController.serviceProviders.length}');
    } catch (e) {
      debugPrint('$e');
    }
  }

  respondToOrderRequest(String response) {
    orderRequestResponse.value = response;
  }

  decodeProvider(jSonData) async {
    var items = <OfferItem>[];
    // debugPrint('decodeProvider. $jSonData');
    Person person = await Person.fromJson(jSonData);
    for (var itm in jSonData['OfferItems']) {
      var decoded = OfferItem.fromJson(itm);
      items = [...items, decoded];
    }
    var vendr = Provider(provider: person, offerItems: items);
    // debugPrint('vendr ${vendr.offerItems.length}');

    return vendr;
  }

  // WEB SOCKETS EMIT METHODS
  void respondToGradingOrder(String status) {
    debugPrint('request Commodity Grading');
    var ordr;
    if (status == 'accepted') {
      ordr = {
        "orderStatus": 'grading-request-$status',
        "state": status,
        "orderID": order.value.orderID,
        "orderDate": DateTime.now().toString(),
        "customerID": order.value.customer!.userID,
        "providerID": authController.person.value.userID,
        "updatedStatusMessage":
            'your order successfully accepted. We have requested our transporters for pickup date',
        "chainedProviderID":
            authController.selectedQueriedProvider.value.provider.userID,
      };
    }
    if (status == 'rejected') {
      ordr = {
        "orderStatus": 'grading-request-$status',
        "updatedStatusMessage": 'we are fully booked',
        "state": status,
        "orderID": order.value.orderID,
        "providerID": authController.person.value.userID,
        "customerID": order.value.customer!.userID,
      };
    }
    authController.socket.emit('respond-grading-order', {
      "socketID": socketID.value,
      "clientID": authController.person.value.userID,
      "clientPhone": authController.person.value.phone.toString(),
      "order": jsonEncode(ordr),
    });
  }
}
