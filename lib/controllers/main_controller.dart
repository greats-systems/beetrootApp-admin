import 'package:core_erp/controllers/apps/ecommerce/orders_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:core_erp/models/locations.dart';
import 'package:core_erp/services/theme/theme_customizer.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class MainController extends GetxController {
  // late AuthController authController = Get.put(AuthController());

  var apiUrl = ''.obs;

  var otp1 = ''.obs;
  var authPhone = ''.obs;
  // String apiUrl = 'https://$endpointProd';

  final getConnect = GetConnect(timeout: const Duration(seconds: 30));
  var isServerLive = false.obs;
  var isLoading = false.obs;
  var isLoadingServerConnection = false.obs;
  var isonline = false.obs;
  var socketID = ''.obs;

  String? resultMessage;
  var errorMessage = ''.obs;
  var serverError = false.obs;
  var formErrors = false.obs;
  var formErrorMessage = ''.obs;

  var selectedCity = ''.obs;
  var selectedNeighbourhood = ''.obs;
  var populatedNeighbourhoodsNames = <String>[].obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    initializeDateFormatting(Intl.defaultLocale);
    ThemeCustomizer.addListener((old, newVal) {
      if (old.theme != newVal.theme ||
          (old.currentLanguage.languageName !=
              newVal.currentLanguage.languageName)) {
        update();
      }
    });
    await dotenv.load();
    String serverUrl = dotenv.get("ENV") == 'emulator'
        ? dotenv.get("EMMULATOR_API_URL")
        : dotenv.get("ENV") == 'device'
            ? dotenv.get("DEVICE_API_URL")
            : dotenv.get("PRODUCTION_API_URL");
    apiUrl.value = serverUrl;
  }

  void onSelectedCity(String query) {
    debugPrint('selectedCity $query');
    selectedCity.value = query.toLowerCase();

    for (Province province in locations) {
      CityTown? citySelect = province.cities.firstWhereOrNull(
          (city) => city.name == selectedCity.value.toLowerCase());
      debugPrint('provinces loop data ${province.name}');
      if (citySelect != null && citySelect.neighbourhoods.isNotEmpty) {
        populatedNeighbourhoodsNames.value = [];
        populatedNeighbourhoodsNames.refresh();
        for (Neighbourhood neighbourhood in citySelect.neighbourhoods) {
          debugPrint('Areas ${neighbourhood.name}');

          populatedNeighbourhoodsNames.value = [
            ...populatedNeighbourhoodsNames,
            neighbourhood.name
          ];
        }
        debugPrint('matched ${populatedNeighbourhoodsNames.value}');
        break;
      } else {
        populatedNeighbourhoodsNames.value = [];
        populatedNeighbourhoodsNames.refresh();
      }
    }
  }

  void onSelectedArea(String area) {
    debugPrint('onSelectedArea $area');
    selectedNeighbourhood.value = area;
    debugPrint('Selected selectedNeighbourhood ${selectedNeighbourhood.value}');
  }
}
