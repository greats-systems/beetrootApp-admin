import 'package:core_erp/controllers/pages/error_500_controller.dart';
import 'package:core_erp/images.dart';
import 'package:core_erp/services/theme/app_style.dart';
import 'package:core_erp/utils/mixins/ui_mixin.dart';
import 'package:core_erp/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class Error500Page extends StatefulWidget {
  const Error500Page({Key? key}) : super(key: key);

  @override
  State<Error500Page> createState() => _Error500PageState();
}

class _Error500PageState extends State<Error500Page>
    with SingleTickerProviderStateMixin, UIMixin {
  late Error500Controller controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(Error500Controller());
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
                        FxBreadcrumbItem(name: "Error-500", active: true),
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
                                  "Internal Server Error!",
                                  textAlign: TextAlign.center,
                                  fontWeight: 600,
                                ),
                              ),
                              FxSpacing.height(16),
                              FxText.bodyMedium(
                                "Server Error 500. We're not exactly sure what happened, but our servers say something is wrong.",
                                textAlign: TextAlign.center,
                                muted: true,
                              ),
                              Image.asset(
                                Images.error[3],
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
