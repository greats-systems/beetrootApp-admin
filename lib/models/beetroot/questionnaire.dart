import 'package:core_erp/models/person.dart';

class Questionnaire {
  String? id;
  bool? isExhibit;
  DateTime? createdDate;
  DateTime? updatedDate;
  DateTime? submittedDate;
  DateTime? deletedDate;
  String? category;
  String? searchTerms;
  String? title;
  String? body;
  Person? responder;
  Person? editor;
  List<Question>? questions;

  Questionnaire({
    this.id,
    this.isExhibit,
    this.createdDate,
    this.updatedDate,
    this.submittedDate,
    this.deletedDate,
    this.responder,
    this.editor,
    this.category,
    this.searchTerms,
    this.title,
    this.body,
    this.questions,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdDate': createdDate!.toIso8601String(),
      'updatedDate': updatedDate!.toIso8601String(),
      'submittedDate':
          submittedDate != null ? submittedDate!.toIso8601String() : null,
      'deletedDate': deletedDate?.toIso8601String(),
      'category': category,
      'searchTerms': searchTerms,
      'title': title,
      'body': body,
      'responder': responder,
      'questions': questions!.map((question) => question.toJson()).toList(),
    };
  }

  factory Questionnaire.fromJson(Map<String, dynamic> json) {
    return Questionnaire(
      id: json['id'],
      createdDate: DateTime.parse(json['createdDate']),
      updatedDate: DateTime.parse(json['updatedDate']),
      submittedDate: json['submittedDate'] != null
          ? DateTime.parse(json['submittedDate'])
          : null,
      deletedDate: json['deletedDate'] != null
          ? DateTime.parse(json['deletedDate'])
          : null,
      category: json['category'],
      searchTerms: json['searchTerms'],
      title: json['title'],
      body: json['body'],
      responder: json['responder'],
      questions: List<Question>.from(
          json['questions'].map((question) => Question.fromJson(question))),
    );
  }
  void removeQuestionsWithNullAnswers() {
    questions?.removeWhere((question) => question.answer == null);
  }
}

class Question {
  String? id;
  String? questionnaireID;
  DateTime? createdDate;
  DateTime? updatedDate;
  DateTime? deletedDate;
  String? category;
  String? searchTerms;
  String? question;
  String? answer;
  Person? responder;
  String? meta;

  Question({
    this.id,
    this.questionnaireID,
    this.createdDate,
    this.updatedDate,
    this.deletedDate,
    this.category,
    this.searchTerms,
    this.question,
    this.answer,
    this.responder,
    this.meta,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'questionnaireID': questionnaireID,
      'createdDate': createdDate!.toIso8601String(),
      'updatedDate': updatedDate!.toIso8601String(),
      'deletedDate': deletedDate?.toIso8601String(),
      'category': category,
      'searchTerms': searchTerms,
      'question': question,
      'answer': answer,
      'responder': responder,
      'meta': meta,
    };
  }

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      questionnaireID: json['questionnaireID'],
      createdDate: DateTime.parse(json['createdDate']),
      updatedDate: DateTime.parse(json['updatedDate']),
      deletedDate: json['deletedDate'] != null
          ? DateTime.parse(json['deletedDate'])
          : null,
      category: json['category'],
      searchTerms: json['searchTerms'],
      question: json['question'],
      answer: json['answer'],
      responder: json['responder'],
      meta: json['meta'],
    );
  }
}
