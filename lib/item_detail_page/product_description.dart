import 'package:flutter/material.dart';
import '../data/item_data.dart';
import 'package:csi5112_project/data/item_data_mock.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({Key? key, required this.item}) : super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 300, top: 30),
          child: Text(
            '\$' + kContacts[0].price,
            style: TextStyle(color: Colors.red, fontSize: 30),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 0, top: 20),
          child: Text(kContacts[0].name),
        ),
        Padding(
          padding: EdgeInsets.only(left: 0, top: 10),
          child: Text(kContacts[0].description),
        ),
      ],
    );
  }
}
