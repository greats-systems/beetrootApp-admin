import 'package:core_erp/controllers/pages/error_offline_controller.dart';
import 'package:core_erp/images.dart';
import 'package:core_erp/services/theme/app_style.dart';
import 'package:core_erp/utils/mixins/ui_mixin.dart';
import 'package:core_erp/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class ErrorOfflinePage extends StatefulWidget {
  const ErrorOfflinePage({Key? key}) : super(key: key);

  @override
  State<ErrorOfflinePage> createState() => _ErrorOfflinePageState();
}

class _ErrorOfflinePageState extends State<ErrorOfflinePage>
    with SingleTickerProviderStateMixin, UIMixin {
  late ErrorOflineController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(ErrorOflineController());
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
                        FxBreadcrumbItem(name: "Offline", active: true),
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
                                  "We're currently offline",
                                  textAlign: TextAlign.center,
                                  fontWeight: 600,
                                ),
                              ),
                              FxSpacing.height(16),
                              FxText.bodyMedium(
                                "We can't show you this images because you aren't connected to the internet. When you’re back online refresh the page or hit the button below",
                                textAlign: TextAlign.center,
                                muted: true,
                              ),
                              Image.asset(
                                Images.error[4],
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
                                        'Refresh',
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
