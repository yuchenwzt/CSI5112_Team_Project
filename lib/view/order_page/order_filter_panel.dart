import 'package:flutter/material.dart';
import '../../data/order_data.dart';
import '../../data/user_data.dart';

class OrderFilterPanel extends StatelessWidget {
  const OrderFilterPanel({ Key? key, required this.orders, required this.user, this.updateOrderStatus }) : super(key: key);

  final List<OrderDetail> orders;
  final User user;
  final updateOrderStatus;

  @override
  @override
  Widget build(BuildContext context) {
    return ListView(
        children: buildOrderList(),
      );
  }

  List<ListTile> buildOrderList() {
    return orders.map((ordersState) => ListTile(
      leading: user.isMerchant ? const Icon(Icons.shop) : const Icon(Icons.people),
      title: user.isMerchant ? Text("Client " + ordersState.salesOrder.customer_id.substring(0,6) + "... purchased " + ordersState.salesOrder.product_id.substring(0,6) + "... on " + ordersState.salesOrder.date.toString(),
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)) 
        : 
        Text("Product " + ordersState.salesOrder.product_name + " on " + ordersState.salesOrder.date.toString(),
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      subtitle: Text("Merchant ID: " + ordersState.salesOrder.merchant_id + " Order Status: " + ordersState.salesOrder.status,
        style: const TextStyle(fontSize: 14, color: Colors.black)
      ),
      trailing: TextButton(
        child: user.isMerchant ? const Text('Ship Product') : const Text('Receipt Confirm'),
        onPressed: () {
          updateOrderStatus();
        },
      ),
    )).toList();
  }
}