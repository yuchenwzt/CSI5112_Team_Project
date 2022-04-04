import 'dart:async';
import 'http_data.dart';
import 'shipping_address_data.dart';

class OrderDetail {
  Order salesOrder;
  ShippingAddress customerAddress;
  ShippingAddress merchantAddress;

  OrderDetail.fromMap(Map<String, dynamic> map) :
    salesOrder = Order.fromMap(map['salesOrder']),
    customerAddress = ShippingAddress.fromMap(map['customerAddress']),
    merchantAddress = ShippingAddress.fromMap(map['merchantAddress']);
}

class Order {
  final String order_id;
  String customer_id;
  String merchant_id;
  String customer_shipping_address_id;
  String merchant_shipping_address_id;
  int quantity;
  String product_id;
  String status;
  String name;
  String image;
  int price;
  DateTime date;

  Order( {
    this.order_id = "",
    this.customer_id = "",
    this.merchant_id = "",
    this.product_id = "",
    this.quantity = 0,
    this.customer_shipping_address_id = "",
    this.merchant_shipping_address_id = "",
    this.status = "",
    this.image = "",
    this.name = "",
    this.price = 0,
    DateTime? date
  }) : date = date ?? DateTime.now();

  Order.fromMap(Map<String, dynamic> map)
    : order_id = map['order_id'],
      merchant_id = map['merchant_id'],
      customer_id = map['customer_id'],
      customer_shipping_address_id = map['customer_shipping_address_id'],
      merchant_shipping_address_id = map['merchant_shipping_address_id'],
      quantity = map['quantity'],
      product_id = map['product_id'],
      date = DateTime.parse(map['date']),
      image = map['image'],
      name = map['name'],
      price = map['price'],
      status = map['status'];

  Map<String, dynamic> toJson() {
    return {
      'order_id': order_id,
      'merchant_id': merchant_id,
      'customer_id': customer_id,
      'customer_shipping_address_id': customer_shipping_address_id,
      'merchant_shipping_address_id': merchant_shipping_address_id,
      'quantity': quantity.toString(),
      'product_id': product_id,
      'date': date.toIso8601String(),
      'image': image,
      'name': name,
      'price': price,
      'status': status,
    };
  }
}

abstract class OrderRepository {
  Future<List<OrderDetail>> fetch(HttpRequest request);
}