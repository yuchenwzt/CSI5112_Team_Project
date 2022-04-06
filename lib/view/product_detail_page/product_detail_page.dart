import 'dart:convert';
import 'package:csi5112_project/presenter/cart_item_presenter.dart';
import 'package:flutter/material.dart';
import 'product_description.dart';
import '../../data/product_data.dart';
import 'package:csi5112_project/data/user_data.dart';
import 'package:csi5112_project/data/cart_item_data.dart';
import '../../data/http_data.dart';
import '../product_question_page/question_page.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:sliverbar_with_card/sliverbar_with_card.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({
    Key? key,
    required this.product,
    required this.user,
    this.onEditFinish,
  }) : super(key: key);

  final User user;
  final Product product;
  // ignore: prefer_typing_uninitialized_variables
  final onEditFinish;

  @override
  DetailPageState createState() => DetailPageState();
}

class DetailPageState extends State<DetailPage>
    implements CartItemsListViewContract {
  late CartItemsListPresenter _presenter;

  DetailPageState() {
    _presenter = CartItemsListPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CardSliverAppBar(
          height: 250,
          background: Image(
              image: Image.network(widget.product.image).image,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high),
          title: Text(widget.product.name,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold)),
          titleDescription: Text(
            '\$' + widget.product.price.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          card: Image.network(widget.product.image).image,
          backButton: true,
          backButtonColors: const [Colors.white, Colors.black],
          body: Container(
            color: Colors.white,
            child: ListView(shrinkWrap: true, children: [
              const Padding(padding: EdgeInsets.only(top: 40)),
              ProductDescription(
                product: widget.product,
                showImage: false,
                showPrice: false,
              ),
              const Padding(padding: EdgeInsets.only(top: 40)),
              Visibility(
                visible: !widget.user.isMerchant,
                maintainState: false,
                maintainSize: false,
                maintainSemantics: false,
                child: SizedBox(
                    height: 40,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: Material(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(5),
                        elevation: 6,
                        child: MaterialButton(
                          child: const Text(
                            'Add to Cart',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          onPressed: () {
                            addToCart();
                          },
                        ),
                      ),
                    )),
              ),
              const Padding(padding: EdgeInsets.only(top: 50)),
              QuestionPage(product: widget.product, user: widget.user),
            ]),
          )),
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
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
                title: const Text('Add Cart Success'),
                content: const Text('Go to Cart page to check out!'),
                actions: <Widget>[
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('OK'))
                ]));
  }

  void showAddCartFailed(BuildContext context, dynamic e) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
                title: const Text('Add Cart Failed'),
                content: Text(e.toString()),
                actions: <Widget>[
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Try Again'))
                ]));
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
