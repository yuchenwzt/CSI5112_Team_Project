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
        height: 50,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TextButton.icon(
              onPressed: () {
                setState(() {
                  isClicked = !isClicked;
                  widget.updateIsClickAll(isClicked);
                });
              },
              icon: Icon(
                Icons.check_circle_outline,
                color: isClicked
                    ? Colors.green
                    : const Color.fromRGBO(200, 200, 200, 1),
              ),
              label: const Text(
                "Select all",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            Text(
              'Total:  \$' + widget.amountPrice.toString() + '  ',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            Text(
              'Tax:  \$' +
                  (widget.amountPrice * 0.13).toString() +
                  '           ',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            SizedBox(
              width: 180,
              height: 35,
              child: Material(
                color: Colors.red,
                borderRadius: BorderRadius.circular(5),
                elevation: 6,
                child: MaterialButton(
                  child: const Text(
                    'Place the order',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return PaymentPage(user: widget.user);
                      }),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      left: 15,
      right: 15,
      bottom: 15,
    );
  }
}
