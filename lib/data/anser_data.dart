import 'dart:async';
import 'http_data.dart';

class Answer {
  final String answer_id;
  final String role;
  final String role_id;
  final DateTime date;
  final String answer;
  final String question_id;

  Answer( {
    this.answer_id = "",
    this.role = "",
    this.role_id = "",
    this.answer = "",
    this.question_id = "",
    DateTime? date
  }) : date = date ?? DateTime.now();

  Answer.fromMap(Map<String, dynamic> map)
    : answer_id = map['answer_id'],
      role = map['role'],
      role_id = map['role_id'],
      date = DateTime.parse(map['date']),
      answer = map['answer'],
      question_id = map['question_id'];
}

abstract class AnswerRepository {
  Future<List<Answer>> fetch(HttpRequest request);
}
