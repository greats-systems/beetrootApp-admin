class Conversation {
  String question;
  String answer;

  Conversation({required this.question, required this.answer});

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      question: json['question'],
      answer: json['answer'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'answer': answer,
    };
  }
}
