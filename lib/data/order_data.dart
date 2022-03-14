import 'dart:async';
import 'http_data.dart';

class Order {
  final String order_id;
  String merchant_id;
  String customer_id;
  String shipping_address_id;
  int quantity;
  String product_id;
  DateTime date;
  String status;

  Order( {
    this.order_id = "",
    this.merchant_id = "",
    this.customer_id = "",
    this.shipping_address_id = "",
    this.quantity = 0,
    this.product_id = "",
    this.status = "",
    DateTime? date
  }) : date = date ?? DateTime.now();

  Order.fromMap(Map<String, dynamic> map)
    : order_id = map['order_id'],
    merchant_id = map['merchant_id'],
    customer_id = map['customer_id'],
    shipping_address_id = map['shipping_address_id'],
    quantity = map['quantity'],
    product_id = map['product_id'],
    date = DateTime.parse(map['date']),
    status = map['status'];
}

abstract class OrderRepository {
  Future<List<Order>> fetch(HttpRequest request);
}