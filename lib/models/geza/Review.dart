

import 'package:core_erp/models/geza/specialisedService.dart';
import 'package:core_erp/models/person.dart';

class Review {
  final String? commentID;
  final String? createdDate;
  final String? updatedDate;
  final SpecialisedService? service;
  final Person? reviewer;
  final String? review;
  final List<Review>? comments;

  Review({
    this.commentID,
    this.createdDate,
    this.updatedDate,
    this.service,
    this.reviewer,
    this.review,
    this.comments,
  });

  Map<String, dynamic> toJson() {
    return {
      'commentID': commentID,
      'createdDate': createdDate,
      'updatedDate': updatedDate,
      'review': review,
      'service': service?.toJson(),
      'reviewer': reviewer?.toJson(),
      'comments': comments?.map((comment) => comment.toJson()).toList(),
    };
  }

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      commentID: json['commentID'],
      createdDate: json['createdDate'],
      updatedDate: json['updatedDate'],
      reviewer:
          json['reviewer'] != null ? Person.fromJson(json['reviewer']) : null,
      service: json['service'] != null
          ? SpecialisedService.fromJson(json['service'])
          : null,
      review: json['review'],
      comments: json['comments'] != null
          ? (json['comments'] as List<dynamic>?)
              ?.map((imageJson) => Review.fromJson(imageJson))
              .toList()
          : <Review>[],
    );
  }
}
