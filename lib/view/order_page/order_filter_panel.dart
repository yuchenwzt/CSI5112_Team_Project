import 'package:flutter/material.dart';
import '../../data/order_data.dart';
import '../../data/user_data.dart';
import './order_detail.dart';

class OrderFilterPanel extends StatelessWidget {
  const OrderFilterPanel(
      {Key? key,
      required this.orders,
      required this.user,
      this.updateOrderStatus})
      : super(key: key);

  final List<OrderDetail> orders;
  final User user;
  final updateOrderStatus;

  @override
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: buildOrderList(context),
    );
  }

  List<ListTile> buildOrderList(BuildContext context) {
    return orders
        .map((ordersState) => ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
              isThreeLine: true,
              leading: user.isMerchant
                  ? const Icon(Icons.shop)
                  : const Icon(Icons.people),
              title: user.isMerchant
                  ? Text(
                      "Customer: " +
                          ordersState.salesOrder.customer_id.substring(0, 6) +
                          "...;   " +
                          "Item: " +
                          ordersState.salesOrder.product_id.substring(0, 6) +
                          "...;    " +
                          "Date: " +
                          ordersState.salesOrder.date.toString(),
                      style: const TextStyle(fontSize: 18))
                  : Text(
                      "Product " +
                          ordersState.salesOrder.name +
                          " on " +
                          ordersState.salesOrder.date.toString(),
                      style: const TextStyle(fontSize: 18)),
              subtitle: Text(
                  "Merchant ID: " +
                      ordersState.salesOrder.merchant_id +
                      ";    " +
                      " Order Status: " +
                      ordersState.salesOrder.status,
                  style: TextStyle(
                      fontSize: 14,
                      color: ordersState.salesOrder.status == 'Processing'
                          ? Colors.red
                          : Colors.green)),
              trailing: TextButton(
                  child: const Text('Manage Order >'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return OrderDetailPage(
                            user: user,
                            updateOrderStatus: updateOrderStatus,
                            order: ordersState);
                      }),
                    );
                  }),
            ))
        .toList();
  }
}
