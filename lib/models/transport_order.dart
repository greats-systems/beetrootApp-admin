import 'package:core_erp/models/order.dart';
import 'package:core_erp/models/vehicle.dart';

class TransportOrder {
  String? transportOrderID;
  String? createdDate;
  String? updatedDate;
  String? deletedDate;
  List<Vehicle>? assignedVehicle;
  Order? salesOrder;

  TransportOrder({
    this.transportOrderID,
    this.createdDate,
    this.updatedDate,
    this.deletedDate,
    this.assignedVehicle,
    this.salesOrder,
  });

  factory TransportOrder.fromJson(Map<String, dynamic> json) {
    return TransportOrder(
      transportOrderID: json['transportOrderID'],
      createdDate: json['createdDate'],
      updatedDate: json['updatedDate'],
      deletedDate: json['deletedDate'],
      assignedVehicle: (json['assignedVehicle'] as List<dynamic>)
          .map((vehicle) => Vehicle.fromJson(
              vehicle)) // Assuming Vehicle has a fromJson method
          .toList(),
      salesOrder: Order.fromJson(
          json['salesOrder']), // Assuming Order has a fromJson method
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'transportOrderID': transportOrderID,
      'createdDate': createdDate,
      'updatedDate': updatedDate,
      'deletedDate': deletedDate,
      'assignedVehicle':
          assignedVehicle!.map((vehicle) => vehicle.toJson()).toList(),
      'salesOrder': salesOrder!.toJson(),
    };
  }
}
