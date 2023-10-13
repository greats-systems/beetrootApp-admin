
import 'package:core_erp/models/beetroot/conversation_model.dart';

class Exhibit {
  String? image;
  String? entreprenuerImage;
  String? interviewerImage;
  String? mainImage;
  String? onConversationImage;
  String? onClodeImage;
  String? title;
  String? description;
  String? publishedby;
  String? entreprenuer;
  String? category;
  List<String>? searchKeyWords;
  String? mainQuote;
  String? date;
  String? views;
  String? comments;
  String? type;
  List<Conversation> conversation;

  Exhibit({
    required this.image,
    required this.entreprenuerImage,
    required this.interviewerImage,
    required this.mainImage,
    required this.onConversationImage,
    required this.onClodeImage,
    required this.title,
    required this.description,
    required this.publishedby,
    required this.entreprenuer,
    required this.category,
    required this.searchKeyWords,
    required this.mainQuote,
    required this.date,
    required this.views,
    required this.comments,
    required this.type,
    required this.conversation,
  });

  factory Exhibit.fromJson(Map<String, dynamic> json) {
    return Exhibit(
      image: json['image'],
      entreprenuerImage: json['entreprenuerImage'],
      interviewerImage: json['interviewerImage'],
      mainImage: json['mainImage'],
      onConversationImage: json['onConversationImage'],
      onClodeImage: json['onClodeImage'],
      title: json['title'],
      description: json['description'],
      publishedby: json['publishedby'],
      entreprenuer: json['entreprenuer'],
      category: json['category'],
      searchKeyWords: List<String>.from(json['searchKeyWords']),
      mainQuote: json['mainQuote'],
      date: json['date'],
      views: json['views'],
      comments: json['comments'],
      type: json['type'],
      conversation: List<Conversation>.from(json['conversation']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'entreprenuerImage': entreprenuerImage,
      'interviewerImage': interviewerImage,
      'mainImage': mainImage,
      'onConversationImage': onConversationImage,
      'onClodeImage': onClodeImage,
      'title': title,
      'description': description,
      'publishedby': publishedby,
      'entreprenuer': entreprenuer,
      'category': category,
      'searchKeyWords': searchKeyWords,
      'mainQuote': mainQuote,
      'date': date,
      'views': views,
      'comments': comments,
      'type': type,
      'conversation': conversation,
    };
  }
}
