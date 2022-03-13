import 'dart:async';
import 'dart:convert';
import '../data/product_data.dart';
import '../data/http_data.dart';

class RealProductRepository implements ProductRepository {
  @override
  Future<List<Product>> fetch(HttpRequest request) async {
    var response = await useRequest(request);
    final String jsonBody = response.body;
    final statusCode = response.statusCode;
    
    if (statusCode < 200 || statusCode >= 300) {
      throw FetchDataException( "Error while getting contacts [StatusCode:$statusCode, Error:${response.toString()}]");
    }
    
    final productsContainer = jsonDecode(jsonBody);
    final List products = productsContainer;
    return products.map((productRow) => Product.fromMap(productRow)).toList();
  }
}