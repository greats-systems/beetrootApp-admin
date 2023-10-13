import 'package:core_erp/controllers/pages/error_404_basic_controller.dart';
import 'package:core_erp/images.dart';
import 'package:core_erp/services/theme/app_style.dart';
import 'package:core_erp/utils/mixins/ui_mixin.dart';
import 'package:core_erp/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class Error404BasicPage extends StatefulWidget {
  const Error404BasicPage({Key? key}) : super(key: key);

  @override
  State<Error404BasicPage> createState() => _Error404BasicPageState();
}

class _Error404BasicPageState extends State<Error404BasicPage>
    with SingleTickerProviderStateMixin, UIMixin {
  late Error404BasicController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(Error404BasicController());
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
                      "ERROR",
                      fontWeight: 600,
                      fontSize: 18,
                    ),
                    FxBreadcrumb(
                      children: [
                        FxBreadcrumbItem(name: "UI"),
                        FxBreadcrumbItem(name: "Error-404-basic", active: true),
                      ],
                    ),
                  ],
                ),
              ),
              FxSpacing.height(flexSpacing),
              Padding(
                padding: FxSpacing.x(flexSpacing * 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FxFlex(contentPadding: false, children: [
                      FxFlexItem(
                        sizes: "lg-4",
                        child: FxContainer(
                          child: Column(
                            children: [
                              FxContainer(
                                child: FxText.titleLarge(
                                  "ERROR!",
                                  fontWeight: 600,
                                ),
                              ),
                              FxSpacing.height(16),
                              FxText.titleLarge(
                                "SORRY! PAGE NOT FOUND",
                                textAlign: TextAlign.center,
                                maxLines: 1,
                              ),
                              Image.asset(
                                Images.error[0],
                                // height: 600,
                              ),
                              FxFlex(
                                contentPadding: true,
                                children: [
                                  FxFlexItem(
                                    sizes: "lg-5 md-5",
                                    child: FxButton(
                                      onPressed: () {},
                                      elevation: 0,
                                      padding: FxSpacing.xy(20, 16),
                                      backgroundColor: contentTheme.primary,
                                      borderRadiusAll:
                                          AppStyle.buttonRadius.medium,
                                      child: FxText.bodySmall(
                                        'Back To Home',
                                        color: contentTheme.onPrimary,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ])
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
