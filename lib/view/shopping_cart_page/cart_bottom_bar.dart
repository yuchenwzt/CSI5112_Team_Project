import 'package:csi5112_project/view/product_detail_page/payment_success_page.dart';
import 'package:flutter/material.dart';
import '../../data/user_data.dart';

class CartBottomBar extends StatefulWidget {
  const CartBottomBar(
      {Key? key,
      required this.amountPrice,
      required this.isClickedAll,
      required this.user,
      this.updateIsClickAll})
      : super(key: key);

  final User user;
  final int amountPrice;
  final bool isClickedAll;
  final updateIsClickAll;
  @override
  _CartBottomBarState createState() => _CartBottomBarState();
}

class _CartBottomBarState extends State<CartBottomBar> {
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            TextButton.icon(
              onPressed: () {
                setState(() {
                  isClicked = !isClicked;
                  widget.updateIsClickAll(isClicked);
                });
              },
              icon: Icon(
                Icons.add_circle_outline,
                color: isClicked
                    ? Colors.green
                    : const Color.fromRGBO(200, 200, 200, 1),
              ),
              label: const Text("Select all"),
            ),
            Text('Total:  \$' + widget.amountPrice.toString() + '  '),
            Text('Tax:  \$' +
                (widget.amountPrice * 0.13).toString() +
                '           '),
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return PaymentPage(user: widget.user);
                  }),
                );
              },
              child: const Text('Place the order'),
            )
          ],
        ),
      ),
      left: 10,
      bottom: 7,
    );
  }
}