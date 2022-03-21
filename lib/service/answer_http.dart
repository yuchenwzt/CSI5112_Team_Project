import 'dart:async';
import 'dart:convert';
import '../data/anser_data.dart';
import '../data/http_data.dart';

class RealAnswerRepository implements AnswerRepository {
  @override
  Future<List<Answer>> fetch(HttpRequest request) async {
    var response = await useRequest(request);
    final String jsonBody = response.body;
    final statusCode = response.statusCode;
    
    if (statusCode < 200 || statusCode >= 300) {
      throw FetchDataException( "Error while getting contacts [StatusCode:$statusCode, Error:${response.toString()}]");
    }
    
    final answersContainer = jsonDecode(jsonBody);
    final List answers = answersContainer;
    return answers.map((answerRow) => Answer.fromMap(answerRow)).toList();
  }
}