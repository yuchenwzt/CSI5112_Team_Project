import 'package:flutter/material.dart';
import '../../data/product_data.dart';
import 'package:intl/intl.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05, top: 10),
          child: const Text("Category: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        ),
        Padding(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1, top: 5),
          child: Text(product.category,
          style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 20)),
        ),
        Padding(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05, top: 10),
          child: const Text("Product Description: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        ),
        Padding(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1, top: 5),
          child: Text(product.description,
          style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 20)),
        ),
        Padding(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05, top: 10),
          child: const Text("Product Owner: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        ),
        Padding(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1, top: 5),
          child: Text(product.owner + " (" + product.owner_id.substring(0, 6) + "...)",
          style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 20)),
        ),
        Padding(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05, top: 10),
          child: const Text("Launch Date: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        ),
        Padding(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1, top: 5),
          child: Text(DateFormat('yyyy-MM-dd').format(product.date),
          style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 20)),
        ),
        Padding(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05, top: 10),
          child: const Text("Product Id: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        ),
        Padding(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1, top: 5),
          child: Text(product.product_id,
          style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 20)),
        ),
        Padding(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05, top: 10),
          child: const Text("Manufacture: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        ),
        Padding(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1, top: 5),
          child: Text(product.manufacturer,
          style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 20)),
        ),
      ],
    );
  }
}
