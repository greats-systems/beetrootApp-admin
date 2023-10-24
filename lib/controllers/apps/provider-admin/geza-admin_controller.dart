import 'dart:async';
import 'dart:convert' as convert;
import 'dart:convert';
import 'package:core_erp/controllers/apps/ecommerce/edit_products_controller.dart';
import 'package:core_erp/controllers/apps/ecommerce/orders_controller.dart';
import 'package:core_erp/controllers/auth/auth_controller.dart';
import 'package:core_erp/controllers/auth/socket_controller.dart';
import 'package:core_erp/models/beetroot/industryOptions.dart';
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

List<Map<String, String>> topTencommercialLogisticsVehicles = [
  {
    'name': 'Semi-Truck (Tractor-Trailer)',
    'type': 'Heavy Truck',
    'description':
        'Large trucks consisting of a tractor unit for the driver and a semi-trailer for cargo. Commonly used for long-distance transport.',
  },
  {
    'name': 'Box Truck (Cube Van)',
    'type': 'Medium Truck',
    'description':
        'Box trucks are typically smaller than semi-trucks and have an enclosed cargo area, making them suitable for local and regional deliveries.',
  },
  {
    'name': 'Refrigerated Truck (Reefer Truck)',
    'type': 'Medium/Heavy Truck',
    'description':
        'Equipped with refrigeration units to transport perishable goods at controlled temperatures.',
  },
  {
    'name': 'Flatbed Truck',
    'type': 'Heavy Truck',
    'description':
        'Open cargo area with no sides or roof, ideal for transporting oversized or irregularly shaped cargo.',
  },
  {
    'name': 'Delivery Van',
    'type': 'Light/Medium Truck',
    'description':
        'Smaller vans commonly used by courier services for urban and suburban deliveries.',
  },
  {
    'name': 'Cargo Van',
    'type': 'Light/Medium Truck',
    'description':
        'Versatile vehicles used for transporting goods in various industries, including construction and service trades.',
  },
  {
    'name': 'Dump Truck',
    'type': 'Heavy Truck',
    'description':
        'Designed for transporting bulk materials like sand, gravel, and construction debris, with a hydraulic system for cargo dumping.',
  },
  {
    'name': 'Tanker Truck',
    'type': 'Heavy Truck',
    'description':
        'Used for transporting liquids, including fuel, chemicals, and food-grade products, with specialized tanks to prevent leaks.',
  },
  {
    'name': 'Tow Truck',
    'type': 'Medium/Heavy Truck',
    'description':
        'Used for transporting disabled or damaged vehicles, essential for roadside assistance and recovery services.',
  },
  {
    'name': 'Lorry',
    'type': 'Heavy Truck',
    'description':
        'In some regions, "lorry" is a term used to refer to large trucks or lorries used for various logistical purposes.',
  },
];

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

enum Admin {
  innocent,
  prossy;

  const Admin();
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

class GezaAdminController extends MainController {
  final socketServiceController = Get.find<SocketServiceController>();

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
  Admin selectedEditor = Admin.innocent;
  Admin selectedAdmin = Admin.innocent;

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
  late List<String> industryCategories = industryOptions;
  var selectedIndustryCategories = 'none'.obs;

  late List<String> jobRoleCategories = industryOptions;
  var selectedJobRoleCategories = 'none'.obs;

  late List<Map<String, String>> commercialLogisticsVehicles =
      topTencommercialLogisticsVehicles;
  var selectedcommercialLogisticsVehicles = 'driver'.obs;

  var accountVehicles = <Vehicle>[].obs;
  int get totalAccountVeicles => accountVehicles.length;
  var serverUrl = ''.obs;
  var serverReponseError = false.obs;
  var serverReponseSuccess = false.obs;
  var serverReponseSuccessMessage = ''.obs;
  var serverReponseErrorMessage = ''.obs;

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
    await socketServiceController.onEmitQuestionnaire(data);
    debugPrint('${data}');
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

  void onChangeEditor(Admin? value) {
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

  onAddBeautyStyle() {}
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
}
