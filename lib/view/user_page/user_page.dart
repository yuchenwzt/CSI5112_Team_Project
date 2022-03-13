import '../../data/http_data.dart';
import 'package:flutter/material.dart';
import '../../data/merchant_data.dart';
import '../../data/customer_data.dart';
import '../../presenter/customer_presenter.dart';
import '../../presenter/merchant_presenter.dart';
import 'user_role_page.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key, required this.isMerchant, required this.current_id}) : super(key: key);
  final bool isMerchant;
  final String current_id;

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> implements MerchantListViewContract, CustomerListViewContract {
  late MerchantListPresenter _merchantPresenter;
  late CustomerListPresenter _customerPresenter;

  late Customer customer;
  late Merchant merchant;
  String loadError = "";
  bool isLoadError = false;

  _UserPageState() {
    _merchantPresenter = MerchantListPresenter(this);
    _customerPresenter = CustomerListPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    widget.isMerchant ? _merchantPresenter.loadMerchant(HttpRequest('Get', 'Merchants?id=${widget.current_id}', {})) : _customerPresenter.loadCustomer(HttpRequest('Get', 'Customers?id=${widget.current_id}', {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UserRolePage(user: widget.isMerchant ? merchant : customer)
    );
  }

  @override
  void onLoadCustomerComplete(List<Customer> customer) {
    setState(() {
      customer = customer;
    });
  }

  @override
  void onLoadCustomerError(e) {
    setState(() {
      isLoadError = true;
      loadError = e.toString();
    });
  }
  
  @override
  void onLoadMerchantComplete(List<Merchant> merchant) {
    setState(() {
      merchant = merchant;
    });
  }

  @override
  void onLoadMerchantError(e) {
    setState(() {
      isLoadError = true;
      loadError = e.toString();
    });
  }
}
