import 'package:core_erp/models/offerItem.dart';
import 'package:core_erp/models/person.dart';

class Order {
  final String? orderID;
  final String? orderDate;
  final String? createdDate;
  final String? updatedDate;
  final String? bookedServiceDate;
  final String? deletedDate;
  final String? orderTrackerHash;
  final String? orderStatus;
  final String? quantity;
  final int? commodityWeight;
  final String? offerItemCategory;
  final String? totalAmount;
  final String? updatedStatus;
  final Person? provider;
  final Person? customer;
  final OfferItem? offerItem;

  Order({
    this.orderID,
    this.orderDate,
    this.createdDate,
    this.bookedServiceDate,
    this.updatedDate,
    this.deletedDate,
    this.orderTrackerHash,
    this.orderStatus,
    this.quantity,
    this.commodityWeight,
    this.offerItemCategory,
    this.totalAmount,
    this.updatedStatus,
    this.provider,
    this.customer,
    this.offerItem,
  });

  Map<String, dynamic> toJson() {
    return {
      'orderID': orderID,
      'orderDate': orderDate,
      'createdDate': createdDate,
      'updatedDate': updatedDate,
      'bookedServiceDate': bookedServiceDate,
      'deletedDate': deletedDate,
      'orderTrackerHash': orderTrackerHash,
      'orderStatus': orderStatus,
      'quantity': quantity,
      'commodityWeight': commodityWeight,
      'offerItemCategory': offerItemCategory,
      'totalAmount': totalAmount,
      'updatedStatus': updatedStatus,
      'provider': provider?.toJson(),
      'customer': customer?.toJson(),
      'offerItem': offerItem?.toJson(),
    };
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderID: json['orderID'],
      orderDate: json['orderDate'],
      createdDate: json['createdDate'],
      updatedDate: json['updatedDate'],
      bookedServiceDate: json['bookedServiceDate'],
      deletedDate: json['deletedDate'],
      orderTrackerHash: json['orderTrackerHash'],
      orderStatus: json['orderStatus'],
      quantity: json['quantity'],
      commodityWeight: json['commodityWeight'],
      offerItemCategory: json['offerItemCategory'],
      totalAmount: json['totalAmount'],
      updatedStatus: json['updatedStatus'],
      provider:
          json['provider'] != null ? Person.fromJson(json['provider']) : null,
      customer:
          json['customer'] != null ? Person.fromJson(json['customer']) : null,
      offerItem: json['offerItem'] != null
          ? OfferItem.fromJson(json['offerItem'])
          : null,
    );
  }
}
