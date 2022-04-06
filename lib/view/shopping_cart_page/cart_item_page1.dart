import 'dart:convert';

import 'package:csi5112_project/data/cart_product.dart';
import 'package:csi5112_project/data/shipping_address_data.dart';
import 'package:csi5112_project/presenter/cart_product_presenter.dart';
import 'package:csi5112_project/presenter/shipping_address_presenter.dart';
import 'package:csi5112_project/view/product_detail_page/payment_success_page.dart';
import 'package:csi5112_project/components/suspend_page.dart';
import 'package:flutter/material.dart';
import '../../data/http_data.dart';
import '../../data/user_data.dart';
import 'package:provider/provider.dart';
import 'package:event_bus/event_bus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cart_item_card1.dart';

class CartPage1 extends StatefulWidget {
  const CartPage1({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  CartPageState1 createState() => CartPageState1();
}

class CartPageState1 extends State<CartPage1>
    implements CartProductsListViewContract, ShippingAddressViewContract {
  late CartProductsListPresenter _presenter;
  final eventBus = EventBus();
  List<CartProduct> cartProducts = [];
  int amountPrice = 0;
  bool isSearching = false;
  bool isClicked = false;
  bool isLoadError = false;
  List<CartStatus> cartStatusList = [];
  String loadError = "";
  int amountPriceAdd = 0;
  var reload = false;
  bool shippingAddressNull = false;
  String selectedAddress = "";
  List<ShippingAddress> shippingAddressReceived = [];
  late ShippingAddressPresenter _presenter2;
  final deliveryKey = GlobalKey<FormState>();
  CartPageState1() {
    _presenter = CartProductsListPresenter(this);
    _presenter2 = ShippingAddressPresenter(this);
  }

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> _setCartSelected(List<String> selected) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setStringList('current_token', selected);
  }

  List<Widget> _getListItems() {
    var items = cartProducts.map((value) {
      return CartItemCard1(
          key: Key(value.item_id),
          eventBus: eventBus,
          updateStatus: updateStatus,
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

  void updateStatus(String item_id, bool isSelected) {
    cartStatusList.forEach((element) {
      if (element.item_id == item_id) {
        element.isSelected = isSelected;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    isSearching = true;
    isClicked = false;
    if (!widget.user.isMerchant) {
      _presenter2.loadAddress(HttpRequest('Get',
          'ShippingAddress/by_user?user_id=${widget.user.customer_id}', {}));
    }
    _presenter.initCartProducts(HttpRequest('Get',
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
                          buildOrderList(context);
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

  List<DropdownMenuItem> showAllAddress(
      List<ShippingAddress> shippingAddressReceived) {
    return shippingAddressReceived
        .map((s) => DropdownMenuItem(
            value: s.shipping_address_id,
            child: Text(s.zipcode +
                " " +
                s.address +
                " " +
                s.city +
                " " +
                s.state +
                " " +
                s.country)))
        .toList();
  }

  void buildOrderList(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            content: Form(
              key: deliveryKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: DropdownButtonFormField<dynamic>(
                        decoration: const InputDecoration(
                          labelText: 'Shipping Address',
                        ),
                        value: shippingAddressNull
                            ? "None Address Yet"
                            : shippingAddressReceived[0].shipping_address_id,
                        items: shippingAddressNull
                            ? [
                                const DropdownMenuItem(
                                  value: "None Address Yet",
                                  child: Text("None Address Yet"),
                                )
                              ]
                            : showAllAddress(shippingAddressReceived),
                        onChanged: (newValue) {
                          setState(() {
                            selectedAddress = newValue as String;
                          });
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      child: const Text("Submit"),
                      onPressed: () {
                        if (deliveryKey.currentState!.validate() &&
                            !shippingAddressNull) {
                          deliveryKey.currentState!.save();
                          _presenter2.loadAddress(HttpRequest(
                              'Post',
                              'SalesOrders/placeOrder',
                              jsonEncode(buildAllOrderList())));

                          Navigator.pop(context);
                        }
                        showPlaceOrderSuccess(context);
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  List<CartItemPlaceOrder> buildAllOrderList() {
    List<CartItemPlaceOrder> res = [];
    for (var cartStatus in cartStatusList) {
      if (cartStatus.isSelected) {
        for (var element in cartProducts) {
          if (element.item_id == cartStatus.item_id) {
            res.add(CartItemPlaceOrder(
                customer_id: widget.user.customer_id,
                product_id: element.product_id,
                quantity: element.quantity,
                shipping_address_id: selectedAddress,
                item_id: element.item_id));
          }
        }
      }
    }
    return res;
  }

  void showPlaceOrderSuccess(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
                title: const Text('Place Order Success'),
                content: const Text('Go to Order page to check out!'),
                actions: <Widget>[
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('OK'))
                ]));
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

  @override
  void onLoadShippingAddressComplete(List<ShippingAddress> shippingAddress) {
    setState(() {
      shippingAddressReceived = shippingAddress;
      shippingAddressNull = shippingAddress.isEmpty;
    });
  }

  @override
  void onLoadShippingAddressError(e) {}

  @override
  void onPlaceOrderComplete(e) {
    print("success");
  }

  @override
  void onPlaceOrderError(onError) {}

  @override
  void onInitCartProductsComplete(List<CartProduct> items) {
    for (var element in items) {
      cartStatusList
          .add(CartStatus(item_id: element.item_id, isSelected: false));
    }
  }

  @override
  void onInitCartProductsError(onError) {}
}
