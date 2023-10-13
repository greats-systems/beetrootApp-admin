import 'package:core_erp/models/offerItem.dart';
import 'package:core_erp/models/order.dart';
import 'package:core_erp/models/person.dart';
import 'package:core_erp/models/wallet.dart';
import 'package:core_erp/models/warehouse_receipt_image.dart';

class WarehouseReceipt {
  String? warehouseReceiptID;
  String? warehouseReceiptDate;
  String? createdDate;
  String? updatedDate;
  String? deletedDate;
  String? warehouseReceiptPublicChainTracker;
  String? warehouseReceiptStatus;
  String? updatedStatus;
  String? updatedStatusMessage;
  double? commodityWeight;
  String? offerItemCategory;
  double? tradeableAmount;
  Person? provider;
  Person? customer;
  OfferItem? offerItem;
  Wallet? wallet;
  Order? warehouseOrder;
  List<WarehouseReceiptImage>? images;

  WarehouseReceipt({
    this.warehouseReceiptID,
    this.warehouseReceiptDate,
    this.createdDate,
    this.updatedDate,
    this.deletedDate,
    this.warehouseReceiptPublicChainTracker,
    this.warehouseReceiptStatus,
    this.updatedStatus,
    this.updatedStatusMessage,
    this.commodityWeight,
    this.offerItemCategory,
    this.tradeableAmount,
    this.provider,
    this.customer,
    this.offerItem,
    this.wallet,
    this.warehouseOrder,
    this.images,
  });

  factory WarehouseReceipt.fromJson(Map<String, dynamic> json) {
    return WarehouseReceipt(
      warehouseReceiptID: json['warehouseReceiptID'],
      warehouseReceiptDate: json['warehouseReceiptDate'],
      createdDate: json['createdDate'],
      updatedDate: json['updatedDate'],
      deletedDate: json['deletedDate'],
      warehouseReceiptPublicChainTracker:
          json['warehouseReceiptPublicChainTracker'],
      warehouseReceiptStatus: json['warehouseReceiptStatus'],
      updatedStatus: json['updatedStatus'],
      updatedStatusMessage: json['updatedStatusMessage'],
      commodityWeight: json['commodityWeight'].toDouble(),
      offerItemCategory: json['offerItemCategory'],
      tradeableAmount: json['tradeableAmount'].toDouble(),
      provider: Person.fromJson(
          json['provider']), // Assuming Person has a fromJson method
      customer: Person.fromJson(
          json['customer']), // Assuming Person has a fromJson method
      offerItem: OfferItem.fromJson(
          json['offerItem']), // Assuming OfferItem has a fromJson method
      wallet: Wallet.fromJson(
          json['wallet']), // Assuming Wallet has a fromJson method
      warehouseOrder: Order.fromJson(
          json['warehouseOrder']), // Assuming Order has a fromJson method
      images: (json['images'] as List<dynamic>)
          .map((image) => WarehouseReceiptImage.fromJson(image))
          .toList(), // Assuming WarehouseReceiptImage has a fromJson method
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'warehouseReceiptID': warehouseReceiptID,
      'warehouseReceiptDate': warehouseReceiptDate,
      'createdDate': createdDate,
      'updatedDate': updatedDate,
      'deletedDate': deletedDate,
      'warehouseReceiptPublicChainTracker': warehouseReceiptPublicChainTracker,
      'warehouseReceiptStatus': warehouseReceiptStatus,
      'updatedStatus': updatedStatus,
      'updatedStatusMessage': updatedStatusMessage,
      'commodityWeight': commodityWeight,
      'offerItemCategory': offerItemCategory,
      'tradeableAmount': tradeableAmount,
      'provider': provider!.toJson(),
      'customer': customer!.toJson(),
      'offerItem': offerItem!.toJson(),
      'wallet': wallet!.toJson(),
      'warehouseOrder': warehouseOrder!.toJson(),
      'images': images!.map((image) => image.toJson()).toList(),
    };
  }
}
