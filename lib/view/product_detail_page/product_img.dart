import 'package:flutter/material.dart';
import '../../data/product_data.dart';

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
        image: NetworkImage(widget.product.image),
        width: 370,
        height: 370,
        fit: BoxFit.fitHeight,
      ),
    );
    // SizedBox(height: getProportionateScreenWidth(20)),
  }
}
