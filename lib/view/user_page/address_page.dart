import 'dart:convert';
import 'package:flutter/material.dart';
import 'address_card.dart';
import 'package:csi5112_project/data/user_data.dart';
import '../../data/shipping_address_data.dart';
import 'package:csi5112_project/presenter/shipping_address_presenter.dart';
import 'package:csi5112_project/data/http_data.dart';
import 'package:csi5112_project/components/suspend_page.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({
    Key? key,
    required this.user,
  }) : super(key: key);
  final User user;

  @override
  UserAddressState createState() => UserAddressState();
}

class UserAddressState extends State<AddressPage>
    implements ShippingAddressViewContract {
  TextEditingController shippingAddressController = TextEditingController();
  final itemFormKey = GlobalKey<FormState>();
  late ShippingAddressPresenter _presenter;
  List<ShippingAddress> shippingAddressReceived = [];
  bool isSearching = false;
  bool isLoadError = false;
  String loadError = "";

  @override
  void initState() {
    super.initState();
    isSearching = true;
    _presenter.loadAddress(HttpRequest(
        'Get',
        'ShippingAddress/by_user?user_id=${widget.user.isMerchant ? widget.user.merchant_id : widget.user.customer_id}',
        {}));
  }

  void retry() {
    isSearching = true;
    _presenter.loadAddress(HttpRequest(
        'Get',
        'ShippingAddress/by_user?user_id=${widget.user.isMerchant ? widget.user.merchant_id : widget.user.customer_id}',
        {}));
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
        body: Column(children: [
          SuspendCard(
            child: ListView(
              shrinkWrap: true,
              children: buildUserAddressList(),
            ),
            isLoadError: isLoadError,
            isSearching: isSearching,
            loadError: loadError,
            data: shippingAddressReceived,
            retry: () => retry,
          ),
          const Padding(padding: EdgeInsets.only(top: 10)),
          FloatingActionButton(
            backgroundColor: Colors.red,
            onPressed: () {
              showFormDialog(
                  context,
                  ShippingAddress(
                      user_id: widget.user.isMerchant
                          ? widget.user.merchant_id
                          : widget.user.customer_id),
                  'create');
            },
            child: const Text('Add'),
          )
        ]));
  }

  void updateAddress(ShippingAddress address, String type) {
    switch (type) {
      case 'create':
        _presenter.loadAddress(
            HttpRequest('Post', 'ShippingAddress/create', jsonEncode(address)));
        break;
      case 'update':
        _presenter.loadAddress(HttpRequest(
            'Put',
            'ShippingAddress/update?id=${address.shipping_address_id}',
            jsonEncode(address)));
        break;
      case 'delete':
        _presenter.loadAddress(HttpRequest('Delete', 'ShippingAddress/delete',
            jsonEncode([address.shipping_address_id])));
    }
  }

  List<AddressCard> buildUserAddressList() {
    return shippingAddressReceived
        .map((address) => AddressCard(
            address: address,
            onEditFinish: (value, type) => updateAddress(value, type)))
        .toList();
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

  void showFormDialog(
      BuildContext context, ShippingAddress newAddress, String type) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            content: Stack(
              clipBehavior: Clip.antiAlias,
              children: <Widget>[
                Positioned(
                  right: -40.0,
                  top: -40.0,
                  child: InkResponse(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const CircleAvatar(
                      child: Icon(Icons.close),
                      backgroundColor: Colors.red,
                    ),
                  ),
                ),
                Form(
                  key: itemFormKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'address',
                          ),
                          initialValue: newAddress.address,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "The address Can't be Empty";
                            }
                            return null;
                          },
                          onSaved: (newValue) =>
                              newAddress.address = newValue as String,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'City',
                          ),
                          initialValue: newAddress.city,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "The City Can't be Empty";
                            }
                            return null;
                          },
                          onSaved: (newValue) =>
                              newAddress.city = newValue as String,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'State',
                          ),
                          initialValue: newAddress.state,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "The State Can't be Empty";
                            }
                            return null;
                          },
                          onSaved: (newValue) =>
                              newAddress.state = newValue as String,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Country',
                          ),
                          initialValue: newAddress.country,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "The Country Can't be Empty";
                            }
                            return null;
                          },
                          onSaved: (newValue) =>
                              newAddress.country = newValue as String,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Zipcode',
                          ),
                          initialValue: newAddress.zipcode,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "The Zipcode Can't be Empty";
                            }
                            return null;
                          },
                          onSaved: (newValue) =>
                              newAddress.zipcode = newValue as String,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ElevatedButton(
                          child: const Text("Submit"),
                          onPressed: () {
                            if (itemFormKey.currentState!.validate()) {
                              itemFormKey.currentState!.save();
                              updateAddress(newAddress, type);
                              Navigator.pop(context);
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
