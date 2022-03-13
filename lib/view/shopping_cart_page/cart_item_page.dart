import 'package:csi5112_project/data/cart_item_data.dart';
import 'package:csi5112_project/presenter/cart_item_presenter.dart';
import 'package:csi5112_project/view/shopping_cart_page/cart_bottom_bar.dart';
import 'package:csi5112_project/view/shopping_cart_page/cart_item_card.dart';
import 'package:flutter/material.dart';
import '../../data/http_data.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);
  @override
  CartPageState createState() => CartPageState();
}

class CartPageState extends State<CartPage>
    implements CartItemsListViewContractCart {
  late CartItemsListPresenterCart _presenter;
  List<CartItem> itemsCart = [];
  int amountPrice = 0;
  bool isSearching = false;
  bool isClicked = false;
  bool isClickedAll = false;
  int amountPriceAdd = 0;
  CartPageState() {
    _presenter = CartItemsListPresenterCart(this);
  }

  List<Widget> _getListItems() {
    var items = itemsCart.map((value) {
      return CartItemCard(
          cartItem: value,
          updatePrice: updatePrice,
          amountPrice: amountPrice,
          isClickedAll: isClickedAll,
          amountPriceAdd: amountPriceAdd);
    });
    return items.toList();
  }

  @override
  void initState() {
    super.initState();
    isSearching = true;
    isClicked = false;
    _presenter.loadItems(HttpRequest('Get', 'CartItem/all', {}));
  }

  void updatePrice(int value) {
    setState(() {
      amountPrice = amountPrice + value;
    });
  }

  void updateIsClickAll(bool value) {
    setState(() {
      isClickedAll = value;
    });
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

  @override
  void onLoadCartItemsComplete(List<CartItem> items) {
    setState(() {
      itemsCart = items;
      isSearching = false;
    });
  }

  @override
  void onLoadCartItemsError() {
    
  }
}
