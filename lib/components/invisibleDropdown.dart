import 'package:flutter/material.dart';
import '../data/item_data.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class InvisibleDropdown extends StatelessWidget {
  const InvisibleDropdown({ Key? key, required this.type, required this.items, this.onFilterFinish }) : super(key: key);

  final String type;
  final List<Item> items;
  final onFilterFinish;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: false,
      maintainState: true,
      maintainAnimation: true,
      maintainSize: true,
      maintainInteractivity: true,
      child: 
        MultiSelectBottomSheetField(
          items: buildSelectList(getInitialList(type, items)),
          initialValue: getInitialList(type, items),
          listType: MultiSelectListType.CHIP,
          onConfirm: (values) {
            onFilterFinish(filterData(values, type));
          },
        ),
    );
  }

  List<String> getInitialList(String type, List<Item> items) {
    if (type == "location") {
      return items.map((e) => e.location).toSet().toList();
    } else {
      return items.map((e) => e.type).toSet().toList();
    }
  }
  
  List<MultiSelectItem> buildSelectList(List<String> items) {
    return items.map((location) => MultiSelectItem(location, location)).toList();
  }

  List<Item> filterData(List<Object?> filters, String type) {
    List<Item> newItem = [];
    for (Item item in items) {
      if (type == "location" && filters.contains(item.location)) {
        newItem.add(item);
      } else if (type == "type" && filters.contains(item.type)) {
        newItem.add(item);
      }
    }
    return newItem;
  }
}