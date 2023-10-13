import 'package:core_erp/controllers/pages/success_controller.dart';
import 'package:core_erp/images.dart';
import 'package:core_erp/services/theme/app_style.dart';
import 'package:core_erp/utils/mixins/ui_mixin.dart';
import 'package:core_erp/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class SuccessPage extends StatefulWidget {
  const SuccessPage({Key? key}) : super(key: key);

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage>
    with SingleTickerProviderStateMixin, UIMixin {
  late SuccessController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(SuccessController());
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
                      "Success",
                      fontWeight: 600,
                      fontSize: 18,
                    ),
                    FxBreadcrumb(
                      children: [
                        FxBreadcrumbItem(name: "UI"),
                        FxBreadcrumbItem(name: "Success", active: true),
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
                                  "Success!",
                                  fontWeight: 600,
                                ),
                              ),
                              SizedBox(
                                width: 400,
                                child: FxText.bodySmall(
                                  controller.dummyTexts[7],
                                  maxLines: 1,
                                ),
                              ),
                              Image.asset(
                                Images.success[0],
                                // height: 600,
                              ),
                              FxFlex(
                                contentPadding: true,
                                children: [
                                  FxFlexItem(
                                    sizes: "lg-6 md-5 ",
                                    child: FxButton.outlined(
                                      onPressed: () {},
                                      elevation: 0,
                                      padding: FxSpacing.xy(20, 16),
                                      borderColor: contentTheme.primary,
                                      splashColor:
                                          contentTheme.primary.withOpacity(0.1),
                                      borderRadiusAll:
                                          AppStyle.buttonRadius.medium,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: FxText.bodySmall(
                                              'Report For Skipped Items',
                                              overflow: TextOverflow.ellipsis,
                                              color: contentTheme.primary,
                                            ),
                                          ),
                                          FxSpacing.width(8),
                                          FxContainer.rounded(
                                            paddingAll: 6,
                                            color: contentTheme.primary
                                                .withAlpha(50),
                                            child: FxText.bodyMedium("6"),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  FxFlexItem(
                                    sizes: "lg-6 md-5",
                                    child: FxButton(
                                      onPressed: () {},
                                      elevation: 0,
                                      padding: FxSpacing.xy(20, 16),
                                      backgroundColor: contentTheme.primary,
                                      borderRadiusAll:
                                          AppStyle.buttonRadius.medium,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: FxText.bodySmall(
                                              'Go to imported items',
                                              color: contentTheme.onPrimary,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          FxSpacing.width(8),
                                          FxContainer.rounded(
                                            paddingAll: 6,
                                            color: contentTheme.secondary
                                                .withAlpha(100),
                                            child: FxText.bodyMedium(
                                              "145",
                                              color: contentTheme.onPrimary,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  FxSpacing.width(16),
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
