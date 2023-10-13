import 'package:core_erp/controllers/main_controller.dart';
import 'package:core_erp/controllers/other/syncfusion_charts_controller.dart';
import 'package:core_erp/models/customer.dart';
import 'package:core_erp/models/product.dart';
import 'package:get/get.dart';

class DashboardController extends MainController {
  DashboardController();

  List<Product> products = [];
  List<Customer> customers = [];

  DateTime now = DateTime(2023, 9);

  //Data
  late final List<ChartSampleData> revenueChartData = <ChartSampleData>[
    ChartSampleData(
        x: now.subtract(Duration(days: 30 * 6)), y: 20, secondSeriesYValue: 24),
    ChartSampleData(
        x: now.subtract(Duration(days: 30 * 5)), y: 24, secondSeriesYValue: 28),
    ChartSampleData(
        x: now.subtract(Duration(days: 30 * 4)), y: 22, secondSeriesYValue: 26),
    ChartSampleData(
        x: now.subtract(Duration(days: 30 * 3)), y: 28, secondSeriesYValue: 32),
    ChartSampleData(
        x: now.subtract(Duration(days: 30 * 2)), y: 26, secondSeriesYValue: 30),
    ChartSampleData(
        x: now.subtract(Duration(days: 30 * 1)), y: 30, secondSeriesYValue: 34),
  ];

  late final List<ChartSampleData> comparisonChartData = <ChartSampleData>[
    ChartSampleData(
        x: now.subtract(Duration(days: 1 * 6)), y: 20, secondSeriesYValue: 24),
    ChartSampleData(
        x: now.subtract(Duration(days: 1 * 5)), y: 24, secondSeriesYValue: 28),
    ChartSampleData(
        x: now.subtract(Duration(days: 1 * 4)), y: 28, secondSeriesYValue: 24),
    ChartSampleData(
        x: now.subtract(Duration(days: 1 * 3)), y: 26, secondSeriesYValue: 32),
    ChartSampleData(
        x: now.subtract(Duration(days: 1 * 2)), y: 30, secondSeriesYValue: 26),
    ChartSampleData(
        x: now.subtract(Duration(days: 1 * 1)), y: 28, secondSeriesYValue: 32),
  ];

  @override
  onInit() async {
    super.onInit();

    Product.dummyList.then((value) {
      products = value.sublist(0, 5);
      update();
    });

    Customer.dummyList.then((value) {
      customers = value.sublist(0, 5);
      update();
    });
  }

  void goToProducts() {
    Get.toNamed('/apps/ecommerce/products');
  }

  void goToCustomers() {
    Get.toNamed('/apps/ecommerce/customers');
  }

  @override
  String getTag() {
    return "dashboard_controller";
  }
}
