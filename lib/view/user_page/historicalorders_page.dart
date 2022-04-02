import 'package:flutter/material.dart';
import 'invoice_page.dart';
import 'package:csi5112_project/data/http_data.dart';
import 'package:csi5112_project/data/user_data.dart';
import 'package:csi5112_project/data/order_data.dart';
import 'package:csi5112_project/presenter/order_presenter.dart';

class HistoryOrderPage extends StatefulWidget {
  const HistoryOrderPage({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  HistoryOrderState createState() => HistoryOrderState();
}

class HistoryOrderState extends State<HistoryOrderPage> implements OrdersListViewContract {
  late OrdersListPresenter _presenter;
  List<Order> ordersReceived = [];
  bool isSearching = false;
  bool isLoadError = false;
  String loadError = "";

  @override
  void initState() {
    super.initState();
    isSearching = true;
    _presenter.loadOrder(HttpRequest('Get', 'ShippingAddress/by_user?user_id=${widget.user.isMerchant ? widget.user.merchant_id : widget.user.customer_id}', {}));
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
      body: ListView.separated(
        itemCount: ordersReceived.length,
        itemBuilder: (BuildContext context, int index) {
          String curInvoice = widget.user.customer_id;
          String itemName = widget.user.customer_id;
          String date = widget.user.customer_id;
          String image = widget.user.customer_id;
          return ListTile(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return Text(""
                      // invoice: curInvoice,
                    );
                  }),
                );
              },
              title: Text(itemName),
              subtitle: Text("Ordered on " + date),
              trailing: const Text("Invoice >"),
              leading: CircleAvatar(
                child: Text("Image" + image),
              ));
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            color: Colors.black,
            thickness: .1,
          );
        },
      ),
    );
  }

  @override
  void onLoadOrdersComplete(List<Order> items) {
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
