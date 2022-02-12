import 'package:csi5112_project/data/item_data.dart';
import 'package:csi5112_project/presenter/item_presenter_cart.dart';
import 'package:csi5112_project/view/shopping_cart_page/item_cart_card.dart';
import 'package:flutter/material.dart';

import 'cart_bottom_bar.dart';



class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);
  @override
  CartPageState createState() => CartPageState();
}

class CartPageState extends State<CartPage> implements ItemsListViewContractCart {
  late ItemsListPresenterCart _presenter;
  List<Item> itemsCart = [];
  int amountPrice = 0;
  bool isSearching = false;
  bool isClicked = false;
  bool isClickedAll = false;

  CartPageState() {
    _presenter = ItemsListPresenterCart(this);
  }

  @override
  void initState() {
    super.initState();
    isSearching = true;
    isClicked = false;
    _presenter.loadItems();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ListView(
          children: _getListItems(),
        ),
        CartBottomBar(
            amountPrice: amountPrice,
            isClickedAll: isClickedAll,
            updateIsClickAll: updateIsClickAll),
      ],
    );
  }

  List<Widget> _getListItems() {
    var items = itemsCart.map((value) {
      return CartCard(
        item: value,
        updatePrice: updatePrice,
        amountPrice: amountPrice,
        isClickedAll: isClickedAll);
    });
    return items.toList();
  }

  void updatePrice(int value) {
    setState(() {
      amountPrice = value;
    });
  }

  void updateIsClickAll(bool value) {
    setState(() {
      isClickedAll = value;
    });
  }

  @override
  void onLoadItemsComplete(List<Item> items) {
    setState(() {
      itemsCart = items;
      isSearching = false;
    });
  }

  @override
  void onLoadItemsError() {
  }
}
