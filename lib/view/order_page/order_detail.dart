import 'package:csi5112_project/view/product_detail_page/product_description.dart';
import 'package:flutter/material.dart';
import '../../data/order_data.dart';
import '../../data/user_data.dart';
import '../../data/product_data.dart';
import '../../data/shipping_address_data.dart';
import 'package:csi5112_project/presenter/shipping_address_presenter.dart';
import 'package:csi5112_project/data/http_data.dart';
import 'package:csi5112_project/presenter/product_presenter.dart';
import 'package:progresso/progresso.dart';

class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage(
      {Key? key,
      required this.order,
      required this.user,
      required this.statusColor,
      required this.statusIcon,
      this.updateOrderStatus})
      : super(key: key);

  final OrderDetail order;
  final User user;
  final updateOrderStatus;
  final Color? statusColor;
  final Icon? statusIcon;

  @override
  State<StatefulWidget> createState() => OrderDetailState();
}

class OrderDetailState extends State<OrderDetailPage>
    implements ShippingAddressViewContract, ProductsListViewContract {
  final deliveryKey = GlobalKey<FormState>();

  late ShippingAddressPresenter _presenter;
  late ProductsListPresenter _presenter2;
  List<ShippingAddress> shippingAddressReceived = [];
  late ShippingAddress shippingAddressChoice;
  bool shippingAddressNull = false;
  String selectedAddress = "";
  Product product = Product();

  @override
  void initState() {
    super.initState();
    if (widget.user.isMerchant) {
      _presenter.loadAddress(HttpRequest('Get', 'ShippingAddress/by_user?user_id=${widget.user.merchant_id}', {}));
    }
    _presenter2.loadProducts(HttpRequest('Get', 'Products?product_id=${widget.order.salesOrder.product_id}', {}));
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.receipt),
                title: widget.user.isMerchant ? Text("Client ID: " + widget.order.salesOrder.customer_id, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)) 
                  : 
                  Text("Merchant ID: " + widget.order.salesOrder.merchant_id, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Product Name: ' + widget.order.salesOrder.name, style: const TextStyle(fontSize: 20)),
                    Text('Product ID: ' + widget.order.salesOrder.product_id, style: const TextStyle(fontSize: 20)),
                    Text('Quantity: ' + widget.order.salesOrder.quantity.toString(), style: const TextStyle(fontSize: 20)),
                    Text('Price: ' + widget.order.salesOrder.price.toString() + ' (Before Tax)', style: const TextStyle(fontSize: 20)),
                  ],
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 10)),
              ListTile(
                leading: const Icon(Icons.location_on),
                title: const Text("Shipping To", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                subtitle: widget.order.customerAddress.shipping_address_id == '#' ? const Text("Opps, the Shipping Address has been removed", style: TextStyle(fontSize: 20)) : Text(widget.order.customerAddress.address + " " + widget.order.customerAddress.city + " " + widget.order.customerAddress.state + " " + widget.order.customerAddress.country, style: const TextStyle(fontSize: 20)),
              ),
              const Padding(padding: EdgeInsets.only(top: 10)),
              ListTile(
                leading: const Icon(Icons.location_on),
                title: const Text("Delivery From", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                subtitle: widget.order.merchantAddress.shipping_address_id == '#' ? const Text("This Product hasn't been deliveried yet", style: TextStyle(fontSize: 20)) : Text(widget.order.merchantAddress.address + " " + widget.order.merchantAddress.city + " " + widget.order.merchantAddress.state + " " + widget.order.merchantAddress.country, style: const TextStyle(fontSize: 20)),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Your Product Status is ',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(widget.order.salesOrder.status, style: TextStyle(fontSize: 20, color: widget.statusColor, fontWeight: FontWeight.bold)),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Progresso(progress: getStatusProgress(widget.order.salesOrder.status), points: const [0.3, 0.6, 1.0], progressColor: widget.statusColor as Color, pointColor: widget.statusColor as Color, backgroundColor: Colors.grey,),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  ButtonBar(
                    alignment: MainAxisAlignment.start,
                    children: [
                      widget.user.isMerchant ? TextButton(
                        onPressed: widget.order.salesOrder.status == 'processing' ? () {
                          selectedAddress = shippingAddressReceived[0].shipping_address_id;
                          buildOrderList(context);
                        } : null,
                        child: const Text("Ship Product", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      ) :
                      TextButton(
                        onPressed: widget.order.salesOrder.status == 'delivering' ? () {
                          widget.updateOrderStatus(widget.order.salesOrder.order_id, "");
                        } : null,
                        child: const Text("Receive Confirm", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                        onPressed: () {showProductDetail(context);},
                        child: const Text("Product Detail", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  OrderDetailState() {
    _presenter = ShippingAddressPresenter(this);
    _presenter2 = ProductsListPresenter(this);
  }

  double getStatusProgress(String status) {
    switch (status) {
      case 'processing':
        return 0.3;
      case 'delivering':
        return 0.6;
      case 'finish':
        return 1;
      default: return 0.3;
    }
  }

  void showProductDetail(BuildContext context) {
    showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(
        scrollable: true,
        content: product.product_id == "" ? 
        Material(
          child: Column(children: const [
            Padding(padding: EdgeInsets.only(top: 40)),
            Icon(Icons.error_outline, size: 40, color: Colors.red,),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Opps, this product was removed by the Merchant',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ]),
        )
        : Material(child: 
          ProductDescription(product: product, showImage: true, showPrice: true,),
        )
      );
    });
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
                        value: shippingAddressNull ? "None Address Yet" : shippingAddressReceived[0].shipping_address_id,
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
                          widget.updateOrderStatus(
                              widget.order.salesOrder.order_id,
                              selectedAddress);
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
