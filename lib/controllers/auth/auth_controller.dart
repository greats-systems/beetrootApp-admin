import 'dart:convert';
import 'package:core_erp/controllers/apps/ecommerce/orders_controller.dart';
import 'package:core_erp/controllers/apps/ecommerce/products_controller.dart';
import 'package:core_erp/controllers/auth/login_controller.dart';
import 'package:core_erp/controllers/main_controller.dart';
import 'package:core_erp/models/http_responses.dart';
// import 'package:core_erp/models/http_responses.dart';
import 'package:core_erp/models/offerItem.dart';
// import 'package:core_erp/models/offer_items.dart';
import 'package:core_erp/models/order.dart';
import 'package:core_erp/models/person.dart';
import 'package:core_erp/models/vendor.dart';
import 'package:core_erp/services/auth_service.dart';
import 'package:core_erp/services/storage/local_storage.dart';
import 'package:core_erp/views/auth/login.dart';
import 'package:core_erp/views/dashboards/admin_dashboard.dart';
import 'package:core_erp/views/dashboards/providers_dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

class AuthController extends MainController {
  FxFormValidator basicValidator = FxFormValidator();
  late ProductsController productsController = Get.put(ProductsController());
  late LoginController loginController = Get.put(LoginController());
  late OrdersController ordersController = Get.put(OrdersController());

  late IO.Socket socket;
  //
  var isLoggedIn = false.obs;
  var authToken = ''.obs;
  var providers = <Provider>[].obs;
  int get totalVendors => providers.length;
  var providersOrders = <Order>[].obs;
  var providerAccountOrders = Order();

  var queriedVendors = <Provider>[].obs;
  int get totalQueriedVendors => queriedVendors.length;
  var selectedQueriedProvidereID = ''.obs;
  var selectedQueriedProvider = Provider(
      provider: Person(
          firstName: 'firstName',
          lastName: 'lastName',
          phone: 'phone',
          accountType: 'accountType'),
      offerItems: <OfferItem>[]).obs;

  var serviceProviders = <Provider>[].obs;
  int get totalServiceProviders => serviceProviders.length;
  var queriedServiceProviders = <Provider>[].obs;
  int get totalQueriedServiceProviders => queriedServiceProviders.length;

  var selectedProvider = Provider(
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
  var provider = Person(
    firstName: '',
    lastName: '',
    accountType: '',
    phone: '',
    createdDate: DateTime.now().toString(),
  ).obs;
  bool showPassword = false, loading = false;
  late List<String> accontTypes = ['individual', 'business', 'government'];
  var selectedAccontType = 'individual'.obs;
  late List<String> tradingAsCategories = [
    'farmer',
    'warehouse',
    'buyer',
    'transporter',
    'auction House'
  ];
  var selectedTradingAsCategory = 'farmer'.obs;
  List<String> providerSpecialization = ['seeds', 'machinery', 'services'];
  @override
  onInit() async {
    super.onInit();
    debugPrint('======AuthController----');
    await initFormData();

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

  onSelectedProvider(Provider account) {
    debugPrint('onSelectedWarehouse $account');
    selectedQueriedProvider.value = account;
    selectedQueriedProvidereID.value = account.provider.userID!;
    debugPrint('Selected bookin $selectedQueriedProvider');
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

  Future<void> onRegister() async {
    if (basicValidator.validateForm()) {
      loading = true;
      update();
      var errors = await AuthService.loginUser(basicValidator.getData());
      if (errors != null) {
        basicValidator.addErrors(errors);
        basicValidator.validateForm();
        basicValidator.clearErrors();
      }
      Get.toNamed('/starter');

      loading = false;
      update();
    }
  }

  onVerify(String otpCode) async {
    debugPrint('onVerify Method $otpCode');
    try {
      isLoading.value = true;
      Map body = {"password": '0000', "email": authPhone.value};
      var response =
          await getConnect.post('${apiUrl}/authentication/onVerifyOTP', body);
      debugPrint('onVerify res: $response');
      if (response.body == null) {
        errorMessage.value = 'No connection, Check internet connection';
        isLoading.value = false;
      } else {
        ResponseBody responseBody = await processHttpResponse(response);
        await processUserData(responseBody);
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
      formErrors.value = true;
      debugPrint('onVerify error $e');
    }
    basicValidator.resetForm();
  }

  Future<void> onHandleSignUp() async {
    try {
      isLoading.value = true;

      if (basicValidator.validateForm()) {
        var valData = basicValidator.getData();
        debugPrint('onHandleSignUp data ${valData}');
        loading = true;
        var body = {
          "firstName": valData['first_name'],
          "lastName": valData['last_name'],
          "phone": valData['phone'],
          "email": valData['email'],
          "neighbourhood": selectedNeighbourhood.value,
          "city": selectedCity.value,
          "accountType": selectedAccontType.value,
          "tradingAs": selectedTradingAsCategory.value,
        };
        update();
        Response<dynamic> response =
            await getConnect.post('${apiUrl}/authentication/signup', body);
        if (response.body == null) {
          errorMessage.value = 'No connection, Check internet connection';
          isLoading.value = false;
        } else {
          ResponseBody responseBody = await processHttpResponse(response);
          isLoading.value = false;
          debugPrint('responseBody $responseBody');
          if (responseBody.status == 500) {
            serverError.value = true;
            errorMessage.value = responseBody.errorMessage!.capitalizeFirst!;
          } else {
            if (responseBody.data != '') {
              OTP otp = await decodeOTP(responseBody);
              debugPrint('OTP responseBody ${otp.phone}');
              LoginDTO loginDTO = LoginDTO(phone: otp.phone);
              debugPrint('loginDTO ${loginDTO.phone}');
              await loginController.onLogin(loginDTO);
            }
          }
          basicValidator.resetForm();
          isLoading.value = false;
        }
      }
    } catch (e) {
      isLoading(false);
      formErrors.value = true;
      formErrorMessage.value = 'Error: ${e.toString()}';
      debugPrint(e.toString());
    }
  }

  void onChangeAccontType(String value) {
    debugPrint('onChangeAccontType $value');
    selectedAccontType.value = value;
    update();
  }

  void onChangeTradingAsCategory(String value) {
    debugPrint('onChangeTradingAsCategory $value');
    selectedTradingAsCategory.value = value;
    update();
  }

  void onChangeShowPassword() {
    showPassword = !showPassword;
    update();
  }

  void goToForgotPassword() {
    Get.toNamed('/auth/forgot_password');
  }

  void gotoRegister() {
    Get.offAllNamed('/auth/register');
  }

  void gotoLogin() {
    Get.toNamed('/auth/login');
  }

  onHandleLogout() async {
    debugPrint('onHandleLogout CALLED');
    await LocalStorage.removeLoggedInUser();
    isLoggedIn.value = false;
    person.value = Person(
      firstName: '',
      lastName: '',
      accountType: '',
      phone: '',
      city: '',
      neighbourhood: '',
      createdDate: DateTime.now().toString(),
    );
    basicValidator.resetForm();
    Get.to(LoginPage());
    AuthService.isLoggedIn = false;
  }

  @override
  String getTag() {
    return "register_controller";
  }

  // WEB SOCKETS LISTENERS
  connectAndListen() async {
    // socket.connect();
    socket.onConnect((_) async {
      debugPrint('socket connected? ${socket.connected}');
      // debugPrint('socket id ${socket.id}');
      isonline.value = true;
      socketID.value = socket.id!;
      if (AuthService.isLoggedIn == true && socket.connected == true) {
        socket.emit('get-providers', {
          "senderID": person.value.userID.toString(),
          "senderPhone": person.value.phone.toString(),
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
      // debugPrint("Socket receive_providers recievedData:  $recievedData");

      var data = await jsonDecode(recievedData);
      List jsonDecodedVendors = await jsonDecode(data['providers']);
      // debugPrint('providers jsonDecode ${jsonDecodedVendors}');
      // List jsonDecodedVendors = jsonDecodedData['data'];
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

  processUserData(ResponseBody responseBody) async {
    try {
      if (responseBody.status == 200) {
        var jSonData = jsonDecode(responseBody.data);
        Person verifiedPerson = await Person.fromJson(jSonData);
        person.value = verifiedPerson;
        await LocalStorage.setLoggedInUser(true);
        String rawJson = jsonEncode(verifiedPerson.toJson());
        LocalStorage.setLoggedInUserData(rawJson);
        LocalStorage.setLoggedInUserToken(jSonData['token']);
        // person.value.inMemoryProfileImage =  File(jsonDecode(await LocalStorage.getProfileImageBytes() as String));;
        person.refresh();
        if (person.value.firstName != '' && person.value.accountType != '') {
          isLoading.value = false;

          debugPrint('Stored User ${person.value.firstName}');
          isLoading.value = false;

          AuthService.isLoggedIn = true;
          if (person.value.userID != null) {
            await connectAndListen();
            await changeOnlineState(true);
          }
          if (person.value.accountType != 'admin') {
            Get.to(const ProviderDashboardPage());
          } else {
            Get.to(const AdminDashboardPage());
          }
        }
        isLoading.value = false;
      }
      if (responseBody.status == 500) {
        errorMessage.value = 'No network connection';
        formErrorMessage.value = 'Connection Error, Check Network connection.';
      }
    } catch (e) {
      isLoading.value = false;
      formErrors.value = true;
      debugPrint('onVerify error $e');
    }
  }

  initFormData() async {
    basicValidator.addField(
      'email',
      required: true,
      label: "Email",
      validators: [FxEmailValidator()],
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'phone',
      required: true,
      label: 'Phone',
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'first_name',
      required: true,
      label: 'First Name',
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'last_name',
      required: true,
      label: 'Last Name',
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'password',
      required: true,
      validators: [FxLengthValidator(min: 6)],
      controller: TextEditingController(),
    );
  }
}
