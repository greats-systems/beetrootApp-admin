import 'package:core_erp/models/business.dart';
import 'package:core_erp/models/offerItem.dart';
import 'package:core_erp/models/order.dart';
import 'package:core_erp/models/wallet.dart';
import 'package:core_erp/models/warehouse_receipt.dart';

class Person {
  String? userID;
  String? createdDate;
  String? updatedDate;
  String? deletedDate;
  String? firstName;
  String? lastName;
  String? phone;
  String? password; // Excluded from JSON serialization
  String? email;
  String? role;
  String? profileImage;
  String? city;
  String? neighbourhood;
  String? walletAddress;
  bool? onlineStatus;
  String? streetAddress;
  String? accountType;
  String? tradingAs;
  Wallet? wallet;
  Business? business;
  List<OfferItem>? offerItems;
  String? avatarId;
  List<Order>? orders;
  List<WarehouseReceipt>? warehouseReceipts;

  Person({
    this.userID,
    this.createdDate,
    this.updatedDate,
    this.deletedDate,
    this.firstName,
    this.lastName,
    this.phone,
    this.password,
    this.email,
    this.role,
    this.profileImage,
    this.city,
    this.neighbourhood,
    this.walletAddress,
    this.onlineStatus,
    this.streetAddress,
    this.accountType,
    this.tradingAs,
    this.wallet,
    // this.business,
    this.offerItems,
    // this.avatarId,
    this.orders,
    this.warehouseReceipts,
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      userID: json['userID'],
      createdDate: json['createdDate'],
      updatedDate: json['updatedDate'],
      deletedDate: json['deletedDate'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phone: json['phone'],
      password: json['password'],
      email: json['email'],
      role: json['role'],
      profileImage: json['profileImage'],
      city: json['city'],
      neighbourhood: json['neighbourhood'],
      walletAddress: json['walletAddress'],
      onlineStatus: json['onlineStatus'],
      streetAddress: json['streetAddress'],
      accountType: json['accountType'],
      tradingAs: json['tradingAs'],
      wallet: json['wallet'] != null ? Wallet.fromJson(json['wallet']) : null,
      // business: json['business'] != null ? Business.fromJson(json['business']):null,
      offerItems: json['OfferItems'] != null
          ? (json['OfferItems'] as List<dynamic>)
              .map((offerItem) => OfferItem.fromJson(offerItem))
              .toList()
          : null,
      orders: json['orders'] != null
          ? (json['orders'] as List<dynamic>)
              .map((order) => Order.fromJson(order))
              .toList()
          : null,
      warehouseReceipts: json['warehouseReceipts'] != null
          ? (json['warehouseReceipts'] as List<dynamic>)
              .map((warehouseReceipt) =>
                  WarehouseReceipt.fromJson(warehouseReceipt))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userID': userID,
      'createdDate': createdDate,
      'updatedDate': updatedDate,
      'deletedDate': deletedDate,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'password': password,
      'email': email,
      'role': role,
      'profileImage': profileImage,
      'city': city,
      'neighbourhood': neighbourhood,
      'walletAddress': walletAddress,
      'onlineStatus': onlineStatus,
      'streetAddress': streetAddress,
      'accountType': accountType,
      'tradingAs': tradingAs,
      'wallet': wallet != null ? wallet!.toJson() : null,
      // 'business': business!.toJson(),
      'OfferItems': offerItems != null
          ? offerItems!.map((offerItem) => offerItem.toJson()).toList()
          : null,
      'orders': orders != null
          ? orders!.map((order) => order.toJson()).toList()
          : null,
      'warehouseReceipts': warehouseReceipts != null
          ? warehouseReceipts!
              .map((warehouseReceipt) => warehouseReceipt.toJson())
              .toList()
          : null,
    };
  }
}
