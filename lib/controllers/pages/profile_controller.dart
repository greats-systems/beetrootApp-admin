import 'package:core_erp/controllers/main_controller.dart';
import 'package:core_erp/models/chat.dart';
import 'package:core_erp/models/customer.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

class ChartData {
  ChartData(this.x, this.y, this.y1);

  final double x;
  final double y;
  final double y1;
}

class ProfileController extends MainController {
  FxFormValidator basicValidator = FxFormValidator();

  int fullWidthIndex = 0;
  final TickerProvider tickerProvider;
  bool showPassword = false;
  late TabController fullWidthTabController = TabController(
      length: 3, vsync: tickerProvider, initialIndex: fullWidthIndex);

  List<String> dummyTexts =
      List.generate(12, (index) => FxTextUtils.getDummyText(60));

  List<Chat> chats = [];
  List<Customer> customers = [];

  ProfileController(this.tickerProvider);

  final TooltipBehavior tooltipBehavior = TooltipBehavior(
    enable: true,
    textAlignment: ChartAlignment.center,
    header: '',
    canShowMarker: false,
  );

  final List<ChartData> chartData = [
    ChartData(1, 235, 240),
    ChartData(2, 242, 250),
    ChartData(3, 320, 280),
    ChartData(4, 360, 355),
    ChartData(5, 270, 245),
    ChartData(6, 120, 240),
    ChartData(7, 230, 200),
    ChartData(8, 140, 160),
    ChartData(9, 330, 280),
    ChartData(10, 270, 150),
  ];

  @override
  onInit() async {
    super.onInit();

    Customer.dummyList.then((value) {
      customers = value;
      update();
    });

    Chat.dummyList.then((value) {
      chats = value.sublist(0, 5);
      update();
    });

    fullWidthTabController.addListener(() {
      if (fullWidthIndex != fullWidthTabController.index) {
        fullWidthIndex = fullWidthTabController.index;
        update();
      }
    });
  }

  void onChangeShowPassword() {
    showPassword = !showPassword;
    update();
  }

  @override
  String getTag() {
    return "profile_controller";
  }
}
