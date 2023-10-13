import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:core_erp/models/model.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlService {
  static goToUrl(String url) async {
    await launchUrl(Uri.parse(url));
  }

  static goToPurchase() {
    goToUrl(
        'https://codecanyon.net/item/core_erp-flutter-admin-panel/45285824');
  }

  static getCurrentUrl() {
    var path = Uri.base.path;
    return path.replaceAll('core_erp/web/', '');
  }
}
