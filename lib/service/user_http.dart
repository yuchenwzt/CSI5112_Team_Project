import 'dart:async';
import 'dart:convert';
import '../data/user_data.dart';
import '../data/http_data.dart';

class RealUserRepository implements UserRepository {
  @override
  Future<List<User>> fetch(HttpRequest request) async {
    var response = await useRequest(request);
    final String jsonBody = response.body;
    final statusCode = response.statusCode;
    
    if (statusCode < 200 || statusCode >= 300) {
      throw FetchDataException( "Error while getting contacts [StatusCode:$statusCode, Error:${response.toString()}]");
    }
    
    final usersContainer = jsonDecode(jsonBody);
    List<User> user = List<User>.filled(1, User());
    user[0] = User.fromMap(usersContainer);
    return user;
  }

  @override
  Future<bool> check(HttpRequest request) async {
    var response = await useRequest(request);
    final String jsonBody = response.body;
    final statusCode = response.statusCode;
    
    if (statusCode < 200 || statusCode >= 300) {
      throw FetchDataException( "Error while getting contacts [StatusCode:$statusCode, Error:${response.toString()}]");
    }
    
    final usersContainer = jsonDecode(jsonBody);
    return usersContainer;
  }
}