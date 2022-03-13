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
  String image;

  Product( {
    this.product_id = "",
    this.category = "",
    this.description = "",
    this.image = "",
    this.manufacturer = "",
    this.name = "",
    this.owner = "",
    this.price = 0
  });

  Product.fromMap(Map<String, dynamic> map)
    : product_id = map['product_id'],
    owner = map['owner'],
    name = map['name'],
    price = map['price'],
    image = map['image'],
    description = map['description'],
    category = map['category'],
    manufacturer = map['manufacturer'];
}

abstract class ProductRepository{
  Future<List<Product>> fetch(HttpRequest request);
}