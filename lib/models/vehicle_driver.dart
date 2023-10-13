import 'package:core_erp/models/person.dart';
import 'package:core_erp/models/transport_order.dart';
import 'package:core_erp/models/vehicle.dart';

class VehicleDriver {
  String? vehicleID;
  String? createdDate;
  String? updatedDate;
  String? deletedDate;
  Person? driver;
  Vehicle? vehicle;
  List<TransportOrder>? assignedOrders;

  VehicleDriver({
    this.vehicleID,
    this.createdDate,
    this.updatedDate,
    this.deletedDate,
    this.driver,
    this.vehicle,
    this.assignedOrders,
  });

  factory VehicleDriver.fromJson(Map<String, dynamic> json) {
    return VehicleDriver(
      vehicleID: json['vehicleID'],
      createdDate: json['createdDate'],
      updatedDate: json['updatedDate'],
      deletedDate: json['deletedDate'],
      driver: Person.fromJson(
          json['driver']), // Assuming User has a fromJson method
      vehicle: Vehicle.fromJson(
          json['vehicle']), // Assuming Vehicle has a fromJson method
      assignedOrders: (json['assignedOrders'] as List<dynamic>)
          .map((order) => TransportOrder.fromJson(
              order)) // Assuming TransportOrder has a fromJson method
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vehicleID': vehicleID,
      'createdDate': createdDate,
      'updatedDate': updatedDate,
      'deletedDate': deletedDate,
      'driver': driver!.toJson(), // Assuming User has a toJson method
      'vehicle': vehicle!.toJson(), // Assuming Vehicle has a toJson method
      'assignedOrders': assignedOrders!.map((order) => order.toJson()).toList(),
    };
  }
}
