import 'dart:async';
import 'dart:convert' as convert;
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;
import 'item_data.dart';

class RealItemRepository implements ItemRepository {
  static const requestUrl = "https://localhost:7027/api/Products/all";
  

  @override
  Future<List<Item>> fetch() async {
    return await http.get(Uri.parse(requestUrl)).then((http.Response response) {
      final String jsonBody = response.body;
      final statusCode = response.statusCode;

      if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
        throw FetchDataException( "Error while getting contacts [StatusCode:$statusCode, Error:${response.toString()}]");
      }

      final itemsContainer = convert.jsonDecode(jsonBody);
      final List items = itemsContainer['result'];

      return items.map((itemRow) => Item.fromMap(itemRow)).toList();
    });
  }
}