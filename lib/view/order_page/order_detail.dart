import 'package:flutter/material.dart';
import '../../data/order_data.dart';
import '../../data/user_data.dart';
import '../../data/product_data.dart';
import '../../data/shipping_address_data.dart';
import 'package:csi5112_project/presenter/shipping_address_presenter.dart';
import 'package:csi5112_project/data/http_data.dart';
import 'package:intl/intl.dart';
import 'package:csi5112_project/presenter/product_presenter.dart';

class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({ Key? key, required this.order, required this.user, this.updateOrderStatus }) : super(key: key);

  final OrderDetail order;
  final User user;
  final updateOrderStatus;
  
  @override
  State<StatefulWidget> createState() => OrderDetailState();
}

class OrderDetailState extends State<OrderDetailPage> implements ShippingAddressViewContract, ProductsListViewContract  {
  final deliveryKey = GlobalKey<FormState>();

  late ShippingAddressPresenter _presenter;
  late ProductsListPresenter _presenter2;
  List<ShippingAddress> shippingAddressReceived = [];
  late ShippingAddress shippingAddressChoice;
  String selectedAddress = "";
  Product product = Product();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Order Details")),
      body: Column(
        children: [
          Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.receipt),
                    title: Text('Order ' + widget.order.salesOrder.order_id.substring(0, 6) + ' ... Details'),
                    subtitle: Text('Product Name: ' + widget.order.salesOrder.name),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Your Product Status is ' + widget.order.salesOrder.status,
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.start,
                    children: [
                      widget.user.isMerchant ? TextButton(
                        onPressed: widget.order.salesOrder.status == 'processing' ? () {
                          selectedAddress = shippingAddressReceived[0].shipping_address_id;
                          buildOrderList(context);
                        } : null,
                        child: const Text("Ship Product"),
                      ) :
                      TextButton(
                        onPressed: widget.order.salesOrder.status == 'delivering' ? () {
                          widget.updateOrderStatus(widget.order.salesOrder.order_id, "");
                        } : null,
                        child: const Text("Receive Confirm"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.user.isMerchant) {
      _presenter.loadAddress(HttpRequest('Get', 'ShippingAddress/by_user?user_id=${widget.user.merchant_id}', {}));
    }
    _presenter2.loadProducts(HttpRequest('Get', 'Products?product_id=${widget.order.salesOrder.product_id}', {}));
  }

  OrderDetailState() {
    _presenter = ShippingAddressPresenter(this);
    _presenter2 = ProductsListPresenter(this);
  }

  void buildOrderList(BuildContext context) {
    showDialog(context: context, builder: (BuildContext context) {
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
                    value: shippingAddressReceived[0].shipping_address_id,
                    items: showAllAddress(shippingAddressReceived),
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
                    if (deliveryKey.currentState!.validate()) {
                      deliveryKey.currentState!.save();
                      widget.updateOrderStatus(widget.order.salesOrder.order_id, selectedAddress);
                      Navigator.pop(context);
                    }
                  },
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  List<DropdownMenuItem> showAllAddress(List<ShippingAddress> shippingAddressReceived) {
    return shippingAddressReceived.map((s) => DropdownMenuItem(value: s.shipping_address_id, child: Text(s.zipcode + " " + s.address + " " + s.city + " " + s.state + " " + s.country))).toList();
  }

  @override
  void onLoadShippingAddressComplete(List<ShippingAddress> shippingAddress) {
    setState(() {
      shippingAddressReceived = shippingAddress;
    });
  }

  @override
  void onLoadShippingAddressError(e) {}

  @override
  void onLoadProductsComplete(List<Product> products) {
    setState(() {
      product = products.isEmpty ? Product() : products[0];
    });
  }

  @override
  void onUpdateProductsComplete(List<Product> products) {}

  @override
  void onLoadProductsError(e) {}

  @override
  void onUpdateProductsError(e) {}
}