import 'package:core_erp/controllers/other/leaflet_controller.dart';
import 'package:core_erp/services/theme/app_style.dart';
import 'package:core_erp/utils/mixins/ui_mixin.dart';
import 'package:core_erp/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class LeafletPage extends StatefulWidget {
  const LeafletPage({Key? key}) : super(key: key);

  @override
  State<LeafletPage> createState() => _LeafletPageState();
}

class _LeafletPageState extends State<LeafletPage>
    with SingleTickerProviderStateMixin, UIMixin {
  late LeafletController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(LeafletController());
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        builder: (controller) {
          return Column(
            children: [
              Padding(
                padding: FxSpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FxText.titleMedium(
                      "Leaflet",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    FxBreadcrumb(
                      children: [
                        FxBreadcrumbItem(name: 'Maps'),
                        FxBreadcrumbItem(name: 'Leaflet', active: true),
                      ],
                    ),
                  ],
                ),
              ),
              FxSpacing.height(flexSpacing),
              Padding(
                padding: FxSpacing.x(flexSpacing),
                child: Column(
                  children: [
                    FxContainer.none(
                      borderRadiusAll: 4,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      height: 600,
                      child: FlutterMap(
                        mapController: controller.mapController,
                        options: controller.getMapOption(),
                        nonRotatedChildren: [
                          RichAttributionWidget(
                            showFlutterMapAttribution: true,
                            attributions: [
                              TextSourceAttribution(
                                'OpenStreetMap contributors',
                                onTap: () => launchUrl(Uri.parse(
                                    'https://openstreetmap.org/copyright')),
                              ),
                            ],
                          ),
                        ],
                        children: [
                          TileLayer(
                            urlTemplate:
                                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            userAgentPackageName: 'com.example.app',
                          ),
                          CircleLayer(
                            circles: controller.isCircleShowing
                                ? controller.getCircleMarkers()
                                : [],
                          ),
                          PolylineLayer(
                            polylines: controller.isLineShowing
                                ? controller.getPolyLines()
                                : [],
                          ),
                          MarkerLayer(
                            markers: controller.isImageShowing
                                ? controller.getMarkerLayers()
                                : [],
                          ),
                        ],
                      ),
                    ),
                    FxSpacing.height(flexSpacing),
                    Row(
                      children: [
                        FxButton(
                          onPressed: () {
                            controller.onChangeCircleShowing();
                          },
                          elevation: 0,
                          padding: FxSpacing.xy(20, 16),
                          backgroundColor: contentTheme.primary,
                          borderRadiusAll: AppStyle.buttonRadius.medium,
                          child: FxText.bodyMedium(
                            !controller.isCircleShowing
                                ? "Circle Show"
                                : "Circle Hide",
                            color: contentTheme.onPrimary,
                          ),
                        ),
                        FxSpacing.width(16),
                        FxButton(
                            onPressed: () {
                              controller.onChangeLineShowing();
                            },
                            elevation: 0,
                            padding: FxSpacing.xy(20, 16),
                            backgroundColor: contentTheme.primary,
                            borderRadiusAll: AppStyle.buttonRadius.medium,
                            child: FxText.bodyMedium(
                              !controller.isLineShowing
                                  ? "Line Show"
                                  : "Line Hide",
                              color: contentTheme.onPrimary,
                            )),
                        FxSpacing.width(16),
                        FxButton(
                          onPressed: () {
                            controller.onChangeImageShowing();
                          },
                          elevation: 0,
                          padding: FxSpacing.xy(20, 16),
                          backgroundColor: contentTheme.primary,
                          borderRadiusAll: AppStyle.buttonRadius.medium,
                          child: Visibility(
                            child: FxText.bodyMedium(
                              !controller.isImageShowing
                                  ? "Image Show"
                                  : "Image Hide",
                              color: contentTheme.onPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
