import 'dart:async';
import 'http_data.dart';

class CartProduct {
  final String item_id;
  int quantity;
  String product_id;
  int price;
  String customer_id;
  String category;
  String description;
  String manufacturer;
  String name;
  String owner;
  String owner_id;
  String image;
  String image_type;
  DateTime date;

  CartProduct(
      {this.item_id = "",
      this.quantity = 0,
      this.product_id = "",
      this.customer_id = "",
      this.price = 0,
      this.category = "erttret",
      this.description = "ghjgj",
      this.manufacturer = "",
      this.name = "asdasf",
      this.owner = "",
      this.owner_id = "",
      this.image = "",
      this.image_type = "",
      DateTime? date})
      : date = date ?? DateTime.now();

  CartProduct.fromMap(Map<String, dynamic> map)
      : item_id = map['item_id'],
        quantity = map['quantity'],
        product_id = map['product_id'],
        price = map['price'],
        customer_id = map['customer_id'],
        owner = map['owner'],
        owner_id = map['owner_id'],
        name = map['name'],
        image = map['image'],
        image_type = map['image_type'],
        description = map['description'],
        category = map['category'],
        date = DateTime.parse(map['date']),
        manufacturer = map['manufacturer'];

  Map<String, dynamic> toJson() {
    return {
      'item_id': item_id,
      'quantity': quantity.toString(),
      'product_id': product_id,
      'price': price.toString(),
      'customer_id': customer_id,
      'owner': owner,
      'owner_id': owner_id,
      'name': name,
      'image': image,
      'image_type': image_type,
      'description': description,
      'category': category,
      'date': date.toString(),
      'manufacturer': manufacturer
    };
  }
}

abstract class CartProductRepository {
  Future<List<CartProduct>> fetch(HttpRequest request);
}
