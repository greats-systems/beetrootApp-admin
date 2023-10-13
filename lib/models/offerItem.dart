import 'package:core_erp/models/offerItemImage.dart';
import 'package:core_erp/models/person.dart';

class OfferItem {
  final String? itemID;
  final String? createdDate;
  final String? updatedDate;
  final String? itemName;
  final String? itemCategory;
  final String? quantity;
  final String? minimumPrice;
  final List<OfferItemImage>? images;
  final String? vendorID;
  final String? clientID;
  final String? offeringStatus;
  final Person? vendor;
  final Person? client;

  OfferItem({
    this.itemID,
    this.createdDate,
    this.updatedDate,
    required this.itemName,
    required this.itemCategory,
    required this.minimumPrice,
    this.quantity,
    this.images,
    this.vendorID,
    this.clientID,
    this.offeringStatus,
    this.vendor,
    this.client,
  });

  Map<String, dynamic> toJson() {
    return {
      'itemID': itemID,
      'createdDate': createdDate,
      'updatedDate': updatedDate,
      'itemName': itemName,
      'itemCategory': itemCategory,
      'quantity': quantity,
      'minimumPrice': minimumPrice,
      'images': images?.map((image) => image.toJson()).toList(),
      'vendorID': vendorID,
      'clientID': clientID,
      'offeringStatus': offeringStatus,
      'vendor': vendor?.toJson(),
      'client': client?.toJson(),
    };
  }

  factory OfferItem.fromJson(Map<String, dynamic> json) {
    return OfferItem(
      itemID: json['itemID'],
      createdDate: json['createdDate'],
      updatedDate: json['updatedDate'],
      itemName: json['itemName'],
      itemCategory: json['itemCategory'],
      quantity: json['quantity'],
      minimumPrice: json['minimumPrice'],
      images: (json['images'] as List<dynamic>?)
          ?.map((imageJson) => OfferItemImage.fromJson(imageJson))
          .toList(),
      vendorID: json['vendorID'],
      clientID: json['clientID'],
      offeringStatus: json['offeringStatus'],
      vendor: json['vendor'] != null ? Person.fromJson(json['vendor']) : null,
      client: json['client'] != null ? Person.fromJson(json['client']) : null,
    );
  }
}
