import 'package:flutter/material.dart';
import 'address_card.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({Key? key, required this.user, this.onEditFinish}) : super(key: key);

  final dynamic user;
  final onEditFinish;

  @override
  UserAddressState createState() => UserAddressState();
}

class UserAddressState extends State<AddressPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Address"),
      ),
      body: ListView(
        children: buildUserAddressList(),
      ),
    );
  }

  List<AddressCard> buildUserAddressList() {
    return widget.user.address.map((address) => AddressCard(address: address, onEditFinish: widget.onEditFinish,)).toList();
  }
}

