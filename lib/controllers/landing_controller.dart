import 'package:core_erp/controllers/main_controller.dart';
import 'package:core_erp/models/landing.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

class LandingController extends MainController {
  List<Landing> landing = [];

  bool shadowColor = false;

  List<String> dummyTexts =
      List.generate(12, (index) => FxTextUtils.getDummyText(60));
  var defaultIndex = 0, backgroundIndex = 0;
  final TickerProvider tickerProvider;

  late TabController defaultTabController = TabController(
    length: 6,
    vsync: tickerProvider,
    initialIndex: defaultIndex,
  );
  late TabController backgroundTabController = TabController(
    length: 2,
    vsync: tickerProvider,
    initialIndex: backgroundIndex,
  );

  LandingController(this.tickerProvider);

  @override
  onInit() async {
    super.onInit();
    Landing.dummyList.then((value) {
      landing = value;
      update();
    });

    defaultTabController.addListener(() {
      if (defaultIndex != defaultTabController.index) {
        defaultIndex = defaultTabController.index;
        update();
      }
    });
    backgroundTabController.addListener(() {
      if (backgroundIndex != backgroundTabController.index) {
        backgroundIndex = backgroundTabController.index;
        update();
      }
    });
  }

  @override
  String getTag() {
    return "appexy_controller";
  }
}
