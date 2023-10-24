import 'package:core_erp/controllers/apps/ecommerce/orders_controller.dart';
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

class GezaAdminDashboard extends StatefulWidget {
  const GezaAdminDashboard({super.key});

  @override
  GezaAdminDashboardState createState() => GezaAdminDashboardState();
}

class GezaAdminDashboardState extends State<GezaAdminDashboard>
    with SingleTickerProviderStateMixin, UIMixin {
  late DashboardController controller;
  late OrdersController ordersController;
  @override
  void initState() {
    super.initState();
    controller = Get.put(DashboardController());
    ordersController = Get.put(OrdersController());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: FxSpacing.x(flexSpacing / 2),
      child: FxFlex(
        wrapAlignment: WrapAlignment.start,
        wrapCrossAlignment: WrapCrossAlignment.start,
        children: [
          FxFlexItem(
            sizes: "xl-3 lg-6 sm-12",
            child: FxCard(
                shadow:
                    FxShadow(elevation: 0.5, position: FxShadowPosition.bottom),
                padding: FxSpacing.xy(20, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FxText.headlineSmall(
                          "\12,000",
                          fontWeight: 600,
                        ),
                        FxSpacing.height(4),
                        FxText.bodySmall(
                          "total_users".tr().capitalizeWords,
                          muted: true,
                          fontWeight: 600,
                        ),
                      ],
                    ),
                    FxContainer(
                        color: contentTheme.primary.withAlpha(48),
                        child: Icon(
                          FeatherIcons.users,
                          color: contentTheme.primary,
                          size: 24,
                        ))
                  ],
                )),
          ),
          FxFlexItem(
            sizes: "xl-3 lg-6 sm-12",
            child: FxCard(
                shadow:
                    FxShadow(elevation: 0.5, position: FxShadowPosition.bottom),
                padding: FxSpacing.xy(20, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() => FxText.headlineSmall(
                              "${ordersController.orderRequests.length}",
                              fontWeight: 600,
                            )),
                        FxSpacing.height(4),
                        FxText.bodySmall(
                          "app_downloads".tr().capitalizeWords,
                          muted: true,
                          fontWeight: 600,
                        ),
                      ],
                    ),
                    FxContainer(
                        color: contentTheme.success.withAlpha(48),
                        child: Icon(
                          FeatherIcons.watch,
                          color: contentTheme.success,
                          size: 24,
                        ))
                  ],
                )),
          ),
          FxFlexItem(
            sizes: "xl-3 lg-6 sm-12",
            child: FxCard(
                shadow:
                    FxShadow(elevation: 0.5, position: FxShadowPosition.bottom),
                padding: FxSpacing.xy(20, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FxText.headlineSmall(
                          "248",
                          fontWeight: 600,
                        ),
                        FxSpacing.height(4),
                        FxText.bodySmall(
                          "hair_styles_published".tr().capitalizeWords,
                          muted: true,
                          fontWeight: 600,
                        ),
                      ],
                    ),
                    FxContainer(
                        color: contentTheme.secondary.withAlpha(48),
                        child: Icon(
                          FeatherIcons.bookmark,
                          color: contentTheme.secondary,
                          size: 24,
                        ))
                  ],
                )),
          ),
          FxFlexItem(
            sizes: "xl-3 lg-6 sm-12",
            child: FxCard(
                shadow:
                    FxShadow(elevation: 0.5, position: FxShadowPosition.bottom),
                padding: FxSpacing.xy(20, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FxText.headlineSmall(
                          "125k",
                          fontWeight: 600,
                        ),
                        FxSpacing.height(4),
                        FxText.bodySmall(
                          "total_stylists".tr().capitalizeWords,
                          muted: true,
                          fontWeight: 600,
                        ),
                      ],
                    ),
                    FxContainer(
                        color: contentTheme.danger.withAlpha(48),
                        child: Icon(
                          FeatherIcons.monitor,
                          color: contentTheme.danger,
                          size: 26,
                        ))
                  ],
                )),
          )
        ],
      ),
    );
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
