import 'package:core_erp/controllers/other/pricing_controller.dart';
import 'package:core_erp/services/theme/app_style.dart';
import 'package:core_erp/utils/mixins/ui_mixin.dart';
import 'package:core_erp/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class PricingPage extends StatefulWidget {
  const PricingPage({Key? key}) : super(key: key);

  @override
  State<PricingPage> createState() => _PricingPageState();
}

class _PricingPageState extends State<PricingPage>
    with SingleTickerProviderStateMixin, UIMixin {
  late PricingController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(PricingController());
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: FxSpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FxText.titleMedium(
                      "Pricing",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    FxBreadcrumb(
                      children: [
                        FxBreadcrumbItem(name: 'Extra Pages'),
                        FxBreadcrumbItem(name: 'Pricing', active: true),
                      ],
                    ),
                  ],
                ),
              ),
              FxSpacing.height(22),
              Column(
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Our ',
                      style: FxTextStyle.getStyle(
                        fontSize: 32,
                      ),
                      children: [
                        TextSpan(
                          text: 'Plans',
                          style: FxTextStyle.getStyle(
                              fontSize: 32, fontWeight: 600),
                        ),
                      ],
                    ),
                  ),
                  FxSpacing.height(12),
                  SizedBox(
                    width: 400,
                    child: Center(
                      child: FxText.bodySmall(
                        controller.dummyTexts[7],
                        maxLines: 2,
                        muted: true,
                      ),
                    ),
                  ),
                ],
              ),
              FxSpacing.height(flexSpacing),
              Padding(
                padding: FxSpacing.x(flexSpacing / 2),
                child: FxFlex(
                  wrapAlignment: WrapAlignment.start,
                  wrapCrossAlignment: WrapCrossAlignment.start,
                  children: [
                    FxFlexItem(
                      sizes: "lg-4 md-12",
                      child: FxCard(
                        shadow: FxShadow(
                            elevation: 1, position: FxShadowPosition.bottom),
                        paddingAll: 24,
                        child: Column(
                          children: [
                            FxText.titleMedium(
                              "PROFESSIONAL PACK",
                              fontWeight: 600,
                            ),
                            FxSpacing.height(32),
                            FxContainer.rounded(
                              height: 60,
                              width: 60,
                              color: contentTheme.primary.withOpacity(0.12),
                              child: Center(
                                child: Icon(
                                  Icons.group_outlined,
                                  color: contentTheme.primary,
                                ),
                              ),
                            ),
                            FxSpacing.height(32),
                            RichText(
                              text: TextSpan(
                                text: '\$ 19',
                                style: FxTextStyle.getStyle(
                                    fontSize: 32, fontWeight: 600),
                                children: [
                                  TextSpan(
                                    text: '/ Month',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w200,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            FxSpacing.height(32),
                            buildText("10 GB Storage", contentTheme.primary),
                            FxSpacing.height(16),
                            buildText("500 GB BandWidth", contentTheme.primary),
                            FxSpacing.height(16),
                            buildText("No Domain", contentTheme.primary),
                            FxSpacing.height(16),
                            buildText("1 User", contentTheme.primary),
                            FxSpacing.height(16),
                            buildText("Email Support", contentTheme.primary),
                            FxSpacing.height(16),
                            buildText("24 x 7 Support", contentTheme.primary),
                            FxSpacing.height(32),
                            FxButton(
                              onPressed: () {},
                              elevation: 0,
                              padding: FxSpacing.xy(20, 16),
                              backgroundColor: contentTheme.primary,
                              borderRadiusAll: AppStyle.buttonRadius.medium,
                              child: FxText.bodySmall(
                                'Sign Up',
                                color: contentTheme.onPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    FxFlexItem(
                      sizes: "lg-4 md-12",
                      child: FxContainer(
                        color: contentTheme.primary,
                        paddingAll: 24,
                        child: Column(
                          children: [
                            FxText.titleMedium(
                              "BUSINESS PACK",
                              fontWeight: 600,
                              color: contentTheme.onPrimary,
                            ),
                            FxSpacing.height(32),
                            FxContainer.rounded(
                              height: 60,
                              width: 60,
                              color: contentTheme.onPrimary.withOpacity(0.12),
                              child: Center(
                                child: Icon(
                                  Icons.workspace_premium,
                                  color: contentTheme.onPrimary,
                                ),
                              ),
                            ),
                            FxSpacing.height(32),
                            RichText(
                              text: TextSpan(
                                text: '\$ 29',
                                style: FxTextStyle.getStyle(
                                    fontSize: 32,
                                    fontWeight: 600,
                                    color: contentTheme.onPrimary),
                                children: [
                                  TextSpan(
                                    text: '/ Month',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w200,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            FxSpacing.height(32),
                            buildText("50 GB Storage", contentTheme.onPrimary),
                            FxSpacing.height(16),
                            buildText(
                                "900 GB BandWidth", contentTheme.onPrimary),
                            FxSpacing.height(16),
                            buildText("2 Domain", contentTheme.onPrimary),
                            FxSpacing.height(16),
                            buildText("10 User", contentTheme.onPrimary),
                            FxSpacing.height(16),
                            buildText("Email Support", contentTheme.onPrimary),
                            FxSpacing.height(16),
                            buildText("24 x 7 Support", contentTheme.onPrimary),
                            FxSpacing.height(32),
                            FxButton(
                              onPressed: () {},
                              elevation: 0,
                              padding: FxSpacing.xy(20, 16),
                              backgroundColor: contentTheme.onPrimary,
                              borderRadiusAll: AppStyle.buttonRadius.medium,
                              child: FxText.bodySmall(
                                'Sign Up',
                                color: contentTheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    FxFlexItem(
                      sizes: "lg-4 md-12",
                      child: FxCard(
                        shadow: FxShadow(
                            elevation: 1, position: FxShadowPosition.bottom),
                        paddingAll: 24,
                        child: Column(
                          children: [
                            FxText.titleMedium(
                              "ENTERPRISE PACK",
                              fontWeight: 600,
                            ),
                            FxSpacing.height(32),
                            FxContainer.rounded(
                              height: 60,
                              width: 60,
                              color: contentTheme.primary.withOpacity(0.12),
                              child: Center(
                                child: Icon(
                                  Icons.work_outline,
                                  color: contentTheme.primary,
                                ),
                              ),
                            ),
                            FxSpacing.height(44),
                            FxText.titleMedium('Based on Usage',
                                fontWeight: 600),
                            FxSpacing.height(44),
                            buildText("100 GB Storage", contentTheme.primary),
                            FxSpacing.height(16),
                            buildText(
                                "Unlimited BandWidth", contentTheme.primary),
                            FxSpacing.height(16),
                            buildText("Unlimited Domain", contentTheme.primary),
                            FxSpacing.height(16),
                            buildText("Unlimited User", contentTheme.primary),
                            FxSpacing.height(16),
                            buildText("Email Support", contentTheme.primary),
                            FxSpacing.height(16),
                            buildText("24 x 7 Support", contentTheme.primary),
                            FxSpacing.height(32),
                            FxButton(
                              onPressed: () {},
                              elevation: 0,
                              padding: FxSpacing.xy(20, 16),
                              backgroundColor: contentTheme.primary,
                              borderRadiusAll: AppStyle.buttonRadius.medium,
                              child: FxText.bodySmall(
                                'Contact US',
                                color: contentTheme.onPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
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

Widget buildText(String text, Color? color) {
  return FxText.bodySmall(
    text,
    fontSize: 14,
    color: color,
  );
}
