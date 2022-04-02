import 'package:csi5112_project/data/cart_product.dart';
import 'package:csi5112_project/presenter/cart_product_presenter.dart';
import 'package:csi5112_project/view/shopping_cart_page/cart_box.dart';
import 'package:flutter/material.dart';
import 'package:csi5112_project/data/cart_item_data.dart';
import 'package:csi5112_project/data/product_data.dart';
import '../../data/http_data.dart';
import '../../presenter/product_presenter.dart';

class CartItemCard extends StatefulWidget {
  const CartItemCard(
      {Key? key,
      required this.cartProduct,
      this.updatePrice,
      required this.amountPrice,
      required this.isClickedAll,
      required this.amountPriceAdd})
      : super(key: key);

  final CartProduct cartProduct;
  final updatePrice;
  final int amountPrice;
  final bool isClickedAll;
  final int amountPriceAdd;

  @override
  _CartCardState createState() => _CartCardState();
}

class _CartCardState extends State<CartItemCard> {
  // late ProductsListPresenter _presenter;
  final itemFormKey = GlobalKey<FormState>();
  bool isClicked = false;
  int selectedValue = 1;
  late final CartProduct cartProduct;

  @override
  void initState() {
    super.initState();
    // _presenter.loadProducts(HttpRequest('Get', 'Products?product_id=${widget.cartProduct.product_id}', {}));
  }

  void updateNum(int value) {
    setState(() {
      selectedValue = value;
    });
  }

  // @override
  // void onLoadCartProductsComplete(List<CartProduct> products) {
  //   setState(() {
  //     cartProduct = products.first;
  //   });
  // }

  // @override
  // void onUpdateCartProductsComplete(List<CartProduct> products) {
  //   setState(() {
  //     cartProduct = products.first;
  //   });
  // }

  // @override
  // void onUpdateCartProductsError(e) {}

  // @override
  // void onLoadCartProductsError(e) {}

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          CardBox(
              selectedValue: selectedValue,
              updateNum: updateNum,
              isClicked: isClicked,
              updatePrice: widget.updatePrice,
              productPrice: widget.cartProduct.price),
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network(
              "https://imagepphcloud.thepaper.cn/pph/image/187/667/867.png",
              height: 30,
              // fit: BoxFit.cover,
            ),
          ),
          ListTile(
            leading: IconButton(
              color: isClicked
                  ? Colors.green
                  : const Color.fromRGBO(200, 200, 200, 1),
              icon: const Icon(Icons.add_circle_outline),
              onPressed: () {
                setState(() {
                  isClicked = !isClicked;
                  int res = isClicked
                      ? widget.cartProduct.price * selectedValue
                      : -(widget.cartProduct.price * selectedValue);
                  widget.updatePrice(res);
                });
              },
            ),
            title: Text(cartProduct.name,
                style: const TextStyle(fontSize: 20, color: Colors.black)),
            subtitle: Text(cartProduct.description,
                style: const TextStyle(fontSize: 20, color: Colors.blueGrey)),
            trailing: Column(children: <Widget>[
              Text(
                  "price: \$" +
                      widget.cartProduct.price.toString() +
                      "    " +
                      "tax: \$" +
                      (widget.cartProduct.price * 0.13).toString(),
                  style: const TextStyle(fontSize: 17, color: Colors.black)),
            ]),
          )
        ],
      ),
    );
  }
}
