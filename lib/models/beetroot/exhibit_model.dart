import 'package:core_erp/models/beetroot/editor.dart';
import 'package:core_erp/models/beetroot/questionnaire.dart';
import 'package:core_erp/models/person.dart';

class Exhibit {
  String? id;
  DateTime? createdDate;
  DateTime? updatedDate;
  DateTime? deletedDate;
  Person? client;
  Editor? editor;
  Questionnaire? questionnaire;
  List<Question>? questions;

  Exhibit({
    this.id,
    this.createdDate,
    this.updatedDate,
    this.deletedDate,
    this.client,
    this.editor,
    this.questionnaire,
    this.questions,
  });

  // Serialization (toJson) method
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdDate': createdDate!.toIso8601String(),
      'updatedDate': updatedDate!.toIso8601String(),
      'deletedDate': deletedDate!.toIso8601String(),
      'client': client!.toJson(), // Assuming User has a toJson method.
      'editor': editor!.toJson(), // Assuming Editor has a toJson method.
      'questionnaire': questionnaire!
          .toJson(), // Assuming Questionnaire has a toJson method.
      'questions': questions!
          .map((question) => question.toJson())
          .toList(), // Assuming Question has a toJson method.
    };
  }

  // Deserialization (fromJson) factory method
  factory Exhibit.fromJson(Map<String, dynamic> json) {
    return Exhibit(
      id: json['id'],
      createdDate: json['createdDate'] != null
          ? DateTime.parse(json['createdDate'])
          : null,
      updatedDate: json['updatedDate'] != null
          ? DateTime.parse(json['updatedDate'])
          : null,
      deletedDate: json['updatedDate'] != null
          ? DateTime.parse(json['updatedDate'])
          : null,
      client: json['client'] != null
          ? Person.fromJson(json['client'])
          : null, // Assuming User has a fromJson factory method.
      editor: json['editor'] != null
          ? Editor.fromJson(json['editor'])
          : null, // Assuming Editor has a fromJson factory method.
      questionnaire: json['questionnaire'] != null
          ? Questionnaire.fromJson(json['questionnaire'])
          : null, // Assuming Questionnaire has a fromJson factory method.
      questions: json['questions'] != null
          ? (json['questions'] as List)
              .map((questionJson) => Question.fromJson(questionJson))
              .toList()
          : null, // Assuming Question has a fromJson factory method.
    );
  }
}

// You need to implement similar toJson and fromJson methods for User, Editor, Questionnaire, and Question classes.
