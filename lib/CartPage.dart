import 'package:flutter/material.dart';
import 'data/item_data.dart';
import 'presenter/item_presenter.dart';

class CartPage extends StatefulWidget {
  const CartPage({ Key? key }) : super(key: key);

  @override
  CartPageState createState() => CartPageState();
}

class CartPageState extends State<CartPage> implements ItemsListViewContract {
  late ItemsListPresenter _presenter;
  List<Item> itemsReceived = [];
  @override
  void initState() {
    super.initState();
    _presenter.loadItems();
  }
  
  CartPageState() {
    _presenter = ItemsListPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    return const Text("Cart");
  }

  @override
  void onLoadItemsComplete(List<Item> items) {
    setState(() {
      itemsReceived = items;
    });
  }

  @override
  void onLoadItemsError() {
    // TODO when backend set up
  }
}