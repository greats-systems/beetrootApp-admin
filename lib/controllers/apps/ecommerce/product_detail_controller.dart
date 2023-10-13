import 'package:core_erp/models/offerItem.dart';
import 'package:core_erp/models/offerItemImage.dart';
import 'package:get/get.dart';
import 'package:core_erp/controllers/main_controller.dart';
import 'package:core_erp/images.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

enum Size {
  small,
  medium,
  large,
  xl;

  const Size();
}

class ProductDetailController extends MainController {
  var offerItem =
      OfferItem(itemName: '', itemCategory: '', minimumPrice: '').obs;

  String selectedImage = Images.squareImages[2];
  OfferItemImage get selectedOfferItemImage => offerItem.value.images![0];
  var selectedOfferItemImagePath = '';
  List<String> dummyTexts =
      List.generate(12, (index) => FxTextUtils.getDummyText(60));

  final TickerProvider tickerProvider;
  List<String> images = [
    Images.squareImages[2],
    Images.squareImages[3],
    Images.squareImages[5],
    Images.squareImages[4],
  ];

  int defaultIndex = 0;
  int selectedQuntity = 1;
  String selectSize = "Small";
  late TabController defaultTabController = TabController(
    length: 2,
    vsync: tickerProvider,
    initialIndex: defaultIndex,
  );

  ProductDetailController(this.tickerProvider);

  @override
  onInit() async {
    super.onInit();

    defaultTabController.addListener(() {
      if (defaultIndex != defaultTabController.index) {
        defaultIndex = defaultTabController.index;
        update();
      }
    });
    if (offerItem.value.images != null) {
      selectedOfferItemImagePath =
          offerItem.value.images![0].filename.toString();
      update();
    }
  }

  void onChangeImage(String image) {
    selectedOfferItemImagePath = image;
    update();
  }

  void onSelectedQty(int qty) {
    selectedQuntity = qty;
    update();
  }

  void onSelectedSize(String size) {
    selectSize = size;
    update();
  }

  @override
  String getTag() {
    return "product_detail_controller";
  }
}
