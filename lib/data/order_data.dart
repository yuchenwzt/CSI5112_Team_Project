import 'dart:async';

class Order {
  final String itemId;
  String orderId;
  String userId;
  String purchaseDate;
  String purchaseInfo;
  String purchaseStatus;

  Order(
    {
      this.itemId = "",
      this.orderId = "",
      this.userId = "",
      this.purchaseDate = "",
      this.purchaseInfo = "",
      this.purchaseStatus = "",
    }
  );

  Order.fromMap(Map<String, dynamic> map)
    : itemId = map['itemId'],
    orderId = map['orderId'],
    userId = map['userId'],
    purchaseDate = map['purchaseDate'],
    purchaseInfo = map['purchaseInfo'],
    purchaseStatus = map['purchaseStatus'];
}

abstract class OrderRepository {
  Future<List<Order>> fetch();
}

class FetchDataException implements Exception {
  String message;

  FetchDataException(this.message);

  @override
  String toString() {
    return "Exception:$message";
  }
}