import 'dart:convert';

import 'package:core_erp/models/offerItem.dart';
import 'package:core_erp/models/person.dart';
import 'package:flutter/cupertino.dart';

class Provider {
  final Person provider;
  final List<OfferItem> offerItems;

  Provider({
    required this.provider,
    required this.offerItems,
  });

  // Serialize the object to a JSON string
  String toJson() {
    return jsonEncode({
      'provider': provider.toJson(),
      'offerItems': offerItems.map((item) => item.toJson()).toList(),
    });
  }

  // Deserialize a JSON string to create a Provider object
  factory Provider.fromJson(String jsonStr) {
    debugPrint('get Providers jsonStr');
    final Map<String, dynamic> jsonData = jsonDecode(jsonStr);
    return Provider(
      provider: Person.fromJson(jsonData),
      offerItems: (jsonData['offerItems'] as List<dynamic>)
          .map((itemData) => OfferItem.fromJson(itemData))
          .toList(),
    );
  }

  // Deserialize a JSON List to create a List of VendorOfferItems
  List<Provider> listFromJson(String jsonStr) {
    final List<dynamic> jsonDataList = jsonDecode(jsonStr);
    return jsonDataList.map((jsonItem) => Provider.fromJson(jsonItem)).toList();
  }
}
