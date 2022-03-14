import 'dart:async';
import 'http_data.dart';

class Product {
  final String product_id;
  String category;
  String description;
  String manufacturer;
  String name;
  int price;
  String owner;
  String owner_id;
  String image;
  DateTime date;

  Product( {
    this.product_id = "",
    this.category = "",
    this.description = "",
    this.image = "",
    this.manufacturer = "",
    this.name = "",
    this.owner = "",
    this.owner_id = "",
    this.price = 0,
    DateTime? date
  }) : date = date ?? DateTime.now();

  Product.fromMap(Map<String, dynamic> map)
    : product_id = map['product_id'],
    owner = map['owner'],
    owner_id = map['owner_id'],
    name = map['name'],
    price = map['price'],
    image = map['image'],
    description = map['description'],
    category = map['category'],
    date = DateTime.parse(map['date']),
    manufacturer = map['manufacturer'];
}

abstract class ProductRepository{
  Future<List<Product>> fetch(HttpRequest request);
}