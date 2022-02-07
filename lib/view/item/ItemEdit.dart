import 'package:flutter/material.dart';
import '../../data/item_data.dart';

class ItemEdit extends StatefulWidget {
  const ItemEdit({ Key? key, required this.items }) : super(key: key);

  final List<Item> items;
  
  @override
  _ItemEditState createState() => _ItemEditState();
}

class _ItemEditState extends State<ItemEdit> {
  @override
  Widget build(BuildContext context) {
    return ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: buildItemList(),
      );
  }

  List<ItemListOption> buildItemList() {
    return widget.items.map((itemsState) => ItemListOption(itemsState)).toList();
  }
}

class ItemListOption extends ListTile {
  
  ItemListOption(Item item, {Key? key}) 
    : super(
      key: key,
      title: Text(item.name),
      subtitle: Text(item.description),
    );
}