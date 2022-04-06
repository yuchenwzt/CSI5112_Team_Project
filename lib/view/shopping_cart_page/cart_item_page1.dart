import 'package:csi5112_project/data/cart_product.dart';
import 'package:csi5112_project/presenter/cart_product_presenter.dart';
import 'package:csi5112_project/view/product_detail_page/payment_success_page.dart';
import 'package:csi5112_project/view/shopping_cart_page/cart_bottom_bar.dart';
import 'package:csi5112_project/view/shopping_cart_page/cart_item_card.dart';
import 'package:csi5112_project/components/suspend_page.dart';
import 'package:flutter/material.dart';
import '../../data/http_data.dart';
import '../../data/user_data.dart';
import 'package:provider/provider.dart';
import 'package:event_bus/event_bus.dart';

import 'cart_item_card1.dart';

class CartPage1 extends StatefulWidget {
  const CartPage1({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  CartPageState1 createState() => CartPageState1();
}

class CartPageState1 extends State<CartPage1>
    implements CartProductsListViewContract {
  late CartProductsListPresenter _presenter;
  final eventBus = EventBus();
  List<CartProduct> cartProducts = [];
  int amountPrice = 0;
  bool isSearching = false;
  bool isClicked = false;
  bool isLoadError = false;
  String loadError = "";
  int amountPriceAdd = 0;
  var reload = false;
  CartPageState1() {
    _presenter = CartProductsListPresenter(this);
  }

  List<Widget> _getListItems() {
    var items = cartProducts.map((value) {
      return CartItemCard1(
          eventBus: eventBus,
          user: widget.user,
          refresh: () => retry(),
          cartProduct: value,
          updatePrice: updatePrice,
          amountPrice: amountPrice,
          isClickedAll: isClicked,
          amountPriceAdd: amountPriceAdd);
    });
    return items.toList();
  }

  @override
  void initState() {
    super.initState();
    isSearching = true;
    isClicked = false;
    _presenter.loadCartProducts(HttpRequest('Get',
        'CartItems/by_customer?customer_id=${widget.user.customer_id}', {}));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (Provider.of<bool>(context)) {
      retry();
    }
  }

  retry() {
    isSearching = true;
    // isClicked = false;
    _presenter.loadCartProducts(HttpRequest('Get',
        'CartItems/by_customer?customer_id=${widget.user.customer_id}', {}));
  }

  // retry1() {
  //   isClicked = !isClicked;
  // }

  void updatePrice(int value) {
    setState(() {
      amountPrice = amountPrice + value;
      if (amountPrice <= 0) {
        amountPrice = 0;
      }
    });
  }

  // void updateIsClickAll(bool value) {
  //   setState(() {
  //     isClickedAll = value;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return SuspendCard(
        child: Stack(children: <Widget>[
          ListView(
            shrinkWrap: true,
            children: _getListItems(),
          ),
          Positioned(
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
                        // updateIsClickAll(isClicked);
                      });
                      // retry();
                      eventBus.fire(isClicked);
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
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                  Text(
                    'Total:  \$' + amountPrice.toString() + '  ',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  Text(
                    'Tax:  \$' +
                        (amountPrice * 0.13).toString() +
                        '           ',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15),
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
          ),
        ]),
        isLoadError: isLoadError,
        isSearching: isSearching,
        loadError: loadError,
        data: cartProducts,
        retry: retry);
  }

  @override
  void onLoadCartProductsComplete(List<CartProduct> items) {
    setState(() {
      cartProducts = items;
      isSearching = false;
      isLoadError = false;
    });
  }

  @override
  void onLoadCartProductsError(e) {
    setState(() {
      isLoadError = true;
      loadError = e.toString();
    });
  }
}
