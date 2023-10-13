class OfferItemImage {
  final String? imageID;
  final String? createdDate;
  final String? updatedDate;
  final String? filename;

  OfferItemImage({
    this.imageID,
    this.createdDate,
    this.updatedDate,
    required this.filename,
  });

  Map<String, dynamic> toJson() {
    return {
      'imageID': imageID,
      'createdDate': createdDate,
      'updatedDate': updatedDate,
      'filename': filename,
    };
  }

  factory OfferItemImage.fromJson(Map<String, dynamic> json) {
    return OfferItemImage(
      imageID: json['imageID'],
      createdDate: json['createdDate'],
      updatedDate: json['updatedDate'],
      filename: json['filename'],
    );
  }
}
