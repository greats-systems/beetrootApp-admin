import 'package:core_erp/models/employee.dart';
import 'package:core_erp/models/offerItem.dart';
import 'package:core_erp/models/order.dart';
import 'package:core_erp/models/wallet.dart';

class Business {
  String? businessID;
  String? adminID;
  String? createdDate;
  String? updatedDate;
  String? deletedDate;
  String? tradingName;
  String? tradingAs;
  String? walletAddress;
  Wallet? wallet;
  String? profileImage;
  String? city;
  String? neighbourhood;
  String? businessType;
  String? streetAddress;
  List<OfferItem>? offerItems;
  List<Order>? orders;
  List<Employee>? employees;

  Business({
    this.businessID,
    this.adminID,
    this.createdDate,
    this.updatedDate,
    this.deletedDate,
    this.tradingName,
    this.tradingAs,
    this.walletAddress,
    this.wallet,
    this.profileImage,
    this.city,
    this.neighbourhood,
    this.businessType,
    this.streetAddress,
    this.offerItems,
    this.orders,
    this.employees,
  });

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      businessID: json['businessID'],
      adminID: json['adminID'],
      createdDate: json['createdDate'],
      updatedDate: json['updatedDate'],
      deletedDate: json['deletedDate'],
      tradingName: json['tradingName'],
      tradingAs: json['tradingAs'],
      walletAddress: json['walletAddress'],
      wallet: Wallet.fromJson(json['wallet']),
      profileImage: json['profileImage'],
      city: json['city'],
      neighbourhood: json['neighbourhood'],
      businessType: json['businessType'],
      streetAddress: json['streetAddress'],
      offerItems: (json['offerItems'] as List<dynamic>)
          .map((offerItem) => OfferItem.fromJson(offerItem))
          .toList(),
      orders: (json['orders'] as List<dynamic>)
          .map((order) => Order.fromJson(order))
          .toList(),
      employees: (json['employees'] as List<dynamic>)
          .map((employee) => Employee.fromJson(employee))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'businessID': businessID,
      'adminID': adminID,
      'createdDate': createdDate,
      'updatedDate': updatedDate,
      'deletedDate': deletedDate,
      'tradingName': tradingName,
      'tradingAs': tradingAs,
      'walletAddress': walletAddress,
      'wallet': wallet!.toJson(),
      'profileImage': profileImage,
      'city': city,
      'neighbourhood': neighbourhood,
      'businessType': businessType,
      'streetAddress': streetAddress,
      'offerItems': offerItems!.map((offerItem) => offerItem.toJson()).toList(),
      'orders': orders!.map((order) => order.toJson()).toList(),
      'employees': employees!.map((employee) => employee.toJson()).toList(),
    };
  }
}
