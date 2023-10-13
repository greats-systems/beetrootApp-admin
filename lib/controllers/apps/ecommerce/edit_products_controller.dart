import 'dart:async';
import 'dart:convert';
import 'package:core_erp/controllers/auth/auth_controller.dart';
import 'package:core_erp/models/offerItem.dart';

import 'products_controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:core_erp/controllers/apps/files/file_upload_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutx/validation/form_validator.dart';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

enum Status {
  publish,
  unproved,
  draft;

  const Status();
}

enum Category {
  hair,
  cosmetics,
  product;

  const Category();
}

enum Trending {
  yes,
  no;

  const Trending();
}

class AddProductsController extends ProductsController {
  late FileUploadController fileUploadController =
      Get.put(FileUploadController());
  late AuthController authController = Get.put(AuthController());

  FxFormValidator basicValidator = FxFormValidator();
  Status selectedPublishStatus = Status.publish;
  Trending selectedTrendingStatus = Trending.no;

  Category selectedCategory = Category.hair;
  final List<String> categories = [];
  bool showOnline = true;
  var isSavingSuccess = false.obs;

  @override
  onInit() async {
    super.onInit();
    basicValidator.addField(
      'common_name',
      label: "Product Name",
      required: true,
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'description',
      label: "description",
      required: true,
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'tags',
      label: "Tags",
      required: true,
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'minimun_price',
      label: "Minimun Price",
      required: true,
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'category',
      label: "Minimun Price",
      required: true,
      controller: TextEditingController(),
    );
  }

  onAddNewItem() async {
    // construct form data
// Send FormData in POST request to upload file
    try {
      isSavingSuccess.value = true;
      debugPrint('onAddNewItem Method');
      var valData = basicValidator.getData();
      debugPrint('onAddNewItem common_name ${valData}');

      var body = {
        "authToken": 'admin',
        "vendorID": 'admin',
        "itemName": valData['common_name'],
        "minimumPrice": valData['minimun_price'],
        "itemCategory": selectedCategory.name == 'hair'
            ? 'hair style'
            : selectedCategory.name == 'cosmetics'
                ? 'skin & nail treatment'
                : 'product',
        "description": valData['description'],
        "trendingStatus": selectedTrendingStatus.name,
        "publishStatus": selectedPublishStatus.name,
        "quantity": "0",
      };
      debugPrint('onAddNewItem body $body');
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$apiUrl/offer-items/add-offer-items-images'),
      );
      for (PlatformFile file in fileUploadController.files) {
        // debugPrint('file.path.toString()  ${file.bytes.toString()}');

        List<int> imgBytes = file.bytes!.toList();
        // debugPrint('pickedXFile  $imgBytes');
        final multipartFile = http.MultipartFile.fromBytes('file', imgBytes,
            contentType: MediaType('image', 'jpeg'),
            filename: valData['common_name']);
        request.files.add(multipartFile);
      }
      debugPrint('multipartFile  ${request.files}');

      request.fields['owner'] = authController.person.value.userID.toString();
      request.fields['offer-item'] = jsonEncode(body);

      request.headers.addAll(
          {"Content-Type": "multipart/form-data", 'cookie': jsonEncode(body)});
      final responseStream = await request.send();
      final response = await http.Response.fromStream(responseStream);
      var decodedResponse = jsonDecode(response.body);
      var jSonData = jsonDecode(decodedResponse['data']);
      OfferItem decodeOfferItem = await OfferItem.fromJson(jSonData);

      var decodeOfferItemExist = accountOfferItemList
          .firstWhereOrNull((offer) => offer.itemID == decodeOfferItem.itemID);

      if (decodeOfferItemExist != null) {
        accountOfferItemList[accountOfferItemList.indexWhere(
                (offer) => offer.itemID == decodeOfferItem.itemID)] =
            decodeOfferItem;
      } else {
        accountOfferItemList.value = [...accountOfferItemList, decodeOfferItem];
      }

      Timer(const Duration(seconds: 1), () {
        isSavingSuccess.value = false;
        Get.toNamed('/apps/ecommerce/products');
      });
      isSavingSuccess.value = false;

      // Do something with the response
    } catch (err) {
      // Handle errors
      isSavingSuccess.value = false;

      print(err);
    }
  }

  void setOnlineType(bool value) {
    showOnline = value;
    update();
  }

  void onChangePublishStatus(Status? value) {
    debugPrint('onChangePublishStatus $value');

    selectedPublishStatus = value ?? selectedPublishStatus;
    update();
  }

  void onChangeTrending(Trending? value) {
    debugPrint('onChangeCategory $value');
    selectedTrendingStatus = value ?? selectedTrendingStatus;
    update();
  }

  void onChangeCategory(Category? value) {
    debugPrint('onChangeCategory $value');
    selectedCategory = value ?? selectedCategory;
    update();
  }

  @override
  String getTag() {
    return "add_product_controller";
  }
}
