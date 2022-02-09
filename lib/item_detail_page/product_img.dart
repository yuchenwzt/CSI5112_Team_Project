import 'package:csi5112_project/data/item_data_mock.dart';
import 'package:flutter/material.dart';
import '../data/item_data.dart';

class ProductImg extends StatefulWidget {
  const ProductImg({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Item item;

  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImg> {
  int selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Image.asset(
          kContacts[0].image,
          width: 300,
          height: 300,
        ),
      ),
    );
    // SizedBox(height: getProportionateScreenWidth(20)),
  }
}
