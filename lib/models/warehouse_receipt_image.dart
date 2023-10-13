import 'package:core_erp/models/warehouse_receipt.dart';

class WarehouseReceiptImage {
  String? imageID;
  String? filename;
  String? path;
  String? mimetype;
  WarehouseReceipt? warehouseReceipt;

  WarehouseReceiptImage({
    this.imageID,
    this.filename,
    this.path,
    this.mimetype,
    this.warehouseReceipt,
  });

  factory WarehouseReceiptImage.fromJson(Map<String, dynamic> json) {
    return WarehouseReceiptImage(
      imageID: json['imageID'],
      filename: json['filename'],
      path: json['path'],
      mimetype: json['mimetype'],
      warehouseReceipt: WarehouseReceipt.fromJson(json[
          'warehouseReceipt']), // Assuming WarehouseReceipt has a fromJson method
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imageID': imageID,
      'filename': filename,
      'path': path,
      'mimetype': mimetype,
      'warehouseReceipt': warehouseReceipt!.toJson(),
    };
  }
}
