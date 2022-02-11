import 'package:flutter/material.dart';
import '../item_page/item_page.dart';
import '../order_page/order_page.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({
    Key? key,
  }) : super(key: key);

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
                        builder: (context) => const ItemPage(isMerchant: true)),
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
                        builder: (context) => const OrderPage(isMerchant: true,)),
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
