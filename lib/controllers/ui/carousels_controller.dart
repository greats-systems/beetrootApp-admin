import 'dart:async';

import 'package:core_erp/controllers/main_controller.dart';
import 'package:flutter/material.dart';

class CarouselsController extends MainController {
  int simpleCarouselSize = 3, animatedCarouselSize = 3;
  int selectedSimpleCarousel = 0, selectedAnimatedCarousel = 0;

  Timer? timerAnimation;

  final PageController simplePageController = PageController(initialPage: 0);
  final PageController animatedPageController = PageController(initialPage: 0);

  CarouselsController();

  @override
  onInit() async {
    super.onInit();
    timerAnimation = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (selectedAnimatedCarousel < animatedCarouselSize - 1) {
        selectedAnimatedCarousel++;
      } else {
        selectedAnimatedCarousel = 0;
      }

      animatedPageController.animateToPage(
        selectedAnimatedCarousel,
        duration: Duration(milliseconds: 600),
        curve: Curves.ease,
      );
      update();
    });
  }

  void onChangeSimpleCarousel(int value) {
    selectedSimpleCarousel = value;
    update();
  }

  void onChangeAnimatedCarousel(int value) {
    selectedAnimatedCarousel = value;
    update();
  }

  @override
  void dispose() {
    super.dispose();
    timerAnimation?.cancel();
    simplePageController.dispose();
    animatedPageController.dispose();
  }

  @override
  String getTag() {
    return "carousels_controller";
  }
}
