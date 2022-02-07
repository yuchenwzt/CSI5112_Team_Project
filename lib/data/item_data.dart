import 'dart:async';

class Item {
  final String id;
  final String name;
  final String type;
  final String price;
  final String orderId;
  final String date;
  final String image;
  final String description;
  final List chat;

  const Item(
    {
      this.id = "",
      this.name = "",
      this.type = "",
      this.price = "",
      this.orderId = "",
      this.date = "",
      this.description = "",
      this.image = "",
      this.chat = const [],
    }
  );

  Item.fromMap(Map<String, dynamic> map)
    : id = map['id'],
      name = map['name'],
      type = map['type'],
      price = map['price'],
      orderId = map['orderId'],
      date = map['date'],
      image = map['image'],
      description = map['description'],
      chat = map['chat'];
}

abstract class ItemRepository {
  Future<List<Item>> fetch();
}

class FetchDataException implements Exception {
  String message;

  FetchDataException(this.message);

  @override
  String toString() {
    return "Exception:$message";
  }
}