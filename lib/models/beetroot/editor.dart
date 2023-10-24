import 'dart:convert';

import 'package:core_erp/models/beetroot/exhibit_model.dart';
import 'package:core_erp/models/beetroot/questionnaire.dart';
import 'package:core_erp/models/person.dart';

class Editor {
  String? employeeID;
  DateTime? createdDate;
  DateTime? updatedDate;
  DateTime? deletedDate;
  Person? user;
  List<Exhibit>? exhibits;
  List<Questionnaire>? questionnaire;

  Editor({
    this.employeeID,
    this.createdDate,
    this.updatedDate,
    this.deletedDate,
    this.user,
    this.exhibits,
    this.questionnaire,
  });

  // Serialization (toJson) method
  Map<String, dynamic> toJson() {
    return {
      'employeeID': employeeID,
      'createdDate': createdDate!.toIso8601String(),
      'updatedDate': updatedDate!.toIso8601String(),
      'deletedDate': deletedDate!.toIso8601String(),
      'user': user!.toJson(), // Assuming User has a toJson method.
      'exhibits': exhibits!.map((exhibit) => exhibit.toJson()).toList(),
      'questionnaire': questionnaire!
          .map((questionnaire) => questionnaire.toJson())
          .toList(),
    };
  }

  // Deserialization (fromJson) factory method
  factory Editor.fromJson(Map<String, dynamic> json) {
    return Editor(
      employeeID: json['employeeID'],
      createdDate: DateTime.parse(json['createdDate']),
      updatedDate: DateTime.parse(json['updatedDate']),
      deletedDate: DateTime.parse(json['deletedDate']),
      user: Person.fromJson(
          json['user']), // Assuming User has a fromJson factory method.
      exhibits: (json['exhibits'] as List)
          .map((exhibitJson) => Exhibit.fromJson(exhibitJson))
          .toList(), // Assuming Exhibit has a fromJson factory method.
      questionnaire: (json['questionnaire'] as List)
          .map((questionnaireJson) => Questionnaire.fromJson(questionnaireJson))
          .toList(), // Assuming Questionnaire has a fromJson factory method.
    );
  }
}

// You need to implement similar toJson and fromJson methods for User, Exhibit, and Questionnaire classes.
