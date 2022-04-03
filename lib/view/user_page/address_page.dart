import 'dart:convert';

import 'package:flutter/material.dart';
import 'address_card.dart';
import 'package:csi5112_project/data/user_data.dart';
import '../../data/shipping_address_data.dart';
import 'package:csi5112_project/presenter/shipping_address_presenter.dart';
import 'package:csi5112_project/data/http_data.dart';
import 'package:csi5112_project/components/suspend_page.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({Key? key, required this.user,}) : super(key: key);
  final User user;

  @override
  UserAddressState createState() => UserAddressState();
}

class UserAddressState extends State<AddressPage> implements ShippingAddressViewContract{
  TextEditingController shippingAddressController = TextEditingController();

  late ShippingAddressPresenter _presenter;
  List<ShippingAddress> shippingAddressReceived = [];
  bool isSearching = false;
  bool isLoadError = false;
  String loadError = "";

  @override
  void initState() {
    super.initState();
    isSearching = true;
    _presenter.loadAddress(HttpRequest('Get', 'ShippingAddress/by_user?user_id=${widget.user.isMerchant ? widget.user.merchant_id : widget.user.customer_id}', {}));
  }

  void retry() {
    isSearching = true;
    _presenter.loadAddress(HttpRequest('Get', 'ShippingAddress/by_user?user_id=${widget.user.isMerchant ? widget.user.merchant_id : widget.user.customer_id}', {}));
  }

  UserAddressState() {
    _presenter = ShippingAddressPresenter(this);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Address"),
      ),
      body: SuspendCard(
        child: ListView(
          children: [
            ...buildUserAddressList(),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () {
                sonKey.currentState!.showFormDialog(context, ShippingAddress(), 'create');
              },
              child: const Text('Add'),
            )
          ],
        ), 
        isLoadError: isLoadError, 
        isSearching: isSearching, 
        loadError: loadError, 
        data: shippingAddressReceived, 
        retry: () => retry,
      ),
    );
  }

  void updateAddress(ShippingAddress address, String type) {
    switch (type) {
      case 'create':
        _presenter.loadAddress(HttpRequest('Post', 'ShippingAddress/create', jsonEncode(address)));
        break;
      case 'update':
        _presenter.loadAddress(HttpRequest('Put', 'ShippingAddress/update?id=${address.shipping_address_id}', jsonEncode(address)));
        break;
    }
  }

  List<AddressCard> buildUserAddressList() {
    return shippingAddressReceived.map((address) => AddressCard(key: sonKey, address: address, onEditFinish:(value, type) => updateAddress(value, type))).toList();
  }

  @override
  void onLoadShippingAddressComplete(List<ShippingAddress> shippingAddress) {
    setState(() {
      shippingAddressReceived = shippingAddress;
      isSearching = false;
      isLoadError = false;
    });
  }

  @override
  void onLoadShippingAddressError(e) {
    setState(() {
      isSearching = false;
      isLoadError = true;
      // loadError = e;
    });
  }
}

