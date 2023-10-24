class SpecialisedServiceImage {
  final String? imageID;
  final String? createdDate;
  final String? updatedDate;
  final String? filename;

  SpecialisedServiceImage({
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

  factory SpecialisedServiceImage.fromJson(Map<String, dynamic> json) {
    return SpecialisedServiceImage(
      imageID: json['imageID'],
      createdDate: json['createdDate'],
      updatedDate: json['updatedDate'],
      filename: json['filename'],
    );
  }
}
