import 'package:intl/intl.dart';
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
    String url = widget.user.isMerchant ? 'SalesOrders/search_salesOrder_by_userId?customer_id=%23&merchant_id=${widget.user.merchant_id}&role=Merchant' : 'SalesOrders/search_salesOrder_by_userId?customer_id=${widget.user.customer_id}&merchant_id=%23&role=Customer';
    _presenter.loadOrder(HttpRequest('Get', url, {}));
  }

  void retry() {
    isSearching = true;
    String url = widget.user.isMerchant ? 'SalesOrders/search_salesOrder_by_userId?customer_id=%23&merchant_id=${widget.user.merchant_id}&role=Merchant' : 'SalesOrders/search_salesOrder_by_userId?customer_id=${widget.user.customer_id}&merchant_id=%23&role=Customer';
    _presenter.loadOrder(HttpRequest('Get', url, {}));
  }

  HistoryOrderState() {
    _presenter = OrdersListPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Receipts"),
      ),
      body: SuspendCard(
        child: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              onTap: () async {
                await Navigator.push(context, 
                  MaterialPageRoute(builder: (context) {
                    return InvoicePage(invoice: toVoiceList(ordersReceived[index]));
                  }),
                );
              },
              title: Text(ordersReceived[index].salesOrder.name),
              subtitle: Text("Ordered on " + DateFormat('yyyy-MM-dd').format(ordersReceived[index].salesOrder.date)),
              trailing: const Text("Invoice >"),
              leading: CircleAvatar(
                backgroundImage: Image.network(ordersReceived[index].salesOrder.image).image,
              )
            );
          }, 
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(
              color: Colors.black,
              thickness: .1,
            );
          }, 
          itemCount: ordersReceived.length
        ),
        isLoadError: isLoadError, 
        isSearching: isSearching, 
        loadError: loadError, 
        data: ordersReceived, 
        retry: retry,
      )
    );
  }

  List<String> toVoiceList(OrderDetail orderDetail) {
    List<String> invoice = []; 
    invoice.add(orderDetail.salesOrder.order_id);
    invoice.add(orderDetail.salesOrder.customer_id);
    invoice.add(orderDetail.salesOrder.product_id);
    invoice.add(orderDetail.salesOrder.name);
    invoice.add(orderDetail.salesOrder.quantity.toString());
    invoice.add(orderDetail.salesOrder.merchant_id);
    invoice.add(DateFormat('yyyy-MM-dd').format(orderDetail.salesOrder.date));
    invoice.add((orderDetail.salesOrder.price * orderDetail.salesOrder.quantity * 1.13).toStringAsFixed(2));
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
      loadError = e.toString();
    });
  }
}
