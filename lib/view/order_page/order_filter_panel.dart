import 'package:flutter/material.dart';
import 'package:accordion/accordion.dart';
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
    return buildOrderList(context);
  }

  Color? statusColor(String status) {
    Color? statusColor = Colors.black;
    switch (status) {
      case 'processing':
        statusColor = Colors.red;
        break;
      case 'delivering':
        statusColor = Colors.blue;
        break;
      case 'finish':
        statusColor = Colors.green;
        break;
    }
    return statusColor;
  }

  Icon statusIcon(String status) {
    Icon statusIcon = const Icon(Icons.audiotrack, color: Colors.white);
    switch (status) {
      case 'processing':
        statusIcon = const Icon(Icons.access_time, color: Colors.white);
        break;
      case 'delivering':
        statusIcon = const Icon(Icons.delivery_dining, color: Colors.white);
        break;
      case 'finish':
        statusIcon = const Icon(Icons.domain_verification_rounded, color: Colors.white);
        break;
    }
    return statusIcon;
  }

  Accordion buildOrderList(BuildContext context) {
    return Accordion(
      maxOpenSections: 1,
      children: orders.map((ordersState) => 
        AccordionSection(
          isOpen: true,
          leftIcon: statusIcon(ordersState.salesOrder.status),
          contentBorderColor: statusColor(ordersState.salesOrder.status),
          headerBackgroundColor: statusColor(ordersState.salesOrder.status),
          header: user.isMerchant ? Text("Client " + ordersState.salesOrder.customer_id.substring(0,6) + "... purchased " + ordersState.salesOrder.product_id.substring(0,6) + "... on " + DateFormat('yyyy-MM-dd').format(ordersState.salesOrder.date),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)) 
            : 
            Text("Product " + ordersState.salesOrder.name + " on " + DateFormat('yyyy-MM-dd').format(ordersState.salesOrder.date),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
          content: OrderDetailPage(user: user, updateOrderStatus: updateOrderStatus, order: ordersState),
        )
      ).toList(),
    );
  }
}