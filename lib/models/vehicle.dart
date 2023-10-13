import 'package:core_erp/models/person.dart';
import 'package:core_erp/models/transport_order.dart';
import 'package:core_erp/models/vehicle_image.dart';

class Vehicle {
  String? vehicleID;
  String? createdDate;
  String? updatedDate;
  String? deletedDate;
  String? vehicleClass;
  String? manufacturer;
  String? carryingWeightMax;
  String? carryingWeightMin;
  String? engineNumber;
  String? gvtRegNumber;
  String? description;
  bool? routesActive;
  bool? onSale;
  Person? provider; // Assuming you have a Person class
  Person? driver; // Assuming you have a User class
  List<TransportOrder>? orders; // Assuming you have a TransportOrder class
  List<VehicleImage>? images; // Assuming you have a VehicleImage class

  Vehicle({
    this.vehicleID,
    this.createdDate,
    this.updatedDate,
    this.deletedDate,
    this.vehicleClass,
    this.manufacturer,
    this.carryingWeightMax,
    this.carryingWeightMin,
    this.engineNumber,
    this.gvtRegNumber,
    this.description,
    this.routesActive,
    this.onSale,
    this.provider,
    this.driver,
    this.orders,
    this.images,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      vehicleID: json['vehicleID'],
      createdDate: json['createdDate'],
      updatedDate: json['updatedDate'],
      deletedDate: json['deletedDate'],
      vehicleClass: json['vehicleClass'],
      manufacturer: json['manufacturer'],
      carryingWeightMax: json['carryingWeightMax'],
      carryingWeightMin: json['carryingWeightMin'],
      engineNumber: json['engineNumber'],
      gvtRegNumber: json['gvtRegNumber'],
      description: json['description'],
      routesActive: json['routesActive'],
      onSale: json['onSale'],
      provider: Person.fromJson(
          json['provider']), // Assuming Person has a fromJson method
      orders: (json['orders'] as List<dynamic>)
          .map((order) => TransportOrder.fromJson(
              order)) // Assuming TransportOrder has a fromJson method
          .toList(),
      images: (json['images'] as List<dynamic>)
          .map((image) => VehicleImage.fromJson(
              image)) // Assuming VehicleImage has a fromJson method
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vehicleID': vehicleID,
      'createdDate': createdDate,
      'updatedDate': updatedDate,
      'deletedDate': deletedDate,
      'vehicleClass': vehicleClass,
      'manufacturer': manufacturer,
      'carryingWeightMax': carryingWeightMax,
      'carryingWeightMin': carryingWeightMin,
      'engineNumber': engineNumber,
      'gvtRegNumber': gvtRegNumber,
      'description': description,
      'routesActive': routesActive,
      'onSale': onSale,
      'provider': provider!.toJson(), // Assuming User has a toJson method
      'driver': driver!.toJson(), // Assuming User has a toJson method
      'orders': orders!.map((order) => order.toJson()).toList(),
      'images': images!.map((image) => image.toJson()).toList(),
    };
  }
}
