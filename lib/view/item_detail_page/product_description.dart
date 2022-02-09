import 'dart:ui';

import 'package:flutter/material.dart';
import '../../data/item_data.dart';
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
          padding: const EdgeInsets.only(right: 260, top: 20),
          child: Text(
            '\$' + kContacts[0].price,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.red, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 0, top: 8),
          child: Text(kContacts[0].name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 0, top: 4),
          child: Text(kContacts[0].description, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        ),
      ],
    );
  }
}
