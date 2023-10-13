import 'package:core_erp/controllers/starter_controller.dart';
import 'package:core_erp/utils/mixins/ui_mixin.dart';
import 'package:core_erp/views/layouts/layout.dart';

import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class StarterPage extends StatefulWidget {
  const StarterPage({super.key});

  @override
  StarterPageState createState() => StarterPageState();
}

class StarterPageState extends State<StarterPage>
    with SingleTickerProviderStateMixin, UIMixin {
  late StarterController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(StarterController());
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
        child: GetBuilder<StarterController>(
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
                        FxText.titleMedium(
                          "Starter",
                          fontSize: 18,
                          fontWeight: 600,
                        ),
                        FxBreadcrumb(
                          children: [
                            FxBreadcrumbItem(name: 'Starter', active: true),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }));
  }
}
