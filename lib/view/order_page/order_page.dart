import 'package:csi5112_project/presenter/order_presenter.dart';
import 'package:flutter/material.dart';
import '../../data/order_data.dart';
import '../../presenter/order_presenter.dart';
import '../../components/search_bar.dart';
import './order_filter_panel.dart';
import '../../components/suspend_page.dart';
import '../../data/http_data.dart';
import '../../data/user_data.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({ Key? key, required this.user }) : super(key: key);

  final User user;
  
  @override
  OrderPageState createState() => OrderPageState();
}

class OrderPageState extends State<OrderPage> implements OrdersListViewContract {
  late OrdersListPresenter _presenter;
  List<Order> ordersReceived = [];
  List<Order> ordersFiltered = [];
  String loadError = "";
  bool isSearching = false;
  bool isLoadError = false;
  
  OrderPageState() {
    _presenter = OrdersListPresenter(this);
  }
  
  @override
  void initState() {
    super.initState();
    isSearching = true;
    _presenter.loadOrder(HttpRequest('Get', 'SalesOrders/all', {}));
  }

  void retry() {
    isSearching = true;
    _presenter.loadOrder(HttpRequest('Get', 'SalesOrders/all', {}));
  }
  
  @override
  Widget build(BuildContext context) {
    return SuspendCard(
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: SearchBar(onSearchFinish: (value) => updateItemList(value), hintText: "Search the Customer's ID",),
        ),
        body: Center(
          child: OrderFilterPanel(orders: ordersFiltered, isMerchant: widget.user.isMerchant),
        ),
      ), 
      isLoadError: isLoadError, 
      isSearching: isSearching, 
      loadError: loadError, 
      data: ordersReceived,
      retry: () => retry(),
    );
  }

  void updateItemList(List<Order> items) {
    setState(() {
      ordersFiltered = items;
    });
  }

  @override
  void onLoadOrdersComplete(List<Order> orders) {
    setState(() {
      ordersReceived = orders;
      ordersFiltered = orders;
      isSearching = false;
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