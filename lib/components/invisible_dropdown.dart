import 'package:flutter/material.dart';
import '../data/product_data.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class InvisibleDropdown extends StatelessWidget {
  const InvisibleDropdown({ Key? key, required this.type, required this.products, this.onFilterFinish }) : super(key: key);

  final String type;
  final List<Product> products;
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
          items: buildSelectList(getInitialList(type, products)),
          initialValue: getInitialList(type, products),
          listType: MultiSelectListType.CHIP,
          onConfirm: (values) {
            onFilterFinish(filterData(values, type));
          },
        ),
    );
  }

  List<String> getInitialList(String type, List<Product> products) {
    if (type == "location") {
      return products.map((e) => e.manufacturer).toSet().toList();
    } else {
      return products.map((e) => e.category).toSet().toList();
    }
  }
  
  List<MultiSelectItem> buildSelectList(List<String> products) {
    return products.map((location) => MultiSelectItem(location, location)).toList();
  }

  List<Product> filterData(List<Object?> filters, String type) {
    List<Product> newProducts = [];
    for (Product product in products) {
      if (type == "location" && filters.contains(product.manufacturer)) {
        newProducts.add(product);
      } else if (type == "type" && filters.contains(product.category)) {
        newProducts.add(product);
      }
    }
    return newProducts;
  }
}