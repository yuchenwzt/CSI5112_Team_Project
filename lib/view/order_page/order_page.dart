import 'package:csi5112_project/presenter/order_presenter.dart';
import 'package:flutter/material.dart';
import '../../data/order_data.dart';
import '../../presenter/order_presenter.dart';
import '../../components/search_bar.dart';
import './order_filter_panel.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({ Key? key, required this.isMerchant }) : super(key: key);

  final bool isMerchant;
  
  @override
  OrderPageState createState() => OrderPageState();
}

class OrderPageState extends State<OrderPage> implements OrdersListViewContract {
  late OrdersListPresenter _presenter;
  List<Order> ordersReceived = [];
  List<Order> ordersFiltered = [];
  bool isSearching = false;
  
  OrderPageState() {
    _presenter = OrdersListPresenter(this);
  }
  
  @override
  void initState() {
    super.initState();
    isSearching = true;
    _presenter.loadOrder();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: SearchBar(searchItems: ordersReceived, onSearchFinish: (value) => updateItemList(value), filterType: "order"),
      ),
      body: Center(
        child: OrderFilterPanel(orders: ordersFiltered, isMerchant: widget.isMerchant),
      ),
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
  void onLoadOrdersError() {
    // TODO when backend set up
  }
}