import 'package:flutter/material.dart';
import '../../data/product_data.dart';
import 'product_edit.dart';
import '../product_detail_page/product_detail_page.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({ Key? key, required this.product, this.onEditFinish, required this.isMarchant }) : super(key: key);

  final Product product;
  final onEditFinish;
  final bool isMarchant;

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final productFormKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    String productDescription = widget.product.category + ' | ' + widget.product.product_id;
    return Card(
      key: Key(widget.product.product_id),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) {
              return DetailPage(product: widget.product, onEditFinish: widget.onEditFinish);
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
                image: NetworkImage(widget.product.image),
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
                  visible: widget.isMarchant,
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