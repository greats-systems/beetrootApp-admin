import 'package:core_erp/controllers/other/google_map_controller.dart';
import 'package:core_erp/extensions/extensions.dart';
import 'package:core_erp/utils/mixins/ui_mixin.dart';
import 'package:core_erp/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_flutter_web/google_maps_flutter_web.dart';

class GoogleMapPage extends StatefulWidget {
  const GoogleMapPage({super.key});

  @override
  _GoogleMapPageState createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage>
    with SingleTickerProviderStateMixin, UIMixin {
  late GoogleMapPageController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(GoogleMapPageController());
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
        child: GetBuilder<GoogleMapPageController>(
            init: controller,
            builder: (controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: FxSpacing.x(flexSpacing),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FxText.titleMedium(
                          "google_map".tr().capitalizeWords,
                          fontSize: 18,
                          fontWeight: 600,
                        ),
                        FxBreadcrumb(
                          children: [
                            FxBreadcrumbItem(name: 'Maps'.tr()),
                            FxBreadcrumbItem(
                                name: 'Google Map'.tr(), active: true),
                          ],
                        ),
                      ],
                    ),
                  ),
                  FxSpacing.height(flexSpacing),
                  Padding(
                      padding: FxSpacing.x(flexSpacing),
                      child: FxContainer.none(
                        borderRadiusAll: 4,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        height: 600,
                        child: GoogleMap(
                          onMapCreated: controller.onGoogleMapCreated,
                          mapType: MapType.hybrid,
                          initialCameraPosition: CameraPosition(
                            target:
                                LatLng(37.42796133580664, -122.085749655962),
                            zoom: 14.4746,
                          ),
                        ),
                      )),
                  FxSpacing.height(flexSpacing),
                  Padding(
                      padding: FxSpacing.x(flexSpacing),
                      child: FxContainer.none(
                        borderRadiusAll: 4,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                      )),
                ],
              );
            }));
  }
}
