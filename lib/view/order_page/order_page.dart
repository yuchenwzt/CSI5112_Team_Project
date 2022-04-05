import 'dart:convert';
import 'package:csi5112_project/presenter/order_presenter.dart';
import 'package:flutter/material.dart';
import '../../data/order_data.dart';
import '../../presenter/order_presenter.dart';
import '../../components/search_bar.dart';
import './order_filter_panel.dart';
import '../../components/suspend_page.dart';
import '../../data/http_data.dart';
import '../../data/user_data.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({ Key? key, required this.user }) : super(key: key);

  final User user;
  
  @override
  OrderPageState createState() => OrderPageState();
}

class OrderPageState extends State<OrderPage> implements OrdersListViewContract {
  late OrdersListPresenter _presenter;
  List<OrderDetail> ordersReceived = [];
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
    String url = getSearchUrl("", false);
    _presenter.loadOrder(HttpRequest('Get', url, {}));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (Provider.of<bool>(context)) {
      retry();
    }
  }

  void retry() {
    isSearching = true;
    String url = getSearchUrl("", false);
    _presenter.loadOrder(HttpRequest('Get', url, {}));
  }

  String getSearchUrl(String input, bool isSearch) {
    String customerId = widget.user.isMerchant ? '%23' : widget.user.customer_id;
    String merchantId = widget.user.isMerchant ? widget.user.merchant_id : '%23';
    String role = widget.user.isMerchant ? 'Merchant' : 'Customer';
    if (isSearch) {
      if (widget.user.isMerchant) {
        customerId = input;
      } else {
        merchantId = input;
      }
    }
    return 'SalesOrders/search_salesOrder_by_userId?customer_id=$customerId&merchant_id=$merchantId&role=$role';
  }
  
  @override
  Widget build(BuildContext context) {
    String hintText = "Search the " + (widget.user.isMerchant ? "Customer" : "Merchant") + "'s ID"; 
    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 247, 255, 0.5),
      appBar: AppBar(
        flexibleSpace: SearchBar(onSearchFinish: (value) => updateItemList(value), hintText: hintText,),
      ),
      body: SuspendCard( 
        child: OrderFilterPanel(orders: ordersReceived, user: widget.user, updateOrderStatus: updateOrderStatus),
        isLoadError: isLoadError, 
        isSearching: isSearching, 
        loadError: loadError, 
        data: ordersReceived,
        retry: () => retry(),  
      ),
    );
  }

  void updateOrderStatus(String orderId, String shippingId) {
    if(widget.user.isMerchant) {
      _presenter.loadOrder(HttpRequest('Put', 'SalesOrders/deliver_product?merchant_id=${widget.user.merchant_id}&order_id=$orderId&merchant_shipping_address_id=$shippingId', jsonEncode({})));
    } else {
      _presenter.loadOrder(HttpRequest('Put', 'SalesOrders/recieve_product?customer_id=${widget.user.customer_id}&order_id=$orderId', jsonEncode({})));
    }
  }

  void updateItemList(String input) {
    if (input == "") input = "%23";
    _presenter.loadOrder(HttpRequest('Get', getSearchUrl(input, true), {}));
  }

  @override
  void onLoadOrdersComplete(List<OrderDetail> orders) {
    setState(() {
      ordersReceived = orders;
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