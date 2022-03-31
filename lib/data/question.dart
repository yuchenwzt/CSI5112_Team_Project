import 'dart:async';
import 'http_data.dart';

class Question {
  final String question_id;
  String customer_id;
  String question;
  DateTime date;
  String product_id;
  
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

  Map<String, dynamic> toJson() {
    return {
      'question_id': question_id,
      'customer_id': customer_id,
      'question': question,
      'date': date.toIso8601String(),
      'product_id': product_id,
    };
  }
}

abstract class QuestionRepository {
  Future<List<Question>> fetch(HttpRequest request);
}
