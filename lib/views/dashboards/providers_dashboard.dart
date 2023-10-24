import 'package:core_erp/controllers/auth/auth_controller.dart';
import 'package:core_erp/views/dashboards/providers/beetroot_dashboard.dart';
import 'package:core_erp/views/dashboards/providers/geza_dashboard%20copy.dart';
import 'package:core_erp/views/dashboards/providers/transporter_dashboard.dart';
import 'package:core_erp/views/dashboards/providers/warehouse_dashboard.dart';
import 'package:core_erp/controllers/dashboard_controller.dart';
import 'package:core_erp/extensions/extensions.dart';
import 'package:core_erp/utils/mixins/ui_mixin.dart';
import 'package:core_erp/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';

class ProviderDashboardPage extends StatefulWidget {
  const ProviderDashboardPage({super.key});

  @override
  ProviderDashboardPageState createState() => ProviderDashboardPageState();
}

class ProviderDashboardPageState extends State<ProviderDashboardPage>
    with SingleTickerProviderStateMixin, UIMixin {
  late DashboardController controller;
  late AuthController authController;

  @override
  void initState() {
    super.initState();
    controller = Get.put(DashboardController());
    authController = Get.put(AuthController());
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
        child: GetBuilder<DashboardController>(
            init: controller,
            builder: (controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: FxSpacing.x(flexSpacing),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FxBreadcrumb(
                          children: [
                            FxBreadcrumbItem(
                                name: 'app'
                                    .tr()),
                            FxBreadcrumbItem(
                                name: 'analytics'.tr(), active: true),
                          ],
                        ),
                      ],
                    ),
                  ),
                  FxSpacing.height(flexSpacing),
                  GezaAdminDashboard()
                  // authController.person.value.tradingAs == 'warehouse'
                  //     ? WarehouseDashboard()
                  //     : authController.person.value.tradingAs == 'transporter'
                  //         ? TransporterDashboard()
                  //         : authController.person.value.tradingAs == 'beetroot'
                  //             ? TransporterDashboard()
                  //             : Column(),
                ],
              );
            }));
  }
}
