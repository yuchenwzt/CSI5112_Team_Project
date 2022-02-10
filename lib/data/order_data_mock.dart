import 'dart:async';
import 'order_data.dart';

class MockOrderRepository implements OrderRepository {
  @override
  Future<List<Order>> fetch() => Future.value(allOrders);
}

var allOrders = <Order>[
  Order(
    orderId: "1234",
    userId: "1",
    purchaseDate: "2022.01.01",
    purchaseInfo: "",
    purchaseStatus: "Delivering",
  ),
  Order(
    orderId: "2234",
    userId: "1",
    purchaseDate: "2022.01.02",
    purchaseInfo: "",
    purchaseStatus: "Delivering",
  ),
  Order(
    orderId: "3234",
    userId: "1",
    purchaseDate: "2022.01.03",
    purchaseInfo: "",  
    purchaseStatus: "Ordered",
  ),
  Order(
    orderId: "4234",
    userId: "2",
    purchaseDate: "2022.02.01",
    purchaseInfo: "",
    purchaseStatus: "Ordered",
  ),
  Order(
    orderId: "5234",
    userId: "3",
    purchaseDate: "2022.03.01",
    purchaseInfo: "",
    purchaseStatus: "Finished",
  ),
  Order(
    orderId: "6234",
    userId: "3",
    purchaseDate: "2022.04.01",
    purchaseInfo: "",
    purchaseStatus: "Finished",
  ),
];