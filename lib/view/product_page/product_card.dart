import 'dart:convert';

import 'package:flutter/material.dart';
import '../../data/product_data.dart';
import 'product_edit.dart';
import '../product_detail_page/product_detail_page.dart';
import 'package:intl/intl.dart';
import 'package:csi5112_project/data/user_data.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({ Key? key, required this.product, this.onEditFinish, required this.user }) : super(key: key);

  final Product product;
  final onEditFinish;
  final User user;

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final productFormKey = GlobalKey<FormState>();

  String image_code = "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";
  
  @override
  Widget build(BuildContext context) {
    String productDescription = widget.product.category + ' | ' + widget.product.owner + ' | ' + DateFormat('yyyy-MM-dd').format(widget.product.date);
    return Card(
      key: Key(widget.product.product_id),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) {
              return DetailPage(user: widget.user, product: widget.product, onEditFinish: widget.onEditFinish);
            }),
          );
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Image(
                image: widget.product.image_type == "network" ? Image.network(widget.product.image).image : Image.memory(base64Decode(image_code)).image,
                width: 160,
                height: 160,
                fit: BoxFit.fitHeight,
              ),
            ),
            ListTile(
              title: Text(widget.product.name, textAlign: TextAlign.center, style: const TextStyle(fontSize: 14.0)),
              subtitle: Text(productDescription, textAlign: TextAlign.center, style: const TextStyle(fontSize: 14.0)),
              contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Expanded(child: Text( '\$' + widget.product.price.toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.red)))
                ),
                
                Expanded(child: Text("Stored in " + widget.product.manufacturer, textAlign: TextAlign.center, style: const TextStyle(fontSize: 14, color: Colors.grey))),
                
                Visibility(
                  visible: widget.user.isMerchant,
                  maintainState: false,
                  maintainSize: false,
                  maintainSemantics: false,
                  child: ProductEdit(product: widget.product, onEditFinish: widget.onEditFinish, editRole: "edit")
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}