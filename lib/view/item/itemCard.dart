import 'package:flutter/material.dart';
import '../../data/item_data.dart';
import 'ItemEdit.dart';
import '../itemDetail/itemDetail.dart';

class ItemCard extends StatefulWidget {
  const ItemCard({ Key? key, required this.item, this.onEditFinish }) : super(key: key);

  final Item item;
  final onEditFinish;

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  final itemFormKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    String itemDescription = widget.item.type + ' | ' + widget.item.id + ' | ' + widget.item.date;
    bool isMarchant = true; // user_role
    return Card(
      key: Key(widget.item.id),
      child: InkWell(
        onTap: () {
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) => ItemDetailPage(item: widget.item)
          //   )
          // );
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) {
              return ItemDetailPage(item: widget.item);
            }),
          );
        },
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(
                  image: NetworkImage(widget.item.image),
                  width: 70,
                  height: 60,
                  fit: BoxFit.fitHeight,
                ),
              ],
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
                Expanded(child: Text( '\$' + widget.item.price, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.red))),
                
                Expanded(child: Text("Stored in " + widget.item.location, textAlign: TextAlign.center, style: const TextStyle(fontSize: 14, color: Colors.grey))),
                
                Visibility(
                  visible: isMarchant,
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