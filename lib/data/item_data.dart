import 'dart:async';

class Chat {
  String name;
  String date;
  String comment;

  Chat(
    {
      this.name = "",
      this.date = "",
      this.comment = "",
    }
  );

}

class Item {
  final String id;
  final String product_id;
  String name;
  String type;
  String price;
  String orderId;
  String date;
  String image;
  String description;
  String location;
  String owner;
  List<Chat> chat;

  Item(
    {
      this.id = "",
      this.product_id = "",
      this.owner = "",
      this.name = "",
      this.type = "",
      this.price = "",
      this.orderId = "",
      this.date = "",
      this.description = "",
      this.image = "",
      this.location = "",
      this.chat = const [],
    }
  );

  Item.fromMap(Map<String, dynamic> map)
    : id = map['id'],
    product_id = map['product_id'],
    owner = map['owner'],
    name = map['name'],
    type = map['type'],
    price = map['price'],
    orderId = map['orderId'],
    date = map['date'],
    image = map['image'],
    location = map['location'],
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