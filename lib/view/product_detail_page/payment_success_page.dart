import 'package:flutter/material.dart';
import '../product_page/product_page.dart';
import '../order_page/order_page.dart';
import 'package:csi5112_project/data/user_data.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({
    required this.user,
    Key? key,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: ListView(
          children: const [
            Padding(
              padding: EdgeInsets.only(top: 140),
              child: Icon(Icons.done_outline, size: 120, color: Colors.green),
            ),
            Padding(padding: EdgeInsets.only(top: 100)),
            Center(
                child: Text('Order has been placed successfully!',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
            Padding(padding: EdgeInsets.only(top: 20)),
            Center(
                child: Text('Go to User Home to view receipts',
                    style: TextStyle(fontSize: 20, color: Colors.grey)))
          ],
        ));
  }
  // SizedBox(height: getProportionateScreenWidth(20)),
}
