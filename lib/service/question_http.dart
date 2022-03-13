import 'dart:async';
import 'dart:convert';
import '../data/question.dart';
import '../data/http_data.dart';

class RealQuestionRepository implements QuestionRepository {
  @override
  Future<List<Question>> fetch(HttpRequest request) async {
    var response = await useRequest(request);
    final String jsonBody = response.body;
    final statusCode = response.statusCode;
    
    if (statusCode < 200 || statusCode >= 300) {
      throw FetchDataException( "Error while getting contacts [StatusCode:$statusCode, Error:${response.toString()}]");
    }
    
    final questionsContainer = jsonDecode(jsonBody);
    final List questions = questionsContainer;
    return questions.map((questionRow) => Question.fromMap(questionRow)).toList();
  }
}