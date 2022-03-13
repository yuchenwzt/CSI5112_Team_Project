import 'package:flutter/material.dart';
import '../../data/product_data.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 260, top: 20),
          child: Text(
            '\$' + product.price.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.red, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 0, top: 8),
          child: Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 0, top: 4),
          child: Text(product.description, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        ),
      ],
    );
  }
}
