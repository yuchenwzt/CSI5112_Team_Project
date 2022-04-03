import 'package:flutter/material.dart';
import 'invoice_page.dart';
import 'package:csi5112_project/data/http_data.dart';
import 'package:csi5112_project/data/user_data.dart';
import 'package:csi5112_project/data/order_data.dart';
import 'package:csi5112_project/presenter/order_presenter.dart';
import 'package:csi5112_project/components/suspend_page.dart';

class HistoryOrderPage extends StatefulWidget {
  const HistoryOrderPage({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  HistoryOrderState createState() => HistoryOrderState();
}

class HistoryOrderState extends State<HistoryOrderPage> implements OrdersListViewContract {
  late OrdersListPresenter _presenter;
  List<OrderDetail> ordersReceived = [];
  bool isSearching = false;
  bool isLoadError = false;
  String loadError = "";

  @override
  void initState() {
    super.initState();
    isSearching = true;
    _presenter.loadOrder(HttpRequest('Get', 'SalesOrders?id=${widget.user.isMerchant ? widget.user.merchant_id : widget.user.customer_id}&role=${widget.user.isMerchant ? 'Merchant' : 'Customer'}', {}));
  }

  void retry() {
    isSearching = true;
    _presenter.loadOrder(HttpRequest('Get', 'SalesOrders?id=${widget.user.isMerchant ? widget.user.merchant_id : widget.user.customer_id}&role=${widget.user.isMerchant ? 'Merchant' : 'Customer'}', {}));
  }

  HistoryOrderState() {
    _presenter = OrdersListPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
      ),
      body: SuspendCard(
        child: ListView(
          children: buildOrderVoiceList(),
        ),
        isLoadError: isLoadError, 
        isSearching: isSearching, 
        loadError: loadError, 
        data: ordersReceived, 
        retry: retry,
      )
    );
  }

  List<InvoicePage> buildOrderVoiceList() {
    return ordersReceived.map((order) => InvoicePage(invoice: toVoiceList(order))).toList();
  }

  List<String> toVoiceList(OrderDetail orderDetail) {
    List<String> invoice = []; 
    invoice.add(orderDetail.salesOrder.order_id);
    invoice.add(orderDetail.salesOrder.customer_id);
    invoice.add(orderDetail.salesOrder.product_id);
    invoice.add(orderDetail.salesOrder.product_name);
    invoice.add(orderDetail.salesOrder.quantity.toString());
    invoice.add(orderDetail.salesOrder.merchant_id);
    invoice.add(orderDetail.salesOrder.date.toString());
    return invoice;
  }

  @override
  void onLoadOrdersComplete(List<OrderDetail> items) {
    setState(() {
      ordersReceived = items;
      isSearching = false;
      isLoadError = false;
    });
  }

  @override
  void onLoadOrdersError(e) {
    setState(() {
      isSearching = false;
      isLoadError = true;
      loadError = e;
    });
  }
}
