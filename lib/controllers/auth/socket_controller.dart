import 'dart:async';
import 'dart:convert';
import 'package:core_erp/controllers/apps/ecommerce/orders_controller.dart';
import 'package:core_erp/controllers/apps/ecommerce/products_controller.dart';
import 'package:core_erp/controllers/auth/auth_controller.dart';
import 'package:core_erp/controllers/auth/login_controller.dart';
import 'package:core_erp/controllers/main_controller.dart';
import 'package:core_erp/models/beetroot/exhibit_model.dart';
import 'package:core_erp/models/beetroot/questionnaire.dart';
// import 'package:core_erp/models/http_responses.dart';
import 'package:core_erp/models/offerItem.dart';
// import 'package:core_erp/models/offer_items.dart';
import 'package:core_erp/models/order.dart';
import 'package:core_erp/models/person.dart';
import 'package:core_erp/models/vendor.dart';
import 'package:core_erp/services/auth_service.dart';
import 'package:core_erp/services/storage/local_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

class SocketServiceController extends MainController {
  FxFormValidator basicValidator = FxFormValidator();
  final authController = Get.find<AuthController>();
  late ProductsController productsController = Get.put(ProductsController());
  late LoginController loginController = Get.put(LoginController());
  late OrdersController ordersController = Get.put(OrdersController());

  late IO.Socket socket;
  //
  var providers = <Provider>[].obs;
  int get totalServiceProviders => providers.length;
  var selectedQueriedProvidereID = ''.obs;
  var selectedQueriedProvider = Provider(
      provider: Person(
          firstName: 'firstName',
          lastName: 'lastName',
          phone: 'phone',
          accountType: 'accountType'),
      offerItems: <OfferItem>[]).obs;
  var person = Person(
    firstName: '',
    lastName: '',
    accountType: '',
    phone: '',
    city: '',
    neighbourhood: '',
    createdDate: DateTime.now().toString(),
  ).obs;
  var answeringExhibit = Exhibit().obs;
  var recommendatedQuestionnaires = <Questionnaire>[].obs;
  var selectedQuestionnaire = Questionnaire().obs;
  var answeringQuestionnaire = Questionnaire().obs;

  @override
  onInit() async {
    super.onInit();
    debugPrint('======SocketController----');

    debugPrint('MainController AuthService.authToken ${AuthService.authToken}');
    await AuthService.getAuthToken();
    await AuthService.getAuthUserAccountType();

    socket = IO.io(
        apiUrl.value,
        OptionBuilder()
            .setQuery({'cookie': 'barrs', 'token': AuthService.authToken})
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build());
    socket.connect();
    await connectAndListen();
  }

  changeOnlineState(bool status) async {
    debugPrint('before change ${isonline.value}');
    if (status == true) {
      debugPrint(
          'changeOnlineState status == true ${person.value.userID.toString()}');
      socket.emit('notify-online-status', {
        "content": 'online',
        "senderID": person.value.userID.toString(),
        "senderPhone": person.value.phone.toString(),
      });
    }
    if (status == false) {
      debugPrint(
          'changeOnlineState status == true ${person.value.userID.toString()}');
      socket.emit('notify-online-status', {
        "content": 'offline',
        "senderID": person.value.userID.toString(),
        "senderPhone": person.value.phone.toString(),
      });
    }
    isonline.value = status;
    debugPrint('after change ${isonline.value}');
  }

  @override
  String getTag() {
    return "register_controller";
  }

  Future<Questionnaire?> onEmitQuestionnaire(Map<String, dynamic> data) async {
    debugPrint('emit questionnaire ${authController.person.value.accountType}');
    isLoading.value = true;

    var order = {"service": "save-questionnaire", "data": jsonEncode(data)};
    final completer = Completer<Questionnaire?>(); // Create a Completer

    socket.emitWithAck('save-questionnaire', {
      "clientAuth": authController.person.value.accountType,
      "payload": jsonEncode(order),
    }, ack: (data) async {
      if (data != null) {
        var responseBody = await jsonDecode(data);

        final questionnaire = Questionnaire.fromJson(responseBody);
        print('questionnaire ${questionnaire}');
        completer
            .complete(questionnaire); // Complete the Future with the result
      } else {
        isLoading.value = false;
        print("emit questionnaire server response error");
        completer.complete(null); // Complete with null in case of an error
      }
    });
    return completer.future; // Return the Future from the Completer
  }

  // WEB SOCKETS LISTENERS
  connectAndListen() async {
    // socket.connect();
    socket.onConnect((_) async {
      var authToken = AuthService.authToken;

      debugPrint('socket connected? ${socket.connected}');
      // debugPrint('socket id ${socket.id}');
      isonline.value = true;
      socketID.value = socket.id!;
      if (AuthService.isLoggedIn == true && socket.connected == true) {
        socket.emit('get-providers', {
          "senderID": person.value.userID.toString(),
          "senderPhone": person.value.phone.toString(),
        });
        socket.emit('get-questionnaires', {
          "clientAuth": authToken,
        });
        socket.emit('get-account-offer-items', {
          "senderID": person.value.userID.toString(),
          "senderPhone": person.value.phone.toString(),
          "accountType": person.value.accountType.toString()
        });
        socket.emit('get-account-orders', {
          "senderID": person.value.userID.toString(),
          "senderPhone": person.value.phone.toString(),
          "accountType": person.value.accountType.toString()
        });
      }
    });
    socket.on('receive_questionnaires', (recievedData) async {
      debugPrint("Socket receive Questionnaire Data:  $recievedData");
      var data = jsonDecode(recievedData);
      if (data != null) {
        Questionnaire questionnaire = Questionnaire.fromJson(data);
        debugPrint("receive_questionnaires ${questionnaire}");
        await processQuestionnaires(questionnaire);
      }
    });
    //When an event recieved from server, data is added to the stream
    socket.on('update-online-status', (recievedData) async {
      // debugPrint("update-online-status:  $recievedData");
      var data = await jsonDecode(recievedData);
      // debugPrint('update-online-status data["data"] ${data["socketID"]}');
      if (data["socketID"] != null) {
        isonline.value = true;
        socketID.value = data["socketID"];
      }
    });

    socket.on('order-request-accepted', (recievedData) async {
      debugPrint("order-request-accepted recievedData:  $recievedData");
      var data = await jsonDecode(recievedData);
      // debugPrint('order-request-accepted $data["order"]');
      var jsonDecodeOrder = await jsonDecode(data["order"]);
      Order order = await Order.fromJson(jsonDecodeOrder);
      await ordersController.processOrders(order);
    });

    socket.on('receive_message', (recievedData) {
      debugPrint("Socket _socketCall recievedData:  $recievedData");

      var data = jsonDecode(recievedData);
      var msg = data['message'];
      debugPrint("$msg");
    });
    socket.on('receive-providers', (recievedData) async {
      isServerLive.value = true;
      isonline.value = true;
      var data = await jsonDecode(recievedData);
      List jsonDecodedVendors = await jsonDecode(data['providers']);
      if (jsonDecodedVendors.isNotEmpty) {
        for (var req in jsonDecodedVendors) {
          Provider vndor = await Provider.fromJson(req);
          debugPrint("${vndor.provider.userID}");
          var providerLoaded = providers.firstWhereOrNull(
              (vendr) => vendr.provider.userID == vndor.provider.userID);
          if (providerLoaded != null) {
            providers[providers.indexWhere((vendr) =>
                vendr.provider.userID == vndor.provider.userID)] = vndor;
          } else {
            providers.value = [...providers, vndor];
            providers.refresh();
          }
        }
      } else {
        debugPrint('serviceRequest is empty');
      }
    });
    socket.on('receive-account_orders', (recievedData) async {
      // debugPrint("___________Socket receive account orders__________________");
      var data = await jsonDecode(recievedData);
      // debugPrint('order jsonDecode $data["order"]');
      if (data["orders"] != null) {
        var jsonDecodeOrders = await jsonDecode(data["orders"]);
        for (var ord in jsonDecodeOrders) {
          Order order = Order.fromJson(ord);
          // debugPrint("order order orderID ${order.orderID}");
          await ordersController.processOrders(order);
        }
      }
    });

    socket.on('receive-order-request', (recievedData) async {
      debugPrint("__________Socket receive_order-request____________________");
      var data = await jsonDecode(recievedData);
      var jsonDecodeOrder = await jsonDecode(data["order"]);
      Order order = Order.fromJson(jsonDecodeOrder);
      // debugPrint("order order orderID ${order.orderID}");
      await ordersController.processOrders(order);
    });
    socket.onDisconnect((_) => print('disconnect'));
  }

  updateQuestionnaireResponses(Question respondedQuestion) async {
    debugPrint("updateQuestionnaireResponse");
    debugPrint(
        "updateQuestionnaireResponses respondedQuestion answer'] ${respondedQuestion.answer}");
    debugPrint(
        "answeringQuestionnaire.value.questions!.length'] ${answeringQuestionnaire.value.questions!.length}");
    try {
      answeringQuestionnaire.value.questions![
              answeringQuestionnaire.value.questions!.indexWhere(
                  (Question qsnnaire) => qsnnaire.id == respondedQuestion.id)] =
          respondedQuestion;
      answeringQuestionnaire.refresh();

      Question updatedQuestion = answeringQuestionnaire.value.questions!
          .firstWhere(
              (Question qsnnaire) => qsnnaire.id == respondedQuestion.id);
      debugPrint("updatedQuestion ${updatedQuestion.toJson()}");
    } catch (err) {
      debugPrint('$err');
    }
  }

  processQuestionnaires(Questionnaire questionnaire) async {
    // debugPrint("processAccountCatalogs portfolioID ${portfolio.id}");
    bool foundInQuestionnaires = recommendatedQuestionnaires
        .contains((Questionnaire qsnnaire) => qsnnaire.id == qsnnaire.id);
    // debugPrint("accountCatalog $foundInQuestionnaires");
    if (foundInQuestionnaires) {
      debugPrint("accountCatelogs != null");
      recommendatedQuestionnaires[recommendatedQuestionnaires.indexWhere(
          (qsnnaire) => qsnnaire.id == questionnaire.id)] = questionnaire;
      recommendatedQuestionnaires.refresh();
      String rawJson = jsonEncode(recommendatedQuestionnaires.toJson());
      debugPrint("accountCatelogs rawJson $rawJson");
      await LocalStorage.setRecommendatedQuestionnaires(rawJson);
    } else {
      // debugPrint("accountCatelogs ${portfolio.manager!.id}");
      recommendatedQuestionnaires.value = [
        ...recommendatedQuestionnaires,
        questionnaire
      ];
      String rawJson = jsonEncode(questionnaire);
      // debugPrint("accountCatelogs rawJson $rawJson");

      await LocalStorage.setRecommendatedQuestionnaires(rawJson);
      recommendatedQuestionnaires.refresh();
    }
  }
}
