import 'dart:async';
import 'dart:convert';
import '../data/cart_item_data.dart';
import '../data/http_data.dart';

class RealCartItemRepository implements CartItemRepository {
  @override
  Future<List<CartItem>> fetch(HttpRequest request) async {
    var response = await useRequest(request);
    final String jsonBody = response.body;
    final statusCode = response.statusCode;
    
    if (statusCode < 200 || statusCode >= 300) {
      throw FetchDataException( "Error while getting contacts [StatusCode:$statusCode, Error:${response.toString()}]");
    }

    final cartItemsContainer = jsonDecode(jsonBody);
    final List cartItems = cartItemsContainer;
    return cartItems.map((cartItemRow) => CartItem.fromMap(cartItemRow)).toList();
  }
}