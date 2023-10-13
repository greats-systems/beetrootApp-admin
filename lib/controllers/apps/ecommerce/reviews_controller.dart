import 'package:core_erp/controllers/main_controller.dart';
import 'package:core_erp/models/reviews.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get.dart';

class ReviewsController extends MainController {
  bool liked = false;
  int initialRating = -1;
  List<Review> reviews = [];

  ReviewsController();

  List<String> dummyTexts =
      List.generate(12, (index) => FxTextUtils.getDummyText(60));

  DateTimeRange? selectedDateTimeRange;

  Future<void> pickDateRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
        context: Get.context!,
        initialEntryMode: DatePickerEntryMode.input,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDateTimeRange) {
      selectedDateTimeRange = picked;
      update();
    }
  }

  onChangeLike() {
    liked = !liked;
    update();
  }

  @override
  onInit() async {
    super.onInit();
    Review.dummyList.then((value) {
      reviews = value;
      update();
    });
  }

  @override
  String getTag() {
    return "reviews_controller";
  }
}
