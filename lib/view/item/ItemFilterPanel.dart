import 'package:flutter/material.dart';
import '../../data/item_data.dart';
import 'itemCard.dart';
import 'ItemEdit.dart';

class ItemFilterPanel extends StatefulWidget {
  const ItemFilterPanel({ Key? key, required this.items, this.onSortFinish, this.onEditFinish }) : super(key: key);

  final List<Item> items;
  final onSortFinish;
  final onEditFinish;
  
  @override
  _ItemFilterPanelState createState() => _ItemFilterPanelState();
}

class _ItemFilterPanelState extends State<ItemFilterPanel> {
  bool priceAscending = true;
  
  @override
  void initState() {
    super.initState();
    priceAscending = true;
  }

  @override
  Widget build(BuildContext context) {
    List<Item> sortList = List.from(widget.items);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 55,
        flexibleSpace: Row(children: <Widget>[
          Expanded(child: Center(child: 
            TextButton(
              onPressed: () => {
                setState(() {
                  priceAscending = !priceAscending;
                }),
                priceAscending ? 
                  sortList.sort((a, b) => int.parse(a.price).compareTo(int.parse(b.price)))
                  : sortList.sort((a, b) => int.parse(b.price).compareTo(int.parse(a.price))),
                widget.onSortFinish(sortList)
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text("Prices", style: TextStyle(color: Colors.black),),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.keyboard_arrow_up, size: 18, color: priceAscending ? Colors.black : Colors.grey),
                      Icon(Icons.keyboard_arrow_down, size: 18, color: priceAscending ? Colors.grey : Colors.black)
                    ],
                  )
                ],
              ),
            ),
          )),
          const Expanded(child: Center(child: Text('Location'))),
          const Expanded(child: Center(child: Text('Filter'))),
        ]),
      ),
      floatingActionButton: Visibility(
        visible: true, // user_role
        maintainState: false,
        child: ItemEdit(item: Item(), onEditFinish: widget.onEditFinish, editRole: "add"),
      ),
      body: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 2,
        ),
        shrinkWrap: true,
        children: buildItemList(),
      ),
    );
  }

  List<ItemCard> buildItemList() {
    return widget.items.map((itemsState) => ItemCard(item: itemsState, onEditFinish: widget.onEditFinish)).toList();
  }
}