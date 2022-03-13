import 'package:flutter/material.dart';
import '../../data/order_data.dart';

class OrderFilterPanel extends StatelessWidget {
  const OrderFilterPanel({ Key? key, required this.orders, required this.isMerchant }) : super(key: key);

  final List<Order> orders;
  final bool isMerchant;

  @override
  @override
  Widget build(BuildContext context) {
    return ListView(
        children: buildOrderList(),
      );
  }

  List<ListTile> buildOrderList() {
    return orders.map((ordersState) => ListTile(
      leading: const Icon(Icons.person),
      title: isMerchant ? Text("Client " + ordersState.customer_id + " purchased " + ordersState.product_id + " on " + ordersState.date.toString(),
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)) 
        : 
        Text("Current User purchased " + ordersState.product_id + " on " + ordersState.date.toString(),
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      subtitle: Text("Order ID: " + ordersState.order_id + " Order Status: " + ordersState.status,
        style: const TextStyle(fontSize: 14, color: Colors.black)
      )
    )).toList();
  }
}