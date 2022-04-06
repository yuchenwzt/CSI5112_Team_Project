import 'dart:convert';

import 'package:csi5112_project/data/cart_item_data.dart';
import 'package:csi5112_project/data/cart_product.dart';
import 'package:csi5112_project/data/http_data.dart';
import 'package:csi5112_project/data/user_data.dart';
import 'package:csi5112_project/presenter/cart_item_presenter.dart';
import 'package:flutter/material.dart';

class CardBox extends StatefulWidget {
  const CardBox(
      {Key? key,
      required this.user,
      required this.refresh,
      required this.cartProduct,
      required this.selectedValue,
      this.updateNum,
      required this.isClicked,
      this.updatePrice,
      required this.productPrice})
      : super(key: key);

  final int selectedValue;
  final User user;
  final refresh;
  final updateNum;
  final bool isClicked;
  final updatePrice;
  final int productPrice;
  final CartProduct cartProduct;
  @override
  _CartCardBoxState createState() => _CartCardBoxState();
}

class _CartCardBoxState extends State<CardBox>
    implements CartItemsListViewContract {
  var value = 1;
  var retry = false;
  late CartItemsListPresenter _presenter;

  updateCartItem(int? quantity) {
    CartItem cartItem = CartItem();
    cartItem.item_id = widget.cartProduct.item_id;
    cartItem.quantity = quantity!;
    cartItem.customer_id = widget.user.customer_id;
    cartItem.price = widget.cartProduct.price;
    cartItem.product_id = widget.cartProduct.product_id;
    _presenter.loadItems(HttpRequest(
        'Put',
        'CartItems/update?item_id=${widget.cartProduct.item_id}',
        jsonEncode(cartItem)));
    retry = true;
    // print("fuck");
  }

  @override
  void initState() {
    super.initState();
    value = widget.cartProduct.quantity;
  }

  _CartCardBoxState() {
    _presenter = CartItemsListPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        DropdownButton<int>(
          items: const [
            DropdownMenuItem(
              child: Text("×1"),
              value: 1,
            ),
            DropdownMenuItem(
              child: Text("×2"),
              value: 2,
            ),
            DropdownMenuItem(
              child: Text("×3"),
              value: 3,
            ),
            DropdownMenuItem(
              child: Text("×4"),
              value: 4,
            ),
            DropdownMenuItem(
              child: Text("×5"),
              value: 5,
            )
          ],
          hint: const Text("num"),
          style: const TextStyle(fontSize: 15, color: Colors.green),
          underline: const Divider(
            height: 1,
            color: Colors.blue,
          ),
          value: value,
          onChanged: (int? newValue) {
            setState(() {
              if (widget.isClicked) {
                widget.updatePrice((newValue! - value) * widget.productPrice);
              }
              value = newValue!;
              widget.updateNum(value);
            });
            updateCartItem(newValue);
          },
          onTap: () {},
        ),
      ],
    );
  }

  @override
  void onLoadCartItemsComplete(List<CartItem> items) {
    widget.refresh();
    print("fresh");
  }

  @override
  void onLoadCartItemsError(onError) {
    print(onError);
  }
}
