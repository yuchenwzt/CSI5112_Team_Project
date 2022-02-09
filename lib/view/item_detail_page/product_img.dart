import 'package:csi5112_project/data/item_data_mock.dart';
import 'package:flutter/material.dart';
import '../../data/item_data.dart';

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
      child: Image(
        image: NetworkImage(widget.item.image),
        width: 370,
        height: 370,
        fit: BoxFit.fitHeight,
      ),
    );
    // SizedBox(height: getProportionateScreenWidth(20)),
  }
}
