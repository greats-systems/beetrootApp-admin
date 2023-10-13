import 'package:core_erp/controllers/apps/nft/dashboard_controller.dart';
import 'package:core_erp/images.dart';
import 'package:core_erp/services/theme/app_style.dart';
import 'package:core_erp/utils/mixins/ui_mixin.dart';
import 'package:core_erp/utils/utils.dart';
import 'package:core_erp/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutx/responsive/responsive.dart';

import 'package:flutx/styles/shadow.dart';
import 'package:flutx/utils/spacing.dart';
import 'package:flutx/widgets/breadcrumb/breadcrumb.dart';
import 'package:flutx/widgets/breadcrumb/breadcrumb_item.dart';
import 'package:flutx/widgets/button/button.dart';
import 'package:flutx/widgets/card/card.dart';
import 'package:flutx/widgets/container/container.dart';
import 'package:flutx/widgets/responsive/flex.dart';
import 'package:flutx/widgets/responsive/flex_item.dart';
import 'package:flutx/widgets/text/text.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

class NFTDashboardPage extends StatefulWidget {
  const NFTDashboardPage({Key? key}) : super(key: key);

  @override
  State<NFTDashboardPage> createState() => _NFTDashboardPageState();
}

class _NFTDashboardPageState extends State<NFTDashboardPage>
    with SingleTickerProviderStateMixin, UIMixin {
  late NFTDashboardController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(NFTDashboardController());
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
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
                      "NFT Dashboard",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    FxBreadcrumb(
                      children: [
                        FxBreadcrumbItem(name: "NFT"),
                        FxBreadcrumbItem(name: "Dashboard", active: true),
                      ],
                    ),
                  ],
                ),
              ),
              FxSpacing.height(flexSpacing),
              Padding(
                padding: FxSpacing.x(flexSpacing),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FxFlex(
                      wrapAlignment: WrapAlignment.start,
                      contentPadding: false,
                      wrapCrossAlignment: WrapCrossAlignment.start,
                      children: [
                        FxFlexItem(
                          sizes: "lg-8",
                          child: Column(
                            children: [
                              FxFlex(
                                contentPadding: false,
                                children: [
                                  FxFlexItem(
                                    sizes: "lg-6 md-12",
                                    child: FxContainer(
                                      // shadow: FxShadow(elevation: 4),
                                      paddingAll: 0,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      child: Stack(
                                        alignment: Alignment.centerRight,
                                        children: [
                                          Image.asset(
                                            Images.marketplaceImages[2],
                                            height: 300,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                                          Padding(
                                            padding: FxSpacing.all(24),
                                            child: FxContainer(
                                              height: 250,
                                              color:
                                                  Colors.white.withAlpha(120),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  FxText.bodyMedium(
                                                    "Time remaining",
                                                    color: Colors.black,
                                                  ),
                                                  FxText.titleMedium(
                                                    "${Utils.getTimeStringFromDateTime(
                                                      DateTime.now(),
                                                    )}",
                                                    fontWeight: 700,
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    muted: true,
                                                  ),
                                                  FxSpacing.height(12),
                                                  Image.asset(
                                                      Images.ethLogoIcon,
                                                      height: 34),
                                                  FxSpacing.height(12),
                                                  FxText.bodyMedium(
                                                    "Highest Bid",
                                                    color: Colors.black,
                                                  ),
                                                  FxText.bodyMedium(
                                                    "25.55 ETH",
                                                    fontWeight: 700,
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                  ),
                                                  FxButton(
                                                    onPressed: () {},
                                                    elevation: 0,
                                                    borderRadiusAll: AppStyle
                                                        .buttonRadius.medium,
                                                    padding:
                                                        FxSpacing.xy(20, 16),
                                                    backgroundColor:
                                                        contentTheme.primary,
                                                    child: FxText.bodySmall(
                                                      'Place a Bid',
                                                      color: contentTheme
                                                          .onPrimary,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  FxFlexItem(
                                    sizes: "lg-6",
                                    child: buildProductCard(
                                      "Wild Forest",
                                      "25.55 ETH",
                                    ),
                                  ),
                                ],
                              ),
                              FxSpacing.height(20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      FxText.titleMedium(
                                        "Top Seller",
                                        fontWeight: 600,
                                        fontSize: 18,
                                      ),
                                      FxButton(
                                        onPressed: () {},
                                        elevation: 0,
                                        borderColor: contentTheme.primary,
                                        backgroundColor: contentTheme.primary
                                            .withOpacity(0.12),
                                        splashColor: contentTheme.primary
                                            .withOpacity(0.2),
                                        borderRadiusAll:
                                            AppStyle.buttonRadius.medium,
                                        child: Row(
                                          children: [
                                            FxText.bodySmall(
                                              'View All',
                                              fontWeight: 600,
                                              color: contentTheme.primary,
                                            ),
                                            FxSpacing.width(8),
                                            Icon(
                                              Icons.arrow_forward_outlined,
                                              color: contentTheme.primary,
                                              size: 16,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  FxSpacing.height(24),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        buildTopSeller(
                                          Images.avatars[0],
                                          "Donica ",
                                          "\$44,654.45",
                                        ),
                                        buildTopSeller(
                                          Images.avatars[1],
                                          "Kevina ",
                                          "\$55,658.25",
                                        ),
                                        buildTopSeller(
                                          Images.avatars[2],
                                          "Barnard ",
                                          "\$44,987.45",
                                        ),
                                        buildTopSeller(
                                          Images.avatars[3],
                                          "Shandra ",
                                          "\$68,154.89",
                                        ),
                                        buildTopSeller(
                                          Images.avatars[4],
                                          "Ivor ",
                                          "\$99,562.87",
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              FxSpacing.height(20),
                              FxFlex(
                                contentPadding: false,
                                children: [
                                  FxFlexItem(
                                    sizes: "lg-6 sm-12",
                                    child: buildProductCard(
                                      "Antonia Forest",
                                      "89.10 ETH",
                                    ),
                                  ),
                                  FxFlexItem(
                                    sizes: "lg-6 sm-12",
                                    child: buildProductCard(
                                      "Earl Forest",
                                      "35.05 ETH",
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        FxFlexItem(
                          sizes: "lg-4 md-12",
                          child: Column(
                            children: [
                              buildProfileDetail(),
                              FxSpacing.height(24),
                              FxCard(
                                shadow: FxShadow(elevation: 0.5),
                                paddingAll: 20,
                                borderRadiusAll: AppStyle.buttonRadius.medium,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.account_balance_wallet_outlined,
                                          color: contentTheme.onBackground
                                              .withAlpha(220),
                                        ),
                                        FxSpacing.width(12),
                                        FxText.bodyMedium(
                                          "Your Balance",
                                          fontWeight: 600,
                                        ),
                                      ],
                                    ),
                                    FxSpacing.height(16),
                                    FxContainer.bordered(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Image.asset(
                                                Images.ethLogoIcon,
                                                height: 34,
                                              ),
                                              FxSpacing.width(8),
                                              FxText.bodyMedium(
                                                "3,456 ETH",
                                                fontWeight: 600,
                                                fontSize: 16,
                                              ),
                                            ],
                                          ),
                                          FxSpacing.height(16),
                                          Row(
                                            children: [
                                              FxButton.rounded(
                                                onPressed: () {},
                                                elevation: 0,
                                                borderColor:
                                                    contentTheme.primary,
                                                backgroundColor: contentTheme
                                                    .primary
                                                    .withAlpha(28),
                                                splashColor: contentTheme
                                                    .primary
                                                    .withAlpha(28),
                                                borderRadiusAll: AppStyle
                                                    .buttonRadius.medium,
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.add_outlined,
                                                      size: 18,
                                                      color:
                                                          contentTheme.primary,
                                                    ),
                                                    FxSpacing.width(6),
                                                    FxText.bodySmall(
                                                      'Add',
                                                      fontWeight: 600,
                                                      color:
                                                          contentTheme.primary,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    FxSpacing.height(16),
                                    Center(
                                      child: SfCartesianChart(
                                        primaryXAxis: CategoryAxis(
                                          majorGridLines:
                                              MajorGridLines(width: 0),
                                          axisLine: AxisLine(width: 0),
                                        ),
                                        primaryYAxis: CategoryAxis(
                                          majorGridLines:
                                              MajorGridLines(width: 0),
                                          axisLine: AxisLine(width: 0),
                                        ),
                                        tooltipBehavior:
                                            controller.tooltipBehavior,
                                        series: <ChartSeries>[
                                          SplineSeries<ChartData, String>(
                                            dataSource: controller.chartData,
                                            xValueMapper: (ChartData data, _) =>
                                                data.x,
                                            yValueMapper: (ChartData data, _) =>
                                                data.y,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    // FxSpacing.height(24),
                    // FxContainer(
                    //   alignment: Alignment.center,
                    //   height: 50,
                    //   color: colorScheme.primary.withOpacity(0.08),
                    //   padding: FxSpacing.xy(16, 8),
                    //   child: Marquee(
                    //     text: 'The quick brown fox jumps over the lazy dog',
                    //     style: TextStyle(
                    //         fontWeight: FontWeight.w500,
                    //         fontSize: 20,
                    //         color: contentTheme.primary),
                    //     scrollAxis: Axis.horizontal,
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //     blankSpace: 20.0,
                    //     velocity: 50.0,
                    //     pauseAfterRound: Duration(seconds: 1),
                    //     startPadding: 10.0,
                    //     accelerationDuration: Duration(seconds: 1),
                    //     accelerationCurve: Curves.bounceIn,
                    //     decelerationDuration: Duration(milliseconds: 500),
                    //     decelerationCurve: Curves.bounceIn,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildTopSeller(String avatar, String sellerName, String sellerPrice) {
    return FxCard(
      shadow: FxShadow(elevation: 0.5),
      paddingAll: 8,
      margin: FxSpacing.right(16),
      borderRadiusAll: AppStyle.buttonRadius.medium,
      width: 200,
      child: Row(
        children: [
          FxContainer.none(
            borderRadiusAll: AppStyle.buttonRadius.medium,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Image.asset(
              avatar,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          FxSpacing.width(16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FxText.bodyMedium(
                sellerName,
                fontWeight: 700,
                fontSize: 16,
              ),
              FxText.bodyMedium(
                sellerPrice,
                muted: true,
                fontSize: 16,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildProductCard(String productName, String productPrice) {
    return FxCard(
      shadow: FxShadow(elevation: 0.5),
      padding: FxSpacing.all(16),
      borderRadiusAll: AppStyle.buttonRadius.medium,
      child: FxFlex(
        contentPadding: false,
        children: [
          FxFlexItem(
            sizes: "lg-5",
            child: FxContainer(
              borderRadiusAll: AppStyle.buttonRadius.medium,
              paddingAll: 0,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Image.asset(
                    Images.marketplaceImages[1],
                    height: 267,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  FxContainer.none(
                    paddingAll: 0,
                    height: 40,
                    color: contentTheme.primary.withOpacity(0.6),
                    child: Center(
                      child: FxText.bodyMedium(
                        "Add To Cart",
                        color: contentTheme.onPrimary,
                        fontWeight: 600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          FxFlexItem(
            sizes: "lg-7",
            child: SizedBox(
              height: 267,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FxText.bodyLarge(
                    productName,
                    fontWeight: 600,
                  ),
                  FxContainer.bordered(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FxText.bodyMedium(
                              "Bidding Ends In",
                            ),

                            FxText.titleMedium(
                              "${Utils.getTimeStringFromDateTime(
                                DateTime.now(),
                              )}",
                              color: contentTheme.primary,
                              fontWeight: 700,
                              fontSize: 20,
                              muted: true,
                            ),
                            FxSpacing.height(24),
                            FxText.titleSmall(
                              "Current Bid",
                              fontSize: 12,
                              muted: true,
                            ),
                            // FxSpacing.height(6),
                            FxText.titleSmall(
                              productPrice,
                              fontSize: 28,
                              fontWeight: 700,
                              color: contentTheme.primary,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  FxButton(
                    onPressed: () {},
                    elevation: 0,
                    padding: FxSpacing.xy(20, 16),
                    backgroundColor: contentTheme.primary,
                    borderRadiusAll: AppStyle.buttonRadius.medium,
                    child: FxText.bodySmall(
                      'Place a Bid',
                      color: contentTheme.onPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProfileDetail() {
    Widget buildNumbers(String number, String name) {
      return FxContainer(
        paddingAll: 8,
        width: 100,
        color: contentTheme.onBackground.withAlpha(28),
        child: Column(
          children: [
            FxText.bodyMedium(
              number,
              fontSize: 24,
              fontWeight: 600,
              color: contentTheme.onBackground,
            ),
            FxText.bodyMedium(
              name,
              fontSize: 14,
              fontWeight: 600,
              color: contentTheme.onBackground,
            ),
          ],
        ),
      );
    }

    return SizedBox(
      height: 300,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          FxCard(
            shadow: FxShadow(elevation: 0.5),
            borderRadiusAll: AppStyle.buttonRadius.medium,
            height: 250,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FxText.titleMedium(
                    "Deo",
                    fontWeight: 500,
                    fontSize: 14,
                  ),
                  FxText.titleMedium(
                    "Top Rated",
                    fontWeight: 600,
                    fontSize: 16,
                  ),
                  FxSpacing.height(16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildNumbers("10K", "Followers"),
                      buildNumbers("50K", "Likes"),
                      buildNumbers("80", "Bidding"),
                    ],
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: FxContainer.rounded(
              height: 100,
              width: 100,
              paddingAll: 0,
              child: Image.asset(
                Images.avatars[0],
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
