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
  List<OrderDetail> ordersReceived = [];
  List<OrderDetail> ordersFiltered = [];
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
    String hintText = "Search the " + (widget.user.isMerchant ? "Customer" : "Merchant") + "'s ID";
    return SuspendCard(
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: SearchBar(onSearchFinish: (value) => updateItemList(value), hintText: hintText,),
        ),
        body: Center(
          child: OrderFilterPanel(orders: ordersFiltered, user: widget.user, updateOrderStatus: updateOrderStatus),
        ),
      ), 
      isLoadError: isLoadError, 
      isSearching: isSearching, 
      loadError: loadError, 
      data: ordersReceived,
      retry: () => retry(),
    );
  }

  void updateOrderStatus() {
    if(widget.user.isMerchant) {

    } else {

    }
  }

  void updateItemList(List<OrderDetail> items) {
    setState(() {
      ordersFiltered = items;
    });
  }

  @override
  void onLoadOrdersComplete(List<OrderDetail> orders) {
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