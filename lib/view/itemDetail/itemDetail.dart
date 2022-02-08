import 'package:flutter/material.dart';
import '../../data/item_data.dart';

class ItemDetailPage extends StatelessWidget {
  const ItemDetailPage({ Key? key, required this.item }) : super(key: key);

  final Item item;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(item.name)),
      body: Text(item.description),
    );
  }
}