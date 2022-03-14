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
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 140),
            child: Icon(Icons.done_outline, size: 120, color: Colors.green),
          ),
          const Padding(padding: EdgeInsets.only(top: 100)),
          const Center(
            child: Text('Order has been placed successfully!',
              style:
                TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
          const Padding(padding: EdgeInsets.only(top: 80)),
          SizedBox(
            width: 30,
            height: 30,
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Material(
                color: Colors.red,
                borderRadius: BorderRadius.circular(5),
                elevation: 6,
                child: MaterialButton(
                  child: const Text(
                    'Back to Main Page',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => ProductPage(user: user)),
                      (route) => route == null);
                  },
                ),
              ),
            )
          ),
          const Padding(padding: EdgeInsets.only(top: 20)),
          SizedBox(
            width: 30,
            height: 30,
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Material(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(5),
                elevation: 6,
                child: MaterialButton(
                  child: const Text(
                    'View Orders',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => OrderPage(user: user)),
                      (route) => route == null);
                  },
                ),
              ),
            )
          )
        ],
      )
    );
  }
  // SizedBox(height: getProportionateScreenWidth(20)),
}
