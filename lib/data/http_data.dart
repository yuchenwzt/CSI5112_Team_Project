import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const String http_header =
    "http://csiteamwork-1443910782.us-east-1.elb.amazonaws.com/api/";
// const String http_header = "https://localhost:7027/api/";

class HttpRequest {
  final String httpHeader = http_header;
  String type;
  String url;
  Object object;

  HttpRequest(this.type, this.url, this.object);
}

final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

Future<String> _getLoginToken() async {
  final SharedPreferences prefs = await _prefs;
  return prefs.getString('current_token') ?? '0';
}

Future<http.Response> useRequest(HttpRequest request) async {
  String url = request.httpHeader + request.url;
  String token = await _getLoginToken();
  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ' + token
  };
  switch (request.type) {
    case 'Get':
      return await http.get(Uri.parse(url), headers: requestHeaders);
    case 'Post':
      // print(request.url);
      print(request.object);
      return await http.post(Uri.parse(url),
          headers: requestHeaders, body: request.object);
    case 'Put':
      return await http.put(Uri.parse(url),
          headers: requestHeaders, body: request.object);
    case 'Delete':
      return await http.delete(Uri.parse(url),
          headers: requestHeaders, body: request.object);
    default:
      {
        return await http.post(Uri.parse(url),
            headers: requestHeaders, body: request.object);
      }
  }
}

class FetchDataException implements Exception {
  String message;

  FetchDataException(this.message);

  @override
  String toString() {
    return "Exception:$message";
  }
}
