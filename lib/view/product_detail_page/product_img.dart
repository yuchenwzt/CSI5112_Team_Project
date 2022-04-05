import 'package:flutter/material.dart';
import '../../data/product_data.dart';
import 'dart:convert';

class ProductImg extends StatefulWidget {
  const ProductImg({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImg> {
  int selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image(
        image: widget.product.image_type == "network"
            ? Image.network(widget.product.image).image
            : Image.memory(base64Decode(widget.product.image)).image,
        width: 350,
        height: 350,
        fit: BoxFit.fitHeight,
      ),
    );
    // SizedBox(height: getProportionateScreenWidth(20)),
  }
}
