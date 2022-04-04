import 'package:csi5112_project/data/cart_product.dart';
import 'package:csi5112_project/presenter/cart_product_presenter.dart';
import 'package:csi5112_project/view/shopping_cart_page/cart_bottom_bar.dart';
import 'package:csi5112_project/view/shopping_cart_page/cart_item_card.dart';
import 'package:flutter/material.dart';
import '../../data/http_data.dart';
import '../../data/user_data.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  CartPageState createState() => CartPageState();
}

class CartPageState extends State<CartPage>
    implements CartProductsListViewContract {
  late CartProductsListPresenter _presenter;
  List<CartProduct> cartProducts = [];
  int amountPrice = 0;
  bool isSearching = false;
  bool isClicked = false;
  bool isClickedAll = false;
  int amountPriceAdd = 0;
  var reload = false;
  CartPageState() {
    _presenter = CartProductsListPresenter(this);
  }

  List<Widget> _getListItems() {
    var items = cartProducts.map((value) {
      return CartItemCard(
          refresh: () => retry(),
          cartProduct: value,
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
    // CartProduct a = CartProduct();
    // cartProducts.add(a);
    // setState(() {
    //   cartProducts = cartProducts;
    // });
    _presenter.loadCartProducts(HttpRequest('Get',
        'CartItems/by_customer?customer_id=${widget.user.customer_id}', {}));
  }

  retry() {
    print("object");
    isSearching = true;
    isClicked = false;
    _presenter.loadCartProducts(HttpRequest('Get',
        'CartItems/by_customer?customer_id=${widget.user.customer_id}', {}));
  }

  reloadPage(bool reload) {}
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
            user: widget.user,
            updateIsClickAll: updateIsClickAll),
      ],
    );
  }

  @override
  void onLoadCartProductsComplete(List<CartProduct> items) {
    setState(() {
      cartProducts = items;
      isSearching = false;
    });
  }

  @override
  void onLoadCartProductsError(e) {}
}
