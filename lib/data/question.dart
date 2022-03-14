import 'dart:async';
import 'http_data.dart';

class Question {
  final String question_id;
  final String customer_id;
  final String question;
  final DateTime date;
  final String product_id;
  
  Question( {
    this.question_id = "",
    this.customer_id = "",
    this.question = "",
    this.product_id = "",
    DateTime? date
  }) : date = date ?? DateTime.now();

  Question.fromMap(Map<String, dynamic> map)
    : question_id = map['question_id'],
      customer_id = map['customer_id'],
      question = map['question'],
      date = DateTime.parse(map['date']),
      product_id = map['product_id'];
}

abstract class QuestionRepository {
  Future<List<Question>> fetch(HttpRequest request);
}
