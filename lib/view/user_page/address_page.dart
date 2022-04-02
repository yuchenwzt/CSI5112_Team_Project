import 'package:flutter/material.dart';
import 'address_card.dart';
import 'package:csi5112_project/data/user_data.dart';
import '../../data/shipping_address_data.dart';
import 'package:csi5112_project/presenter/shipping_address_presenter.dart';
import 'package:csi5112_project/data/http_data.dart';

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

  UserAddressState() {
    _presenter = ShippingAddressPresenter(this);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Address"),
      ),
      body: ListView(
        children: [
          ...buildUserAddressList(),
          TextButton(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(fontSize: 20),
          ),
          onPressed: () {},
          child: const Text('Add'),
        )
        ],
      ), 
    );
  }

  List<AddressCard> buildUserAddressList() {
    return shippingAddressReceived.map((address) => AddressCard(address: address)).toList();
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
      loadError = e;
    });
  }
}

