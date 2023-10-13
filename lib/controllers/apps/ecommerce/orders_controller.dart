import 'package:core_erp/models/http_responses.dart';
import 'package:core_erp/services/storage/local_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:core_erp/controllers/main_controller.dart';
// import 'package:core_erp/models/http_responses.dart';

import 'dart:convert' as convert;

import 'package:get/get.dart';

import '../../../models/offerItem.dart';
import '../../../models/order.dart';

class OrdersController extends MainController {
  var currentOrderRequest = Order().obs;
  var selectedOrderRequest = Order().obs;
  var selectedOrder = Order().obs;
  var orderRequests = <Order>[].obs;
  int get totalOrderRequests => orderRequests.length;

  var orders = <Order>[].obs;
  int get totalOrders => orders.length;

  var issuedWHReciepts = <Order>[].obs;
  int get totalIssuedWHReciepts => issuedWHReciepts.length;

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
  OrdersController();

  @override
  onInit() async {
    super.onInit();
    await dotenv.load();
    serverUrl = dotenv.get("ENV") == 'emulator'
        ? dotenv.get("EMMULATOR_API_URL")
        : dotenv.get("ENV") == 'device'
            ? dotenv.get("DEVICE_API_URL")
            : dotenv.get("PRODUCTION_API_URL");
    await getAllAccountOrders();
  }

  processOrders(Order order) async {
    List<Order> allOrders = [];
    bool foundInOrders =
        orders.contains((Order ord) => ord.orderID == order.orderID);

    // debugPrint("order $foundInOrders");
    if (foundInOrders) {
      // debugPrint("orderID != null");
      orders[orders.indexWhere((ord) => ord.orderID == order.orderID)] = order;
      orders.refresh();
    } else {
      // debugPrint("orderID == null");
      // orders.clear();
      orders.value = [...orders, order];
      allOrders = orders;
      LocalStorage.setAccountOrders(allOrders.toString());
      orders.refresh();
    }
    // debugPrint(
    //   "order orderStatus ${order.orderStatus}",
    // );
    if (order.orderStatus == 'grading-request-order' ||
        order.orderStatus == 'client-request' ||
        order.orderStatus == 'vendor-accepted') {
      bool foundInOrderRequest =
          orderRequests.contains((ord) => ord.orderID == order.orderID);
      if (foundInOrderRequest) {
        // debugPrint("orderRequestLoaded.orderID != null");
        orderRequests[orderRequests
            .indexWhere((ord) => ord.orderID == order.orderID)] = order;

        orderRequests.refresh();
      } else {
        // orderRequests.clear();
        orderRequests.value = [...orderRequests, order];

        orderRequests.refresh();
        // newServiceRequest.value = true;
        // newServiceRequest.refresh();
      }
    }

    // debugPrint("orderRequests.length ${orderRequests.length}");
    // debugPrint("orders.length ${orders.length}");
  }

  Future<void> getAllAccountOrders() async {
    try {
      debugPrint('getAllAccountOrders Method serverUrl $serverUrl');
      isLoading.value = true;
      var body = {
        "search": 'person.value.userID',
      };
      // debugPrint('getAllAccountOrders body $body');
      Response<dynamic> response =
          await getConnect.post('$serverUrl/offer-items/get-offer-items', body);
      // debugPrint('getAllAccountOrders response ${response.body}');

      ResponseBody responseBody = await processHttpResponse(response);
      // debugPrint('getAllAccountOrders responseBody $responseBody');
      // debugPrint(
      //     'getAllAccountOrders responseBody status ${responseBody.status}');
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
            // debugPrint('getAllAccountOrders  $item');
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

  void goToCreateOrder() {
    Get.toNamed('/apps/ecommerce/add_order');
  }

  @override
  String getTag() {
    return "ecommerce_orders_controller";
  }
}
