import 'package:core_erp/controllers/main_controller.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapPageController extends MainController {
  GoogleMapController? mapController;

  GoogleMapPageController();

  void onGoogleMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void onSelect(int index) {}

  @override
  String getTag() {
    return "google_map_controller";
  }
}
