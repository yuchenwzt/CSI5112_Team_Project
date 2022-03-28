import 'package:flutter/material.dart';
import '../shopping_cart_page/cart_item_page.dart';
import 'payment_success_page.dart';
import 'product_description.dart';
import 'product_img.dart';
import '../../data/product_data.dart';
import 'package:csi5112_project/data/user_data.dart';
// import '../item_chat_page/item_chat_page.dart';
import 'package:csi5112_project/main.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({
    Key? key,
    required this.product,
    required this.user,
    this.onEditFinish,
  }) : super(key: key);

  final User user;
  final Product product;
  final onEditFinish;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.category + " Store")),
      body: ListView(children: [
        const Padding(padding: EdgeInsets.only(top: 10)),
        ProductImg(product: product),
        ProductDescription(product: product),
        const Padding(padding: EdgeInsets.only(top: 30)),
        SizedBox(
            //width: 30,
            height: 40,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Material(
                color: Colors.red,
                borderRadius: BorderRadius.circular(5),
                elevation: 6,
                child: MaterialButton(
                  child: const Text(
                    'place the order',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return PaymentPage(user: user);
                      }),
                    );
                  },
                ),
              ),
            )),
        const Padding(padding: EdgeInsets.only(top: 20)),
        SizedBox(
            //width: 30,
            height: 40,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Material(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(5),
                elevation: 6,
                child: MaterialButton(
                  child: const Text(
                    'Add to Cart',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return CartPage(user: user);
                      }),
                    );
                  },
                ),
              ),
            )),
        const Padding(padding: EdgeInsets.only(top: 30)),
        // ItemChatPage(item: product, onEditFinish: onEditFinish)
      ]),
    );
  }
}
