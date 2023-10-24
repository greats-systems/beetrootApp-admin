import 'dart:convert';
import 'package:core_erp/models/geza/specialisedService.dart';
import 'package:core_erp/models/product.dart';
import 'package:core_erp/models/vendor.dart';
import 'package:flutter/cupertino.dart';

class Catalog {
  final String? id;
  final String? createdDate;
  final String? updatedDate;
  final String? name;
  final String? catalogType;
  final String? description;
  final Provider? manager;
  List<SpecialisedService>? services;
  List<Product>? products;


  Catalog({
    this.id,
    this.createdDate,
    this.updatedDate,
    this.name,
    this.description,
    this.catalogType,
    this.manager,
    required this.services,
  });

  // Serialize the object to a JSON string
  String toJson() {
    return jsonEncode({
      'id': id,
      'createdDate': createdDate,
      'updatedDate': updatedDate,
      'name': name,
      'description': description,
      'catalogType': catalogType,
      'manager': manager != null ? manager!.toJson() : null,
      'services': services != null
          ? services!.map((item) => item.toJson()).toList()
          : null,

    });
  }

  // Deserialize a JSON string to create a Catalog object
  factory Catalog.fromJson(Map<String, dynamic> jsonData) {
    // debugPrint('Catalog.fromJson ${jsonData['manager']}');
    return Catalog(
      id: jsonData['id'],
      createdDate: jsonData['createdDate'],
      updatedDate: jsonData['updatedDate'],
      name: jsonData['name'],
      description: jsonData['description'],
      catalogType: jsonData['catalogType'],
      manager: jsonData['manager'] != null
          // ? Provider.fromJson(jsonDecode(jsonData['manager']))
          ? Provider.fromJson(jsonData['manager'])
          : null,
      services: jsonData['services'] != null
          ? (jsonData['services'] as List<dynamic>)
              .map((itemData) => SpecialisedService.fromJson(itemData))
              .toList()
          : <SpecialisedService>[],
    );
  }
  // Deserialize a JSON List to create a List of VendorOfferItems
  List<Catalog> listFromJson(String jsonStr) {
    final List<dynamic> jsonDataList = jsonDecode(jsonStr);
    return jsonDataList.map((jsonItem) => Catalog.fromJson(jsonItem)).toList();
  }
}
