import 'package:flutter/material.dart';
import '../../data/order_data.dart';

class OrderFilterPanel extends StatelessWidget {
  const OrderFilterPanel({ Key? key, required this.orders }) : super(key: key);

  final List<Order> orders;
  
  @override
  @override
  Widget build(BuildContext context) {
    return GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisSpacing: 2,
          childAspectRatio: 5 / 1,
        ),
        shrinkWrap: true,
        children: buildOrderList(),
      );
  }

  List<ListTile> buildOrderList() {
    return orders.map((ordersState) => ListTile(
      leading: const Icon(Icons.person),
      title: Text("Client" + ordersState.itemId + " purchased " + ordersState.orderId + " on " + ordersState.purchaseDate,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      subtitle: Text("Order Status: " + ordersState.purchaseStatus,
        style: const TextStyle(fontSize: 14, color: Colors.black)
      )
    )).toList();
  }
}