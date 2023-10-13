import 'package:core_erp/models/vehicle.dart';

class VehicleImage {
  String? imageID;
  String? filename;
  String? path;
  String? mimetype;
  Vehicle? vehicle;

  VehicleImage({
    this.imageID,
    this.filename,
    this.path,
    this.mimetype,
    this.vehicle,
  });

  factory VehicleImage.fromJson(Map<String, dynamic> json) {
    return VehicleImage(
      imageID: json['imageID'],
      filename: json['filename'],
      path: json['path'],
      mimetype: json['mimetype'],
      vehicle: Vehicle.fromJson(
          json['vehicle']), // Assuming Vehicle has a fromJson method
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imageID': imageID,
      'filename': filename,
      'path': path,
      'mimetype': mimetype,
      'vehicle': vehicle!.toJson(),
    };
  }
}
