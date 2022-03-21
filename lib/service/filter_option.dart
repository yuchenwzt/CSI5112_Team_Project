import 'dart:async';
import 'dart:convert';
import '../data/filter_option_data.dart';
import '../data/http_data.dart';

class RealFilterOptionRepository implements FilterOptionRepository {
  @override
  Future<FilterOption> fetch(HttpRequest request) async {
    var response = await useRequest(request);
    final String jsonBody = response.body;
    final statusCode = response.statusCode;
    
    if (statusCode < 200 || statusCode >= 300) {
      throw FetchDataException( "Error while getting contacts [StatusCode:$statusCode, Error:${response.toString()}]");
    }

    final filterOptionContainer = jsonDecode(jsonBody);
    return FilterOption.fromMap(filterOptionContainer);
  }
}