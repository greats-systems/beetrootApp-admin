import 'package:feather_icons/feather_icons.dart';
import 'package:core_erp/controllers/dashboard_controller.dart';
import 'package:core_erp/controllers/other/syncfusion_charts_controller.dart';
import 'package:core_erp/extensions/extensions.dart';
import 'package:core_erp/images.dart';
import 'package:core_erp/utils/mixins/ui_mixin.dart';
import 'package:core_erp/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  DashboardPageState createState() => DashboardPageState();
}

class DashboardPageState extends State<DashboardPage>
    with SingleTickerProviderStateMixin, UIMixin {
  late DashboardController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(DashboardController());
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
                        // FxText.titleMedium(
                        //   "analytics".tr(),
                        //   fontSize: 18,
                        //   fontWeight: 600,
                        // ),
                        FxBreadcrumb(
                          children: [
                            FxBreadcrumbItem(name: 'trading'.tr()),
                            FxBreadcrumbItem(
                                name: 'analytics'.tr(), active: true),
                          ],
                        ),
                      ],
                    ),
                  ),
                  FxSpacing.height(flexSpacing),
                  Padding(
                    padding: FxSpacing.x(flexSpacing / 2),
                    child: FxFlex(
                      wrapAlignment: WrapAlignment.start,
                      wrapCrossAlignment: WrapCrossAlignment.start,
                      children: [
                        FxFlexItem(
                          sizes: "xl-3 lg-6 sm-12",
                          child: FxCard(
                              shadow: FxShadow(
                                  elevation: 0.5,
                                  position: FxShadowPosition.bottom),
                              padding: FxSpacing.xy(20, 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      FxText.headlineSmall(
                                        "\$12,000",
                                        fontWeight: 600,
                                      ),
                                      FxSpacing.height(4),
                                      FxText.bodySmall(
                                        "total_orders".tr().capitalizeWords,
                                        muted: true,
                                        fontWeight: 600,
                                      ),
                                    ],
                                  ),
                                  FxContainer(
                                      color: contentTheme.primary.withAlpha(48),
                                      child: Icon(
                                        FeatherIcons.creditCard,
                                        color: contentTheme.primary,
                                        size: 24,
                                      ))
                                ],
                              )),
                        ),
                        FxFlexItem(
                          sizes: "xl-3 lg-6 sm-12",
                          child: FxCard(
                              shadow: FxShadow(
                                  elevation: 0.5,
                                  position: FxShadowPosition.bottom),
                              padding: FxSpacing.xy(20, 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      FxText.headlineSmall(
                                        "127",
                                        fontWeight: 600,
                                      ),
                                      FxSpacing.height(4),
                                      FxText.bodySmall(
                                        "issued_reciepts".tr().capitalizeWords,
                                        muted: true,
                                        fontWeight: 600,
                                      ),
                                    ],
                                  ),
                                  FxContainer(
                                      color: contentTheme.success.withAlpha(48),
                                      child: Icon(
                                        FeatherIcons.shoppingCart,
                                        color: contentTheme.success,
                                        size: 24,
                                      ))
                                ],
                              )),
                        ),
                        FxFlexItem(
                          sizes: "xl-3 lg-6 sm-12",
                          child: FxCard(
                              shadow: FxShadow(
                                  elevation: 0.5,
                                  position: FxShadowPosition.bottom),
                              padding: FxSpacing.xy(20, 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      FxText.headlineSmall(
                                        "248",
                                        fontWeight: 600,
                                      ),
                                      FxSpacing.height(4),
                                      FxText.bodySmall(
                                        "on_delivery".tr().capitalizeWords,
                                        muted: true,
                                        fontWeight: 600,
                                      ),
                                    ],
                                  ),
                                  FxContainer(
                                      color:
                                          contentTheme.secondary.withAlpha(48),
                                      child: Icon(
                                        FeatherIcons.truck,
                                        color: contentTheme.secondary,
                                        size: 24,
                                      ))
                                ],
                              )),
                        ),
                        FxFlexItem(
                          sizes: "xl-3 lg-6 sm-12",
                          child: FxCard(
                              shadow: FxShadow(
                                  elevation: 0.5,
                                  position: FxShadowPosition.bottom),
                              padding: FxSpacing.xy(20, 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      FxText.headlineSmall(
                                        "125k",
                                        fontWeight: 600,
                                      ),
                                      FxSpacing.height(4),
                                      FxText.bodySmall(
                                        "website_visits".tr().capitalizeWords,
                                        muted: true,
                                        fontWeight: 600,
                                      ),
                                    ],
                                  ),
                                  FxContainer(
                                      color: contentTheme.danger.withAlpha(48),
                                      child: Icon(
                                        FeatherIcons.eye,
                                        color: contentTheme.danger,
                                        size: 26,
                                      ))
                                ],
                              )),
                        ),
                        FxFlexItem(
                          sizes: "lg-6 sm-12",
                          child: FxCard(
                              shadow: FxShadow(
                                  elevation: 0.5,
                                  position: FxShadowPosition.bottom),
                              padding: FxSpacing.xy(20, 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FxText.titleMedium(
                                    "revenue".tr(),
                                    fontWeight: 600,
                                  ),
                                  FxSpacing.height(36),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: [
                                          FxText.bodyMedium(
                                            "target".tr(),
                                            muted: true,
                                          ),
                                          FxSpacing.height(8),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.arrow_downward,
                                                size: 16,
                                                color: contentTheme.danger,
                                              ),
                                              FxSpacing.width(8),
                                              FxText.bodyLarge(
                                                '3.02%',
                                                fontWeight: 600,
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          FxText.bodyMedium(
                                            "last_week".tr(),
                                            muted: true,
                                          ),
                                          FxSpacing.height(8),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.arrow_upward,
                                                size: 16,
                                                color: contentTheme.primary,
                                              ),
                                              FxSpacing.width(8),
                                              FxText.bodyLarge(
                                                '\$ 2.1k',
                                                fontWeight: 600,
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          FxText.bodyMedium(
                                            "last_month".tr(),
                                            muted: true,
                                          ),
                                          FxSpacing.height(8),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.arrow_downward,
                                                size: 16,
                                                color: contentTheme.danger,
                                              ),
                                              FxSpacing.width(8),
                                              FxText.bodyLarge(
                                                '\$ 1.2k',
                                                fontWeight: 600,
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  FxSpacing.height(36),
                                  buildRevenueChart()
                                ],
                              )),
                        ),
                        FxFlexItem(
                          sizes: "lg-6 sm-12",
                          child: FxCard(
                              shadow: FxShadow(
                                  elevation: 0.5,
                                  position: FxShadowPosition.bottom),
                              padding: FxSpacing.xy(20, 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FxText.titleMedium(
                                    "product_comparison".tr().capitalizeWords,
                                    fontWeight: 600,
                                  ),
                                  FxSpacing.height(36),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: [
                                          FxText.bodyMedium(
                                            "${"product".tr()} 1",
                                            muted: true,
                                          ),
                                          FxSpacing.height(8),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.arrow_downward,
                                                size: 16,
                                                color: contentTheme.danger,
                                              ),
                                              FxSpacing.width(8),
                                              FxText.bodyLarge(
                                                '40.2%',
                                                fontWeight: 600,
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          FxText.bodyMedium(
                                            "${"product".tr()} 2",
                                            muted: true,
                                          ),
                                          FxSpacing.height(8),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.arrow_upward,
                                                size: 16,
                                                color: contentTheme.primary,
                                              ),
                                              FxSpacing.width(8),
                                              FxText.bodyLarge(
                                                '24.5%',
                                                fontWeight: 600,
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          FxText.bodyMedium(
                                            "${"Product".tr()} 3",
                                            muted: true,
                                          ),
                                          FxSpacing.height(8),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.arrow_downward,
                                                size: 16,
                                                color: contentTheme.danger,
                                              ),
                                              FxSpacing.width(8),
                                              FxText.bodyLarge(
                                                '32.5%',
                                                fontWeight: 600,
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  FxSpacing.height(36),
                                  buildComparisonChart()
                                ],
                              )),
                        ),
                        FxFlexItem(
                          sizes: "lg-6 sm-12",
                          child: FxCard(
                              shadow: FxShadow(
                                  elevation: 0.5,
                                  position: FxShadowPosition.bottom),
                              padding: FxSpacing.xy(20, 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      FxText.titleMedium(
                                        "trending_products"
                                            .tr()
                                            .capitalizeWords,
                                        fontWeight: 600,
                                      ),
                                      FxButton.text(
                                        onPressed: controller.goToProducts,
                                        elevation: 6,
                                        padding: FxSpacing.xy(20, 16),
                                        child: FxText.bodySmall(
                                          'view_all'.tr().capitalizeWords,
                                          color: contentTheme.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  FxSpacing.height(20),
                                  FxContainer.none(
                                    borderRadiusAll: 4,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: DataTable(
                                          sortAscending: true,
                                          columnSpacing: 60,
                                          onSelectAll: (_) => {},
                                          headingRowColor:
                                              MaterialStatePropertyAll(
                                                  contentTheme.primary
                                                      .withAlpha(40)),
                                          dataRowHeight: 60,
                                          showBottomBorder: false,
                                          columns: [
                                            DataColumn(
                                                label: FxText.labelLarge(
                                              'id'.tr(),
                                              color: contentTheme.primary,
                                            )),
                                            DataColumn(
                                                label: FxText.labelLarge(
                                              'name'.tr(),
                                              color: contentTheme.primary,
                                            )),
                                            DataColumn(
                                                label: FxText.labelLarge(
                                              'price'.tr(),
                                              color: contentTheme.primary,
                                            )),
                                            DataColumn(
                                                label: FxText.labelLarge(
                                              'stock'.tr(),
                                              color: contentTheme.primary,
                                            )),
                                            DataColumn(
                                                label: FxText.labelLarge(
                                              'orders'.tr(),
                                              color: contentTheme.primary,
                                            )),
                                            DataColumn(
                                                label: FxText.labelLarge(
                                              'action'.tr(),
                                              color: contentTheme.primary,
                                            )),
                                          ],
                                          rows: controller.products
                                              .mapIndexed((index, data) =>
                                                  DataRow(cells: [
                                                    DataCell(FxText.bodyMedium(
                                                        '#${data.id}')),
                                                    DataCell(SizedBox(
                                                      width: 220,
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          FxContainer.none(
                                                              borderRadiusAll:
                                                                  20,
                                                              clipBehavior: Clip
                                                                  .antiAliasWithSaveLayer,
                                                              child: Image.asset(
                                                                  Images.squareImages[index %
                                                                      Images
                                                                          .squareImages
                                                                          .length],
                                                                  height: 40,
                                                                  width: 40)),
                                                          FxSpacing.width(16),
                                                          Expanded(
                                                            child: FxText
                                                                .labelLarge(
                                                              data.name
                                                                  .toString(),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 1,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )),
                                                    DataCell(FxText.bodyMedium(
                                                        '\$${data.price}')),

                                                    DataCell(FxText.bodyMedium(
                                                        '${data.stock}')),
                                                    DataCell(FxText.bodyMedium(
                                                        '${data.ordersCount}')),

                                                    DataCell(Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child:
                                                          FxContainer.bordered(
                                                        onTap: () => {},
                                                        padding:
                                                            FxSpacing.xy(6, 6),
                                                        borderColor:
                                                            contentTheme.primary
                                                                .withAlpha(40),
                                                        child: Icon(
                                                          Icons.edit_outlined,
                                                          size: 14,
                                                          color: contentTheme
                                                              .primary,
                                                        ),
                                                      ),
                                                    )),
                                                    // DataCell(FxText.bodyMedium('${DateTime.tryParse('2022-11-26T15:56:14Z')}')),
                                                  ]))
                                              .toList()),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        FxFlexItem(
                          sizes: "lg-6 sm-12",
                          child: FxCard(
                              shadow: FxShadow(
                                  elevation: 0.5,
                                  position: FxShadowPosition.bottom),
                              padding: FxSpacing.xy(20, 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      FxText.titleMedium(
                                        "customers".tr(),
                                        fontWeight: 600,
                                      ),
                                      FxButton.text(
                                        onPressed: controller.goToCustomers,
                                        elevation: 6,
                                        padding: FxSpacing.xy(20, 16),
                                        child: FxText.bodySmall(
                                          'view_all'.tr().capitalizeWords,
                                          color: contentTheme.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  FxSpacing.height(20),
                                  FxContainer.none(
                                    borderRadiusAll: 4,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: DataTable(
                                        sortColumnIndex: 1,
                                        columnSpacing: 50,
                                        sortAscending: true,
                                        onSelectAll: (_) => {},
                                        headingRowColor:
                                            MaterialStatePropertyAll(
                                                contentTheme.primary
                                                    .withAlpha(40)),
                                        dataRowHeight: 60,
                                        showBottomBorder: false,
                                        columns: [
                                          DataColumn(
                                            label: FxText.labelLarge(
                                              'id'.tr(),
                                              color: contentTheme.primary,
                                            ),
                                          ),
                                          DataColumn(
                                            label: FxText.labelLarge(
                                              'name'.tr(),
                                              color: contentTheme.primary,
                                            ),
                                          ),
                                          DataColumn(
                                            label: FxText.labelLarge(
                                              'phone'.tr(),
                                              color: contentTheme.primary,
                                            ),
                                          ),
                                          DataColumn(
                                            label: FxText.labelLarge(
                                              'balance'.tr(),
                                              color: contentTheme.primary,
                                            ),
                                          ),
                                          DataColumn(
                                            label: FxText.labelLarge(
                                              'orders'.tr(),
                                              color: contentTheme.primary,
                                            ),
                                          ),
                                          DataColumn(
                                              label: FxText.labelLarge(
                                            'action'.tr(),
                                            color: contentTheme.primary,
                                          )),
                                        ],
                                        rows: controller.customers
                                            .mapIndexed(
                                              (index, data) => DataRow(
                                                cells: [
                                                  DataCell(FxText.bodyMedium(
                                                      "#${data.id}")),
                                                  DataCell(
                                                    SizedBox(
                                                      width: 180,
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          FxContainer.none(
                                                            borderRadiusAll: 20,
                                                            clipBehavior: Clip
                                                                .antiAliasWithSaveLayer,
                                                            child: Image.asset(
                                                              Images.avatars[index %
                                                                  Images.avatars
                                                                      .length],
                                                              height: 40,
                                                              width: 40,
                                                            ),
                                                          ),
                                                          FxSpacing.width(12),
                                                          Expanded(
                                                            child: FxText
                                                                .labelLarge(
                                                              data.fullName,
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  DataCell(FxText.bodyMedium(
                                                      '${data.phoneNumber}')),
                                                  DataCell(FxText.bodyMedium(
                                                      '\$${data.balance}')),
                                                  DataCell(FxText.bodyMedium(
                                                      '${data.ordersCount}')),
                                                  DataCell(Align(
                                                    alignment: Alignment.center,
                                                    child: FxContainer.bordered(
                                                      onTap: () => {},
                                                      padding:
                                                          FxSpacing.xy(6, 6),
                                                      borderColor: contentTheme
                                                          .primary
                                                          .withAlpha(40),
                                                      child: Icon(
                                                        Icons.edit_outlined,
                                                        size: 14,
                                                        color: contentTheme
                                                            .primary,
                                                      ),
                                                    ),
                                                  )),
                                                ],
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }));
  }

  Widget buildRevenueChart() {
    List<SplineSeries<ChartSampleData, DateTime>> getDefaultAreaSeries() {
      return <SplineSeries<ChartSampleData, DateTime>>[
        SplineSeries<ChartSampleData, DateTime>(
          dataSource: controller.revenueChartData,
          opacity: 0.7,
          name: '${'Product'.tr()} A',
          color: contentTheme.primary.withAlpha(150),
          xValueMapper: (ChartSampleData sales, _) => sales.x as DateTime,
          yValueMapper: (ChartSampleData sales, _) => sales.y,
        ),
        SplineSeries<ChartSampleData, DateTime>(
          dataSource: controller.revenueChartData,
          opacity: 0.7,
          name: '${'Product'.tr()} B',
          color: contentTheme.danger.withAlpha(150),
          xValueMapper: (ChartSampleData sales, _) => sales.x as DateTime,
          yValueMapper: (ChartSampleData sales, _) => sales.secondSeriesYValue,
        )
      ];
    }

    return SizedBox(
      height: 400,
      child: SfCartesianChart(
        legend: Legend(opacity: 0.7, position: LegendPosition.bottom),
        plotAreaBorderWidth: 0,
        primaryXAxis: DateTimeAxis(
            interval: 1,
            intervalType: DateTimeIntervalType.months,
            majorGridLines: const MajorGridLines(width: 1),
            axisLine: AxisLine(width: 0),
            edgeLabelPlacement: EdgeLabelPlacement.shift),
        primaryYAxis: NumericAxis(
            labelFormat: '{value}',
            //title: AxisTitle(text: 'Revenue in millions'),
            interval: 4,
            axisLine: const AxisLine(
              width: 0,
            ),
            minimum: 16,
            majorGridLines: const MajorGridLines(width: 0),
            majorTickLines: const MajorTickLines(
              size: 16,
              width: 0,
              color: Colors.transparent,
            )),
        series: getDefaultAreaSeries(),
        tooltipBehavior: TooltipBehavior(enable: true),
      ),
    );
  }

  Widget buildComparisonChart() {
    List<ColumnSeries<ChartSampleData, DateTime>> getDefaultAreaSeries() {
      return <ColumnSeries<ChartSampleData, DateTime>>[
        ColumnSeries<ChartSampleData, DateTime>(
          dataSource: controller.comparisonChartData,
          opacity: 0.7,
          name: '${'Product'.tr()} A',
          width: 0.2,
          color: contentTheme.primary.withAlpha(150),
          xValueMapper: (ChartSampleData sales, _) => sales.x as DateTime,
          yValueMapper: (ChartSampleData sales, _) => sales.y,
        ),
        ColumnSeries<ChartSampleData, DateTime>(
          dataSource: controller.comparisonChartData,
          opacity: 0.7,
          name: '${'Product'.tr()} B',
          width: 0.2,
          color: contentTheme.danger.withAlpha(150),
          xValueMapper: (ChartSampleData sales, _) => sales.x as DateTime,
          yValueMapper: (ChartSampleData sales, _) => sales.secondSeriesYValue,
        )
      ];
    }

    return SizedBox(
      height: 400,
      child: SfCartesianChart(
        legend: Legend(opacity: 0.7, position: LegendPosition.bottom),
        plotAreaBorderWidth: 0,
        primaryXAxis: DateTimeAxis(
            interval: 1,
            intervalType: DateTimeIntervalType.days,
            majorGridLines: const MajorGridLines(width: 1),
            axisLine: AxisLine(width: 0),
            edgeLabelPlacement: EdgeLabelPlacement.shift),
        primaryYAxis: NumericAxis(
            labelFormat: '{value}',
            //title: AxisTitle(text: 'Revenue in millions'),
            interval: 4,
            minimum: 8,
            axisLine: const AxisLine(
              width: 0,
            ),
            majorGridLines: const MajorGridLines(width: 0),
            majorTickLines: const MajorTickLines(
              size: 16,
              width: 0,
              color: Colors.transparent,
            )),
        series: getDefaultAreaSeries(),
        tooltipBehavior: TooltipBehavior(enable: true),
      ),
    );
  }
}
