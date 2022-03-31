import 'dart:convert';

import 'package:csi5112_project/presenter/cart_item_presenter.dart';
import 'package:flutter/material.dart';
import 'product_description.dart';
import 'product_img.dart';
import '../../data/product_data.dart';
import 'package:csi5112_project/data/user_data.dart';
import 'package:csi5112_project/data/cart_item_data.dart';
import '../../data/http_data.dart';

class DetailPage extends StatefulWidget {
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
  DetailPageState createState() => DetailPageState();
}

class DetailPageState extends State<DetailPage> implements CartItemsListViewContract {

  late CartItemsListPresenter _presenter;

  DetailPageState() {
    _presenter = CartItemsListPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.product.category + " Store")),
      body: ListView(children: [
        const Padding(padding: EdgeInsets.only(top: 10)),
        ProductImg(product: widget.product),
        ProductDescription(product: widget.product),
        const Padding(padding: EdgeInsets.only(top: 30)),
        Visibility(
          visible: !widget.user.isMerchant,
          maintainState: false,
          maintainSize: false,
          maintainSemantics: false,
          child: SizedBox(
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
                    'Add to Cart',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    addToCart();
                  },
                ),
              ),
            )),
        ),
        const Padding(padding: EdgeInsets.only(top: 30)),
        // ItemChatPage(item: product, onEditFinish: onEditFinish)
      ]),
    );
  }

  void addToCart() {
    String filterUrl = "CartItems/create";
    CartItem newItem = CartItem();
    newItem.customer_id = widget.user.customer_id;
    newItem.quantity = 1;
    newItem.price = widget.product.price;
    newItem.product_id = widget.product.product_id; 
    _presenter.loadItems(HttpRequest('Post', filterUrl, jsonEncode(newItem)));
  }
  
  void showAddCartSuccess(BuildContext context) {
    showDialog(context: context,
    builder:(context) => AlertDialog(
      title: const Text('Add Cart Success'),
      content: const Text('Go to Cart page to check out!'),
      actions: <Widget> [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('OK'))
      ]
    ));
  }

  void showAddCartFailed(BuildContext context, dynamic e) {
    showDialog(context: context,
    builder:(context) => AlertDialog(
      title: const Text('Add Cart Failed'),
      content: Text(e.toString()),
      actions: <Widget> [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Try Again'))
      ]
    ));
  }

  @override
  void onLoadCartItemsComplete(List<CartItem> items) {
    showAddCartSuccess(context);
  }
  
  @override
  void onLoadCartItemsError(e) {
    showAddCartFailed(context, e);
  }
}
