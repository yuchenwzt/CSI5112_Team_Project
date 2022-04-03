import 'dart:async';
import 'http_data.dart';
import 'shipping_address_data.dart';

class OrderDetail {
  late Order salesOrder;
  late ShippingAddress customerAddress;
  late ShippingAddress merchantAddress;

  OrderDetail({
    ShippingAddress? customerAddress,
    ShippingAddress? merchantAddress,
    Order? salesOrder
  }) : customerAddress = customerAddress ?? ShippingAddress(), merchantAddress = merchantAddress ?? ShippingAddress(), salesOrder = salesOrder ?? Order();

  OrderDetail.fromMap(Map<String, dynamic> map) :
    salesOrder = Order.fromMap(map['salesOrder']),
    customerAddress = ShippingAddress.fromMap(map['customerAddress']),
    merchantAddress = ShippingAddress.fromMap(map['MerchantAddress']);
}

class Order {
  final String order_id;
  String customer_id;
  String merchant_id;
  String product_id;
  int quantity;
  String customer_shipping_address_id;
  String merchant_shipping_address_id;
  DateTime date;
  String status;
  String image;
  String product_name;
  int price;

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
    this.product_name = "",
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
      product_name = map['name'],
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
      'name': product_name,
      'price': price,
      'status': status,
    };
  }
}

abstract class OrderRepository {
  Future<List<OrderDetail>> fetch(HttpRequest request);
}