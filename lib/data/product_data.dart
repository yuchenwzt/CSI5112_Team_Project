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
  String image_type;
  DateTime date;

  Product( {
    this.product_id = "",
    this.category = "",
    this.description = "",
    this.manufacturer = "",
    this.name = "",
    this.owner = "",
    this.owner_id = "",
    this.price = 0,
    this.image = "",
    this.image_type = "",
    DateTime? date
  }) : date = date ?? DateTime.now();

  Product.fromMap(Map<String, dynamic> map)
    : product_id = map['product_id'],
    owner = map['owner'],
    owner_id = map['owner_id'],
    name = map['name'],
    price = map['price'],
    image = map['image'],
    image_type = map['image_type'],
    description = map['description'],
    category = map['category'],
    date = DateTime.parse(map['date']),
    manufacturer = map['manufacturer'];

  Map<String, dynamic> toJson() {
    return {
      'product_id': product_id,
      'owner': owner,
      'owner_id': owner_id,
      'name': name,
      'price': price.toString(),
      'image': image,
      'image_type': image_type,
      'description': description,
      'category': category,
      'date': date.toIso8601String(),
      'manufacturer': manufacturer,
    };
  }
}

abstract class ProductRepository{
  Future<List<Product>> fetch(HttpRequest request);
}