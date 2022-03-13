import 'dart:async';
import 'http_data.dart';

class CartItem {
  final String item_id;
  final int quantity;
  final String product_id;
  final int price;

  CartItem.fromMap(Map<String, dynamic> map)
    : item_id = map['item_id'],
      quantity = map['quantity'],
      product_id = map['product_id'],
      price = map['price'];
}

abstract class CartItemRepository {
  Future<List<CartItem>> fetch(HttpRequest request);
}
