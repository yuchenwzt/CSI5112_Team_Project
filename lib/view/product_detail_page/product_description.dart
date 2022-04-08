import 'package:flutter/material.dart';
import '../../data/product_data.dart';
import 'package:intl/intl.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({Key? key, required this.product, required this.showImage, required this.showPrice}) : super(key: key);

  final Product product;
  final bool showImage;
  final bool showPrice;

  @override
  Widget build(BuildContext context) {
    var _dialogWidth = MediaQuery.of(context).size.width * 0.4;
    var _dialogHeight = MediaQuery.of(context).size.height * 0.25;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        showImage ? Padding(
          padding: const EdgeInsets.all(10),
          child: Image(image: Image.network(product.image).image, fit: BoxFit.cover, filterQuality: FilterQuality.high, width: _dialogWidth, height: _dialogHeight),
        ) : const Padding(padding: EdgeInsets.all(0)),
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
          child: Text(product.owner + " (..." + product.owner_id.substring(product.owner_id.length - 6, product.owner_id.length) + ")",
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
        showPrice ? Padding(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05, top: 10),
          child: const Text("Product Price: ",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
         ) : const Padding(padding: EdgeInsets.all(0)),
        showPrice ? Padding(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1, top: 5),
          child: Text(product.price.toString(),
          style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 20)),
        ) : const Padding(padding: EdgeInsets.all(0)),
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
