import 'package:flutter/material.dart';
import '../../data/order_data.dart';
import '../../data/user_data.dart';
import './order_detail.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderFilterPanel extends StatelessWidget {
  const OrderFilterPanel({ Key? key, required this.orders, required this.user, this.updateOrderStatus }) : super(key: key);

  final List<OrderDetail> orders;
  final User user;
  final updateOrderStatus;

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: buildOrderList(context),
      );
  }

  List<ListTile> buildOrderList(BuildContext context) {
    return orders.map((ordersState) => ListTile(
      leading: user.isMerchant ? const Icon(Icons.shop) : const Icon(Icons.people),
      title: user.isMerchant ? Text("Client " + ordersState.salesOrder.customer_id.substring(0,6) + "... purchased " + ordersState.salesOrder.product_id.substring(0,6) + "... on " + DateFormat('yyyy-MM-dd').format(ordersState.salesOrder.date),
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)) 
        : 
        Text("Product " + ordersState.salesOrder.name + " on " + DateFormat('yyyy-MM-dd').format(ordersState.salesOrder.date),
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      subtitle: Text("Merchant ID: " + ordersState.salesOrder.merchant_id + " Order Status: " + ordersState.salesOrder.status,
        style: const TextStyle(fontSize: 14, color: Colors.black)
      ),
      trailing: 
        TextButton(child: const Text('Manage Order >'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return OrderDetailPage(user: user, updateOrderStatus: updateOrderStatus, order: ordersState);
              }),
            );
          }
      )
    )).toList();
  }
}