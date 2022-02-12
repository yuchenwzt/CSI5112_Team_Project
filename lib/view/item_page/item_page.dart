import 'package:flutter/material.dart';
import '../../data/item_data.dart';
import '../../presenter/item_presenter.dart';
import 'item_filter_panel.dart';
import '../../components/search_bar.dart';

class ItemPage extends StatefulWidget {
  const ItemPage({Key? key, required this.isMerchant}) : super(key: key);
  
  final bool isMerchant;

  @override
  ItemListState createState() => ItemListState();
}

class ItemListState extends State<ItemPage> implements ItemsListViewContract {
  late ItemsListPresenter _presenter;
  List<Item> itemsReceived = [];
  List<Item> itemsFiltered = [];
  bool isSearching = false;

  ItemListState() {
    _presenter = ItemsListPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    isSearching = true;
    _presenter.loadItems();
  }
  
  @override
  Widget build(BuildContext context) {
    late Widget selectedWidget;
    if (isSearching) {
      selectedWidget = const Center(
        child: Padding(
          padding: EdgeInsets.only(left: 16.0, right: 16.0),
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      selectedWidget = Scaffold(
        appBar: AppBar(
          flexibleSpace: SearchBar(searchItems: itemsReceived, filterType: "item", onSearchFinish: (value) => updateItemList(value)),
        ),
        body: Center(
          child: ItemFilterPanel(items: itemsFiltered, 
            originItems: itemsReceived, 
            isMerchant: widget.isMerchant, 
            onSelectFinish: (value) => updateItemList(value), 
            onEditFinish: (value) => updateEditItem(value)
          ),
        ),
      );
    }

    return selectedWidget;
  }

  @override
  void onLoadItemsComplete(List<Item> items) {
    setState(() {
      itemsReceived = items;
      itemsFiltered = items;
      isSearching = false;
    });
  }

  void updateItemList(List<Item> items) {
    setState(() {
      itemsFiltered = items;
    });
  }

  // mock update func, deleted when build up backend
  void updateEditItem(Item item) {
    var newItem = itemsFiltered;
    if (newItem.contains(item)) {
      newItem[newItem.indexOf(item)] = item;
    } else {
      newItem.add(item);
    }
    
    setState(() {
      itemsFiltered = newItem;
    });
  }

  @override
  void onLoadItemsError() {
    // TODO when backend set up
  }
}