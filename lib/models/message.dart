class Message {
  String query;
  String answer;
  bool isQuestion;
  DateTime timestamp;

  Message({
    required this.query,
    required this.answer,
    required this.isQuestion,
    required this.timestamp,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      query: json['query'],
      answer: json['answer'],
      isQuestion: json['isQuestion'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'query': query,
      'answer': answer,
      'isQuestion': isQuestion,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
