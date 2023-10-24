import 'dart:convert';

import 'package:core_erp/models/geza/Review.dart';
import 'package:core_erp/models/geza/beautyServiceImage.dart';
import 'package:core_erp/models/geza/catelog.dart';
import 'package:core_erp/models/order.dart';

class SpecialisedService {
  final String? id;
  final String? createdDate;
  final String? updatedDate;
  final String? name;
  final String? category;
  final String? description;
  final double? price;
  final List<SpecialisedServiceImage>? images;
  final List<Order>? orders;
  final String? catalogID;
  final String? providerID;
  final String? tradeStatus;
  final Catalog? catalog;
  final List<Review>? reviews;

  SpecialisedService({
    this.id,
    this.createdDate,
    this.updatedDate,
    required this.name,
    required this.category,
    this.price,
    this.description,
    this.images,
    this.catalogID,
    this.providerID,
    this.tradeStatus,
    this.catalog,
    this.orders,
    this.reviews,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdDate': createdDate,
      'updatedDate': updatedDate,
      'name': name,
      'category': category,
      'description': description,
      'price': price,
      'images': images?.map((image) => image.toJson()).toList(),
      'catalogID': catalogID,
      'providerID': providerID,
      'tradeStatus': tradeStatus,
      'catalog': catalog?.toJson(),
      'reviews': reviews?.map((review) => review.toJson()).toList(),
    };
  }

  factory SpecialisedService.fromJson(Map<String, dynamic> json) {
    // debugPrint('beautyService --- fromJson json[catalog]  ${json['catalog']}');

    SpecialisedService beautyService = SpecialisedService(
      id: json['id'],
      createdDate: json['createdDate'],
      updatedDate: json['updatedDate'],
      name: json['name'],
      category: json['category'],
      description: json['description'],
      price:
          json['price'] != null ? double.tryParse(json['price'].toString()) : 0,
      images: json['images'] != null
          ? (json['images'] as List<dynamic>?)
              ?.map((imageJson) => SpecialisedServiceImage.fromJson(imageJson))
              .toList()
          : <SpecialisedServiceImage>[],
      catalogID: json['catalogID'],
      providerID: json['providerID'],
      tradeStatus: json['tradeStatus'],
      // orders: json['orders'] != null
      //     ? List<Order>.from(
      //         json['orders'].map((order) => Order.fromJson(order)))
      //     : <Order>[],
      catalog: json['catalog'] != null
          // ? Catalog.fromJson(jsonDecode(json['catalog']))
          ? Catalog.fromJson(json['catalog'])
          : null,
      reviews: json['reviews'] != null
          ? (json['reviews'] as List<dynamic>?)
              ?.map((imageJson) => Review.fromJson(jsonDecode(imageJson)))
              .toList()
          : <Review>[],
    );
    // debugPrint('beautyService --- fromJson beautyService  ${beautyService.id}');

    return beautyService;
  }
}
