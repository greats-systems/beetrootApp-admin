import 'dart:async';
import 'dart:convert' as convert;
import 'dart:convert';
import 'package:core_erp/controllers/apps/ecommerce/edit_products_controller.dart';
import 'package:core_erp/controllers/apps/ecommerce/orders_controller.dart';
import 'package:core_erp/controllers/auth/auth_controller.dart';
import 'package:core_erp/controllers/auth/socket_controller.dart';
import 'package:core_erp/models/beetroot/industryOptions.dart';
import 'package:core_erp/models/beetroot/questionnaire.dart';
import 'package:core_erp/models/employee.dart';
import 'package:core_erp/models/order.dart';
import 'package:core_erp/models/person.dart';
import 'package:core_erp/models/vehicle.dart';
import 'package:core_erp/models/vendor.dart';
import 'package:core_erp/services/auth_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:core_erp/controllers/apps/ecommerce/products_controller.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutx/validation/validators/validators.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:flutter/material.dart';
import 'package:flutx/validation/form_validator.dart';
import 'package:get/get.dart';
import 'package:core_erp/controllers/main_controller.dart';
import 'package:core_erp/models/discover.dart';
import 'package:core_erp/controllers/apps/files/file_upload_controller.dart';

import '../../../models/http_responses.dart';

enum JobRole {
  general,
  specialist,
  driver;

  const JobRole();
}

enum VehicleCategory {
  truck,
  semiTruck,
  cargoVan;

  const VehicleCategory();
}

enum Department {
  minnie,
  prossy;

  const Department();
}

enum WarehouseDepartment {
  recieving,
  grading,
  certifying,
  sales;

  const WarehouseDepartment();
}

enum LogisticsDepartment {
  logistics,
  handlers,
  sales;

  const LogisticsDepartment();
}

enum ProviderAdminDepartment {
  unappointed,
  hr,
  finance,
  admin,
  sales;

  const ProviderAdminDepartment();
}

enum Manufacturer {
  benz,
  hundai,
  sino;

  const Manufacturer();
}

enum DeploymentStatus {
  active,
  domant,
  terminated;

  const DeploymentStatus();
}

class ProviderAdminController extends MainController {
  final socketServiceController = Get.put(SocketServiceController());

  List<Discover> jobCandidate = [];
  late FileUploadController fileUploadController =
      Get.put(FileUploadController());
  final authController = Get.put(AuthController());
  final productsController = Get.put(ProductsController());
  final ordersController = Get.put(OrdersController());

  FxFormValidator basicValidator = FxFormValidator();
  Manufacturer selectedManufacturer = Manufacturer.benz;

  String selectJob = "Select Job";
  String selectRating = "Select Rating";
  var selectedJobRole = JobRole.general.obs;
  DeploymentStatus selectedDeploymentStatus = DeploymentStatus.domant;
  VehicleCategory selectedVehicleCategory = VehicleCategory.truck;
  Department selectedEditor = Department.minnie;
  Department selectedDepartment = Department.minnie;
  LogisticsDepartment selectedLogisticsDepartment =
      LogisticsDepartment.logistics;
  WarehouseDepartment selectedWarehouseDepartment = WarehouseDepartment.grading;
  ProviderAdminDepartment selectedProviderAdminDepartment =
      ProviderAdminDepartment.sales;
  var isSavingSuccess = false.obs;
  var employees = <Employee>[].obs;
  int get totalEmployees => employees.length;

  var providers = <Provider>[].obs;
  int get totalProviders => providers.length;

  var queriedEmpoyees = <Employee>[].obs;
  int get totalQueriedEmpoyees => queriedEmpoyees.length;
  var selectedQueriedEmpoyee = Person(
    firstName: '',
    lastName: '',
    accountType: '',
    phone: '',
    city: '',
    neighbourhood: '',
    createdDate: DateTime.now().toString(),
  ).obs;

  var queriedForTaskAssignmentEmpoyees = <Employee>[].obs;
  int get totalQueriedForTaskAssignmentEmpoyees => queriedEmpoyees.length;
  var selectedQueriedForTaskAssignmentEmpoyee = Employee().obs;
  var searchResults = <Employee>[].obs;

  late List<String> beautyStylesOptions = [
    'hair_style',
    'skin_care',
    'nail_care',
    'body_massage',
    'none'
  ];
  var selectedBeautyStylesOptions = 'none'.obs;
  //
  late List<String> industryCategories = industryOptions;
  var selectedIndustryCategories = 'none'.obs;
  //
  late List<String> jobRoleCategories = industryOptions;
  var selectedJobRoleCategories = 'none'.obs;

  var accountVehicles = <Vehicle>[].obs;
  int get totalAccountVeicles => accountVehicles.length;
  var serverUrl = ''.obs;
  var serverReponseError = false.obs;
  var serverReponseSuccess = false.obs;
  var serverReponseSuccessMessage = ''.obs;
  var serverReponseErrorMessage = ''.obs;
  bool marketplaceTrendingStatus = false;
  bool tradingStatus = false;
  bool checked = false, publishStatus = false, newsletter = true;

  var currentQuestionnaire = Questionnaire().obs;
  var currentQuestionnaireLoaded = false.obs;
  @override
  onInit() async {
    super.onInit();
    await dotenv.load();
    serverUrl.value = dotenv.get("ENV") == 'emulator'
        ? dotenv.get("EMMULATOR_API_URL")
        : dotenv.get("ENV") == 'device'
            ? dotenv.get("DEVICE_API_URL")
            : dotenv.get("PRODUCTION_API_URL");
    basicValidator.addField(
      'title',
      label: "title",
      required: true,
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'price',
      label: "price",
      required: true,
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'description',
      label: "description",
      required: true,
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'main_quote',
      label: "main_quote",
      required: true,
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'title',
      label: "title",
      required: true,
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'search_key_words',
      label: "search_key_words",
      required: true,
      controller: TextEditingController(),
    );
    Discover.dummyList.then((value) {
      jobCandidate = value.sublist(0, 16);
      update();
    });
    await getAllEmployees();
    await getAllVehicles();
    // await getAllProviders();
  }

  void changeTradingStatus(bool value) {
    tradingStatus = value;

    update();
  }

  void changeTrendingStatus(bool value) {
    marketplaceTrendingStatus = value;
    update();
  }

  void changePublishStatus(bool value) {
    publishStatus = value;
    update();
  }

  Future<void> onSaveQuestionaire(String text) async {
    var valData = basicValidator.getData();
    debugPrint('onSaveQuestionaire data ${valData}');
    List<String> qlist = text.split(";");
    List<String> search_key_words = valData['search_key_words'].split(",");
    var data = {
      'editor': selectedEditor.name,
      'title': valData['title'],
      'searchTerms': search_key_words,
      'category': selectedIndustryCategories.value,
      'questions': qlist
    };
    Questionnaire? questionnaire =
        await socketServiceController.onEmitQuestionnaire(data);
    if (questionnaire != null) {
      currentQuestionnaire.value = questionnaire;
      currentQuestionnaireLoaded.value = true;
    }
    debugPrint('onSaveQuestionaire questionnaire ${questionnaire}');
  }

  void onSelectedJob(String job) {
    selectJob = job;
    update();
  }

  void onSelectedRating(String rating) {
    selectRating = rating;
    update();
  }

  goToCreateEmployee() {
    Get.toNamed('/add_new_employee');
  }

  goToAssignTask() {
    Get.toNamed('/assign_task');
  }

  goToCreateVehicle() {
    Get.toNamed('/transporter/add_vehicle');
  }

  goToCreatBeautyStyle() {
    Get.toNamed('/beauty-styles/add_beauty-style');
  }

  goToBeautyStyles() {
    Get.toNamed('/beauty-styles');
  }

  goToCreatExhibit() {
    Get.toNamed('/exhibits/add_exhibit');
  }

  goToCreatQuestionaire() {
    Get.toNamed('/exhibits/add_exhibit_questionaire');
  }

  goToAssignExhibitEditingTask() {
    Get.toNamed('/exhibits/assign_exhibit_editing');
  }

  goToAllocateVehicle() {
    Get.toNamed('/transporter/allocate_vehicle');
  }

  void onChangeDepartment(Department? value) {
    debugPrint('onChangePublishStatus $value');

    selectedDepartment = value ?? selectedDepartment;
    update();
  }

  void onChangeDeploymentStatus(DeploymentStatus? value) {
    debugPrint('onChangeDeploymentStatus $value');
    selectedDeploymentStatus = value ?? selectedDeploymentStatus;
    update();
  }

  Future<void> onChangeTaskDepartment(value) async {
    if (authController.person.value.tradingAs == 'transporter') {
      LogisticsDepartment dept = value;
      debugPrint('onChangeTaskDepartment $dept, ${dept.name}');
      selectedLogisticsDepartment = dept;
      await employeesSearchFilter('department', dept.name);
    }
    if (authController.person.value.tradingAs == 'warehouser') {
      WarehouseDepartment dept = value;
      debugPrint('onChangeTaskDepartment $dept, ${dept.name}');
      selectedWarehouseDepartment = dept;
      await employeesSearchFilter('department', dept.name);
    }
    update();
  }

  Future<void> onChangeTaskDeploymentStatus(DeploymentStatus? value) async {
    debugPrint('onChangeTaskDeploymentStatus $value');
    selectedDeploymentStatus = value ?? selectedDeploymentStatus;
    await employeesSearchFilter('deploymentStatus', value!.name);
    update();
  }

  Future<void> onChangeTaskJobRole(String? value) async {
    debugPrint('onChangeTaskJobRole $value');
    selectedJobRoleCategories.value = value ?? selectedJobRoleCategories.value;
    await employeesSearchFilter('jobRole', value!);
    update();
  }

  Future<void> onSelectEmployee(Employee? value) async {
    debugPrint('onSelectEmployee ${value!.employeeID}');
    selectedQueriedForTaskAssignmentEmpoyee.value = value;
  }

  void onChangeManufacturer(Manufacturer? value) {
    debugPrint('onChangeManufacturer $value');
    selectedManufacturer = value ?? selectedManufacturer;
    update();
  }

  void onSelectOrder(Order? value) {
    debugPrint('onChangeManufacturer $value');
    ordersController.selectedOrder.value = value!;
    update();
  }

  void onChangeSelectVehicle(VehicleCategory? value) {
    debugPrint('onChangeSelectVehicle $value');
    selectedVehicleCategory = value ?? selectedVehicleCategory;
    update();
  }

  void onChangeEditor(Department? value) {
    debugPrint('onChangePublishStatus $value');
    selectedEditor = value ?? selectedEditor;
    update();
  }

  void onChangeCategory(String? value) {
    debugPrint('onChangeCategory $value');
    selectedIndustryCategories.value =
        value ?? selectedIndustryCategories.value;
  }

  void onChangeJobRole(String? value) {
    debugPrint('onChangeJobRole $value');
    selectedJobRoleCategories.value = value ?? selectedJobRoleCategories.value;
    update();
  }

  void onChangeBeautyStyleOption(String? value) {
    debugPrint('onChangeBeautyStyleOption $value');
    selectedBeautyStylesOptions.value =
        value ?? selectedBeautyStylesOptions.value;
    update();
  }

  onAddBeautyStyle() async {
    // construct form data
// Send FormData in POST request to upload file
    try {
      isSavingSuccess.value = true;
      debugPrint('onAddBeautyStyle Method');
      var valData = basicValidator.getData();
      debugPrint('onAddBeautyStyle data ${valData}');

      var body = {
        "authToken": authController.authToken.value.toString(),
        "category": selectedBeautyStylesOptions.value,
        "name": valData['title'],
        "price": valData['price'],
        "mainQuote": valData['main_quote'],
        "searchTerms": valData['search_terms'],
        "description": valData['description'],
        "catalogID": 'not_set',
        "tradeStatus": tradingStatus,
        "trendingStatus": marketplaceTrendingStatus,
        "publishStatus": publishStatus,
      };
      debugPrint('onAddBeautyStyle body $body');
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$apiUrl/service-providers/add-new-beauty_service'),
      );
      for (PlatformFile file in fileUploadController.files) {
        // debugPrint('file.path.toString()  ${file.bytes.toString()}');

        List<int> imgBytes = file.bytes!.toList();
        // debugPrint('pickedXFile  $imgBytes');
        final multipartFile = http.MultipartFile.fromBytes('file', imgBytes,
            contentType: MediaType('image', 'jpeg'),
            filename: valData['title']);
        request.files.add(multipartFile);
      }
      // debugPrint('multipartFile  ${request.files}');

      request.fields['admin'] = authController.person.value.userID.toString();
      request.fields['service-item'] = jsonEncode(body);

      request.headers.addAll(
          {"Content-Type": "multipart/form-data", 'cookie': jsonEncode(body)});
      final responseStream = await request.send();
      final response = await http.Response.fromStream(responseStream);
      debugPrint('onAddBeautyStyle response ${response.body}');

      var decodedResponse = jsonDecode(response.body);
      var jSonData = jsonDecode(decodedResponse['data']);

      Vehicle vehicle = Vehicle.fromJson(jSonData);

      var vehicleExist = accountVehicles
          .firstWhereOrNull((vh) => vh.vehicleID == vehicle.vehicleID);

      if (vehicleExist != null) {
        accountVehicles[accountVehicles
            .indexWhere((vh) => vh.vehicleID == vehicle.vehicleID)] = vehicle;
      } else {
        accountVehicles.value = [...accountVehicles, vehicle];
      }

      Timer(const Duration(seconds: 1), () {
        isSavingSuccess.value = false;
        Get.toNamed('/vehicles');
      });
      isSavingSuccess.value = false;

      // Do something with the response
    } catch (err) {
      // Handle errors
      isSavingSuccess.value = false;

      print(err);
    }
  }

  onAddNewTruck() async {
    // construct form data
// Send FormData in POST request to upload file
    try {
      isSavingSuccess.value = true;
      debugPrint('onAddNewTruck Method');
      var valData = basicValidator.getData();
      debugPrint('onAddNewTruck data ${valData}');

      var body = {
        "authToken": authController.authToken.value.toString(),
        "vehicleClass": selectedVehicleCategory.name,
        "manufacturer": selectedManufacturer.name,
        "carryingWeightMax": valData['carrying_weight_max'],
        "carryingWeightMin": valData['carrying_weight_min'],
        "engineNumber": valData['engine_number'],
        "gvtRegNumber": valData['gvt_reg_number'],
        "description": valData['description'],
      };
      debugPrint('onAddNewTruck body $body');
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$apiUrl/provider-admin/add-new-vehicle'),
      );
      for (PlatformFile file in fileUploadController.files) {
        // debugPrint('file.path.toString()  ${file.bytes.toString()}');

        List<int> imgBytes = file.bytes!.toList();
        // debugPrint('pickedXFile  $imgBytes');
        final multipartFile = http.MultipartFile.fromBytes('file', imgBytes,
            contentType: MediaType('image', 'jpeg'),
            filename: valData['first_name']);
        request.files.add(multipartFile);
      }
      // debugPrint('multipartFile  ${request.files}');

      request.fields['owner'] = authController.person.value.userID.toString();
      request.fields['new-vehicle-request'] = jsonEncode(body);

      request.headers.addAll(
          {"Content-Type": "multipart/form-data", 'cookie': jsonEncode(body)});
      final responseStream = await request.send();
      final response = await http.Response.fromStream(responseStream);
      debugPrint('onAddNewTruck response ${response.body}');

      var decodedResponse = jsonDecode(response.body);
      var jSonData = jsonDecode(decodedResponse['data']);

      Vehicle vehicle = Vehicle.fromJson(jSonData);

      var vehicleExist = accountVehicles
          .firstWhereOrNull((vh) => vh.vehicleID == vehicle.vehicleID);

      if (vehicleExist != null) {
        accountVehicles[accountVehicles
            .indexWhere((vh) => vh.vehicleID == vehicle.vehicleID)] = vehicle;
      } else {
        accountVehicles.value = [...accountVehicles, vehicle];
      }

      Timer(const Duration(seconds: 1), () {
        isSavingSuccess.value = false;
        Get.toNamed('/vehicles');
      });
      isSavingSuccess.value = false;

      // Do something with the response
    } catch (err) {
      // Handle errors
      isSavingSuccess.value = false;

      print(err);
    }
  }

  onAddExhibitQuestionaire() {}

  onAddExhibit() async {
    // construct form data
// Send FormData in POST request to upload file
    try {
      isSavingSuccess.value = true;
      debugPrint('onAddExhibit Method');
      var valData = basicValidator.getData();
      debugPrint('onAddExhibit common_name ${valData}');

      var body = {
        "authToken": await AuthService.getAuthToken(),
        "vendorID": 'admin',
        "firstName": valData['first_name'],
        "lastName": valData['last_name'],
        "streetAddress": valData['street_address'],
        "phone": valData['phone_number'],
        "salary": valData['salary'],
        "neighbourhood": selectedNeighbourhood.value,
        "city": selectedCity.value,
        "accountType": 'employee',
        "department": selectedDepartment.name,
        "jobRole": selectedJobRoleCategories.value,
        "deploymentStatus": selectedDeploymentStatus.name,
      };
      debugPrint('onAddExhibit common_name ${body}');
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$apiUrl/users/add-employee'),
      );
      for (PlatformFile file in fileUploadController.files) {
        // debugPrint('file.path.toString()  ${file.bytes.toString()}');

        List<int> imgBytes = file.bytes!.toList();
        // debugPrint('pickedXFile  $imgBytes');
        final multipartFile = http.MultipartFile.fromBytes('file', imgBytes,
            contentType: MediaType('image', 'jpeg'),
            filename: valData['first_name']);
        request.files.add(multipartFile);
      }
      // debugPrint('multipartFile  ${request.files}');

      request.fields['owner'] = authController.person.value.userID.toString();
      request.fields['employee'] = jsonEncode(body);

      request.headers.addAll(
          {"Content-Type": "multipart/form-data", 'cookie': jsonEncode(body)});
      final responseStream = await request.send();
      final response = await http.Response.fromStream(responseStream);
      debugPrint('onAddExhibit response $response');

      var decodedResponse = jsonDecode(response.body);
      debugPrint('onAddExhibit response ${response.body}');
      if (decodedResponse['status'] != 201) {
        serverReponseError.value = true;
        serverReponseErrorMessage.value = decodedResponse['errorMessage'];
      }
      if (decodedResponse['status'] == 201) {
        serverReponseSuccess.value = true;
        serverReponseSuccessMessage.value = decodedResponse['successMessage'];
        await getAllEmployees();
        Timer(const Duration(seconds: 1), () {
          isSavingSuccess.value = false;
          Get.toNamed('/apps/hr/employees');
        });
        isSavingSuccess.value = false;
      }

      // Do something with the response
    } catch (err) {
      // Handle errors
      isSavingSuccess.value = false;

      print(err);
    }
  }

  onAddNewEmployee() async {
    // construct form data
// Send FormData in POST request to upload file
    try {
      isSavingSuccess.value = true;
      debugPrint('onAddNewEmployee Method');
      var valData = basicValidator.getData();
      debugPrint('onAddNewEmployee common_name ${valData}');

      var body = {
        "authToken": await AuthService.getAuthToken(),
        "vendorID": 'admin',
        "firstName": valData['first_name'],
        "lastName": valData['last_name'],
        "streetAddress": valData['street_address'],
        "phone": valData['phone_number'],
        "salary": valData['salary'],
        "neighbourhood": selectedNeighbourhood.value,
        "city": selectedCity.value,
        "accountType": 'employee',
        "department": selectedDepartment.name,
        "jobRole": selectedJobRoleCategories.value,
        "deploymentStatus": selectedDeploymentStatus.name,
      };
      debugPrint('onAddNewEmployee common_name ${body}');
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$apiUrl/users/add-employee'),
      );
      for (PlatformFile file in fileUploadController.files) {
        // debugPrint('file.path.toString()  ${file.bytes.toString()}');

        List<int> imgBytes = file.bytes!.toList();
        // debugPrint('pickedXFile  $imgBytes');
        final multipartFile = http.MultipartFile.fromBytes('file', imgBytes,
            contentType: MediaType('image', 'jpeg'),
            filename: valData['first_name']);
        request.files.add(multipartFile);
      }
      // debugPrint('multipartFile  ${request.files}');

      request.fields['owner'] = authController.person.value.userID.toString();
      request.fields['employee'] = jsonEncode(body);

      request.headers.addAll(
          {"Content-Type": "multipart/form-data", 'cookie': jsonEncode(body)});
      final responseStream = await request.send();
      final response = await http.Response.fromStream(responseStream);
      debugPrint('onAddNewEmployee response $response');

      var decodedResponse = jsonDecode(response.body);
      debugPrint('onAddNewEmployee response ${response.body}');
      if (decodedResponse['status'] != 201) {
        serverReponseError.value = true;
        serverReponseErrorMessage.value = decodedResponse['errorMessage'];
      }
      if (decodedResponse['status'] == 201) {
        serverReponseSuccess.value = true;
        serverReponseSuccessMessage.value = decodedResponse['successMessage'];
        await getAllEmployees();
        // var jSonData = jsonDecode(decodedResponse['data']);
        // Employee decodeEmployee = Employee.fromJson(jSonData);
        // if (decodeEmployee.employeeID != null) {
        //   var decodeEmployeeExist = employees.firstWhereOrNull(
        //       (employee) => employee.employeeID == decodeEmployee.employeeID);

        //   if (decodeEmployeeExist != null) {
        //     employees[employees.indexWhere((employee) =>
        //             employee.employeeID == decodeEmployee.employeeID)] =
        //         decodeEmployee;
        //   } else {
        //     employees.value = [...employees, decodeEmployee];
        //   }
        // }

        Timer(const Duration(seconds: 1), () {
          isSavingSuccess.value = false;
          Get.toNamed('/apps/hr/employees');
        });
        isSavingSuccess.value = false;
      }

      // Do something with the response
    } catch (err) {
      // Handle errors
      isSavingSuccess.value = false;

      print(err);
    }
  }

  onAssignTask() async {
    // construct form data
// Send FormData in POST request to upload file
    try {
      isSavingSuccess.value = true;
      debugPrint('onAddNewEmployee Method');
      var valData = basicValidator.getData();
      debugPrint('onAddNewEmployee common_name ${valData}');

      var body = {
        "authToken": await AuthService.getAuthToken(),
        "vendorID": 'admin',
        "firstName": valData['first_name'],
        "lastName": valData['last_name'],
        "streetAddress": valData['street_address'],
        "phone": valData['phone_number'],
        "salary": valData['salary'],
        "neighbourhood": selectedNeighbourhood.value,
        "city": selectedCity.value,
        "accountType": 'employee',
        "department": selectedDepartment.name,
        "jobRole": selectedJobRoleCategories.value,
        "deploymentStatus": selectedDeploymentStatus.name,
      };
      debugPrint('onAddNewEmployee common_name ${body}');
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$apiUrl/users/add-employee'),
      );
      for (PlatformFile file in fileUploadController.files) {
        // debugPrint('file.path.toString()  ${file.bytes.toString()}');

        List<int> imgBytes = file.bytes!.toList();
        // debugPrint('pickedXFile  $imgBytes');
        final multipartFile = http.MultipartFile.fromBytes('file', imgBytes,
            contentType: MediaType('image', 'jpeg'),
            filename: valData['first_name']);
        request.files.add(multipartFile);
      }
      // debugPrint('multipartFile  ${request.files}');

      request.fields['owner'] = authController.person.value.userID.toString();
      request.fields['employee'] = jsonEncode(body);

      request.headers.addAll(
          {"Content-Type": "multipart/form-data", 'cookie': jsonEncode(body)});
      final responseStream = await request.send();
      final response = await http.Response.fromStream(responseStream);
      debugPrint('onAddNewEmployee response $response');

      var decodedResponse = jsonDecode(response.body);
      debugPrint('onAddNewEmployee response ${response.body}');
      if (decodedResponse['status'] != 201) {
        serverReponseError.value = true;
        serverReponseErrorMessage.value = decodedResponse['errorMessage'];
      }
      if (decodedResponse['status'] == 201) {
        serverReponseSuccess.value = true;
        serverReponseSuccessMessage.value = decodedResponse['successMessage'];
        await getAllEmployees();
        // var jSonData = jsonDecode(decodedResponse['data']);
        // Employee decodeEmployee = Employee.fromJson(jSonData);
        // if (decodeEmployee.employeeID != null) {
        //   var decodeEmployeeExist = employees.firstWhereOrNull(
        //       (employee) => employee.employeeID == decodeEmployee.employeeID);

        //   if (decodeEmployeeExist != null) {
        //     employees[employees.indexWhere((employee) =>
        //             employee.employeeID == decodeEmployee.employeeID)] =
        //         decodeEmployee;
        //   } else {
        //     employees.value = [...employees, decodeEmployee];
        //   }
        // }

        Timer(const Duration(seconds: 1), () {
          isSavingSuccess.value = false;
          Get.toNamed('/apps/hr/employees');
        });
        isSavingSuccess.value = false;
      }

      // Do something with the response
    } catch (err) {
      // Handle errors
      isSavingSuccess.value = false;

      print(err);
    }
  }

  getAllEmployees() async {
    try {
      debugPrint('get  All Employees');
      isLoading.value = true;
      // Map body = {"text": 'all-employees'};
      // debugPrint('body res id: ${authController.person.value.userID}');
      // debugPrint('body apiUrl: $apiUrl');

      var response = await getConnect.get(
        '${serverUrl}/provider-admin/get-all-employees/${authController.person.value.userID}',
      );
      // debugPrint('body res: ${response.body}');
      ResponseBody responseBody = await processHttpResponse(response);
      // debugPrint('getAllEmployees $responseBody');

      if (responseBody.status == 200) {
        // debugPrint(
        //     'searchForStylist responseBody.status == 200 ${responseBody.data} ');
        List jsonDecodedVendors = await jsonDecode(responseBody.data);
        // debugPrint('searchForStylist jsonDecode $jsonDecodedVendors');
        // debugPrint('jsonDecodedVendors length ${jsonDecodedVendors.length}');
        var searchResults = <Employee>[];
        if (jsonDecodedVendors.isNotEmpty) {
          debugPrint('Employees is Not Empty');
          for (var req in jsonDecodedVendors) {
            Employee employee = Employee.fromJson(req);
            // debugPrint(
            //     'employee.employeeID ${employee.employeeID}, ${employee.department}, ${employee.jobRole}, ${employee.deploymentStatus}');

            var vendorLoaded = searchResults.firstWhereOrNull(
                (emp) => emp.employeeID == employee.employeeID);
            if (vendorLoaded != null) {
              searchResults[searchResults.indexWhere(
                  (emp) => emp.employeeID == employee.employeeID)] = employee;
            } else {
              searchResults = [...searchResults, employee];
            }
            employees.value = searchResults;
            employees.refresh();
          }
        } else {
          employees.value = searchResults;
          employees.refresh();
          debugPrint('getAllEmployees is empty');
        }
      }
      debugPrint('Account employees length ${employees.length}');

      isLoading.value = false;
    } catch (e) {
      debugPrint('$e');
    }
  }

  getAllVehicles() async {
    try {
      debugPrint('get  All Vehicles');
      isLoading.value = true;
      // Map body = {"text": 'all-employees'};
      var response = await getConnect.get(
          '$serverUrl/provider-admin/get-account-vehicles/${authController.person.value.userID}');
      // debugPrint('getAllEmployees response ${response.body}');

      ResponseBody responseBody = await processHttpResponse(response);
      // debugPrint('getAllEmployees ${responseBody.data}');
      if (responseBody.status == 200) {
        List jsonDecodedVehicles = await jsonDecode(responseBody.data);
        var searchResults = <Vehicle>[];
        if (jsonDecodedVehicles.isNotEmpty) {
          debugPrint('Vehicle is Not Empty');
          for (var req in jsonDecodedVehicles) {
            Vehicle vehicle = Vehicle.fromJson(req);
            // debugPrint('jsonDecodedVehicles req ${vehicle.vehicleID}');

            var vehicleExist = accountVehicles
                .firstWhereOrNull((vh) => vh.vehicleID == vehicle.vehicleID);

            if (vehicleExist != null) {
              accountVehicles[accountVehicles.indexWhere(
                  (vh) => vh.vehicleID == vehicle.vehicleID)] = vehicle;
            } else {
              accountVehicles.value = [...accountVehicles, vehicle];
            }
            accountVehicles.refresh();
          }
        } else {
          accountVehicles.value = searchResults;
          accountVehicles.refresh();
          debugPrint('searchVehicle is empty');
        }
      }
      debugPrint('accountVehicles length ${accountVehicles.length}');

      isLoading.value = false;
    } catch (e) {
      debugPrint('$e');
    }
  }

  getAllProviders() async {
    try {
      debugPrint('get All Providers');
      isLoading.value = true;
      // Map body = {"text": 'all-employees'};
      var response = await getConnect.get('$serverUrl/users/get-all-providers');
      // debugPrint('searchForStylist res: $response');
      ResponseBody responseBody = await processHttpResponse(response);
      debugPrint('getAllProviders respo $responseBody');

      if (responseBody.status == 200) {
        // debugPrint(
        //     'searchForStylist responseBody.status == 200 ${responseBody.data} ');
        List jsonDecodedVendors = await jsonDecode(responseBody.data);
        // debugPrint('searchForStylist jsonDecode $jsonDecodedVendors');
        // debugPrint('jsonDecodedVendors length ${jsonDecodedVendors.length}');
        var searchResults = <Provider>[];
        if (jsonDecodedVendors.isNotEmpty) {
          debugPrint('Providers is Not Empty');
          for (var req in jsonDecodedVendors) {
            Provider user = Provider.fromJson(req);
            // debugPrint('vendor userID ${user.vendor.userID}');

            var vendorLoaded = searchResults.firstWhereOrNull(
                (vendr) => vendr.provider.userID == user.provider.userID);
            if (vendorLoaded != null) {
              searchResults[searchResults.indexWhere((vendr) =>
                  vendr.provider.userID == user.provider.userID)] = user;
            } else {
              searchResults = [...searchResults, user];
            }
            providers.value = searchResults;
            providers.refresh();
            debugPrint('employees length ${employees.length}');
          }
        } else {
          providers.value = searchResults;
          providers.refresh();
          debugPrint('Providers is empty');
        }
      }
      isLoading.value = false;
    } catch (e) {
      debugPrint('$e');
    }
  }

  @override
  String getTag() {
    return "job_candidate_controller";
  }

  Future<List<Employee>?> employeesSearchFilter(
      String searchParameter, String searchValue) async {
    try {
      if (employees.isNotEmpty) {
        // debugPrint('employees is Not Empty');

        // ------------- Filter by department ---------------------------
        if (searchParameter == 'department') {
          queriedForTaskAssignmentEmpoyees.value = [];
          selectedQueriedForTaskAssignmentEmpoyee.value = Employee();
          queriedForTaskAssignmentEmpoyees.refresh();
          selectedQueriedForTaskAssignmentEmpoyee.refresh();
          for (Employee employee in employees) {
            // debugPrint('employee core data');
            debugPrint(
                '${employee.employeeID}, ${employee.department} ${employee.jobRole},  ${employee.deploymentStatus}');
            if (employee.department == searchValue &&
                queriedForTaskAssignmentEmpoyees.firstWhereOrNull(
                        (emp) => emp.employeeID == employee.employeeID) ==
                    null) {
              // debugPrint(
              //     'employee from employees list:: employeeID ${employee.employeeID}: ${employee.department}');
              queriedForTaskAssignmentEmpoyees.value = [
                ...queriedForTaskAssignmentEmpoyees,
                employee
              ];
              queriedForTaskAssignmentEmpoyees.refresh();
              selectedQueriedForTaskAssignmentEmpoyee.value =
                  queriedForTaskAssignmentEmpoyees[0];
            } else if (employee.department != searchValue &&
                queriedForTaskAssignmentEmpoyees.firstWhereOrNull(
                        (emp) => emp.employeeID == employee.employeeID) !=
                    null) {
              queriedForTaskAssignmentEmpoyees
                  .removeWhere((emp) => emp.employeeID == employee.employeeID);
              queriedForTaskAssignmentEmpoyees.refresh();
              selectedQueriedForTaskAssignmentEmpoyee.value =
                  queriedForTaskAssignmentEmpoyees[0];
            }
          }
        }
        // ------------- Filter by deploymentStatus ---------------------------

        if (searchParameter == 'deploymentStatus' &&
            queriedForTaskAssignmentEmpoyees.isNotEmpty) {
          queriedForTaskAssignmentEmpoyees
              .removeWhere((emp) => emp.deploymentStatus != searchValue);
          selectedQueriedForTaskAssignmentEmpoyee.value =
              queriedForTaskAssignmentEmpoyees[0];
        } else if (searchParameter == 'deploymentStatus' &&
            queriedForTaskAssignmentEmpoyees.isEmpty) {
          await employeesDepartmentSearchFilter('');
          queriedForTaskAssignmentEmpoyees
              .removeWhere((emp) => emp.deploymentStatus != searchValue);
          selectedQueriedForTaskAssignmentEmpoyee.value =
              queriedForTaskAssignmentEmpoyees[0];
        }
        // ------------- Filter by jobRole ---------------------------

        if (searchParameter == 'jobRole' &&
            queriedForTaskAssignmentEmpoyees.isNotEmpty) {
          queriedForTaskAssignmentEmpoyees
              .removeWhere((emp) => emp.jobRole != searchValue);
          selectedQueriedForTaskAssignmentEmpoyee.value =
              queriedForTaskAssignmentEmpoyees[0];
        } else if (searchParameter == 'jobRole' &&
            queriedForTaskAssignmentEmpoyees.isEmpty) {
          await employeesDepartmentSearchFilter('');
          queriedForTaskAssignmentEmpoyees
              .removeWhere((emp) => emp.jobRole != searchValue);
          selectedQueriedForTaskAssignmentEmpoyee.value =
              queriedForTaskAssignmentEmpoyees[0];
        }
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<List<Employee>?> employeesDepartmentSearchFilter(
      String searchValue) async {
    try {
      if (employees.isNotEmpty) {
        // debugPrint('employees Department Search Filter');
        // ------------- Filter by department ---------------------------
        if (searchValue == '') {
          for (Employee employee in employees) {
            if (employee.department == selectedDepartment.name &&
                queriedForTaskAssignmentEmpoyees.firstWhereOrNull(
                        (emp) => emp.employeeID == employee.employeeID) ==
                    null) {
              // debugPrint(
              //     'employee from employees list:: employeeID ${employee.employeeID}: ${employee.department}');
              queriedForTaskAssignmentEmpoyees.value = [
                ...queriedForTaskAssignmentEmpoyees,
                employee
              ];
              queriedForTaskAssignmentEmpoyees.refresh();
              selectedQueriedForTaskAssignmentEmpoyee.value =
                  queriedForTaskAssignmentEmpoyees[0];
            } else if (employee.department != searchValue &&
                queriedForTaskAssignmentEmpoyees.firstWhereOrNull(
                        (emp) => emp.employeeID == employee.employeeID) !=
                    null) {
              queriedForTaskAssignmentEmpoyees
                  .removeWhere((emp) => emp.employeeID == employee.employeeID);
              queriedForTaskAssignmentEmpoyees.refresh();
              selectedQueriedForTaskAssignmentEmpoyee.value =
                  queriedForTaskAssignmentEmpoyees[0];
            }
            // debugPrint(
            //     'department queriedForTaskAssignmentEmpoyees ${queriedForTaskAssignmentEmpoyees.length}');
          }
        } else {
          for (Employee employee in employees) {
            if (employee.department == searchValue &&
                queriedForTaskAssignmentEmpoyees.firstWhereOrNull(
                        (emp) => emp.employeeID == employee.employeeID) ==
                    null) {
              // debugPrint(
              //     'employee from employees list:: employeeID ${employee.employeeID}: ${employee.department}');
              queriedForTaskAssignmentEmpoyees.value = [
                ...queriedForTaskAssignmentEmpoyees,
                employee
              ];
              queriedForTaskAssignmentEmpoyees.refresh();
              selectedQueriedForTaskAssignmentEmpoyee.value =
                  queriedForTaskAssignmentEmpoyees[0];
            } else if (employee.department != searchValue &&
                queriedForTaskAssignmentEmpoyees.firstWhereOrNull(
                        (emp) => emp.employeeID == employee.employeeID) !=
                    null) {
              queriedForTaskAssignmentEmpoyees
                  .removeWhere((emp) => emp.employeeID == employee.employeeID);
              queriedForTaskAssignmentEmpoyees.refresh();
              selectedQueriedForTaskAssignmentEmpoyee.value =
                  queriedForTaskAssignmentEmpoyees[0];
            }
            // debugPrint(
            //     'department queriedForTaskAssignmentEmpoyees ${queriedForTaskAssignmentEmpoyees.length}');
          }
        }
      }
    } catch (e) {
      return null;
    }
    return null;
  }
}
