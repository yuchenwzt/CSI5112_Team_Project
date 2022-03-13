import 'package:http/http.dart' as http;

const String http_header = "https://localhost:7027/api/";

class HttpRequest {
  final String httpHeader = http_header;
  String type;
  String url;
  Object object;

  HttpRequest(
    this.type,
    this.url,
    this.object
  );
}

Future<http.Response> useRequest(HttpRequest request) async {
  String url = request.httpHeader + request.url;
  switch(request.type) {
    case 'Get': 
      return await http.get(Uri.parse(url));
    case 'Post':
      return await http.post(Uri.parse(url), body: request.object);
    case 'Put':
      return await http.put(Uri.parse(url), body: request.object);
    case 'Delete':
      return await http.delete(Uri.parse(url), body: request.object);
    default: {
      return await http.post(Uri.parse(url), body: request.object);
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
