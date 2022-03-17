import 'dart:async';
import 'http_data.dart';

class CartItem {
  final String item_id;
  final int quantity;
  final String product_id;
  final int price;
  final String customer_id;

  CartItem( {
    this.item_id = "",
    this.quantity = 0,
    this.product_id = "",
    this.customer_id = "",
    this.price = 0,
  });

  CartItem.fromMap(Map<String, dynamic> map)
    : item_id = map['item_id'],
      quantity = map['quantity'],
      product_id = map['product_id'],
      price = map['price'],
      customer_id = map['customer_id'];

  Map<String, dynamic> toJson() {
    return {
      'item_id': item_id,
      'quantity': quantity.toString(),
      'product_id': product_id,
      'price': price.toString()
    };
  }
}

abstract class CartItemRepository {
  Future<List<CartItem>> fetch(HttpRequest request);
}
