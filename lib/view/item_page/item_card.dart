import 'package:flutter/material.dart';
import '../../data/item_data.dart';
import 'item_edit.dart';
import '../item_detail_page/item_detail_page.dart';

class ItemCard extends StatefulWidget {
  const ItemCard({ Key? key, required this.item, this.onEditFinish, required this.isMarchant }) : super(key: key);

  final Item item;
  final onEditFinish;
  final bool isMarchant;

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  final itemFormKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    String itemDescription = widget.item.type + ' | ' + widget.item.id + ' | ' + widget.item.date;
    return Card(
      key: Key(widget.item.id),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) {
              return DetailPage(item: widget.item, onEditFinish: widget.onEditFinish);
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
                image: NetworkImage(widget.item.image),
                width: 160,
                height: 160,
                fit: BoxFit.fitHeight,
              ),
            ),
            ListTile(
              title: Text(widget.item.name, textAlign: TextAlign.center, style: const TextStyle(fontSize: 14.0)),
              subtitle: Text(itemDescription, textAlign: TextAlign.center, style: const TextStyle(fontSize: 14.0)),
              contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Expanded(child: Text( '\$' + widget.item.price, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.red)))
                ),
                
                Expanded(child: Text("Stored in " + widget.item.location, textAlign: TextAlign.center, style: const TextStyle(fontSize: 14, color: Colors.grey))),
                
                Visibility(
                  visible: widget.isMarchant,
                  maintainState: false,
                  maintainSize: false,
                  maintainSemantics: false,
                  child: ItemEdit(item: widget.item, onEditFinish: widget.onEditFinish, editRole: "edit")
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}