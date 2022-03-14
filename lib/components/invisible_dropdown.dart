import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class InvisibleDropdown extends StatelessWidget {
  const InvisibleDropdown({ Key? key, required this.options, this.onFilterFinish, required this.index }) : super(key: key);

  final String options;
  final onFilterFinish;
  final int index;

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
          items: buildSelectList(getInitialList(options)),
          initialValue: getInitialList(options),
          listType: MultiSelectListType.CHIP,
          onConfirm: (values) {
            String res = "";
            values.forEach((value) {
              res += value as String;
              res += '_';
            });
            onFilterFinish(res.substring(0, res.lastIndexOf('_')), index);
          },
        ),
    );
  }

  List<String> getInitialList(String options) {
    return options.split('_');
  }
  
  List<MultiSelectItem> buildSelectList(List<String> products) {
    return products.map((location) => MultiSelectItem(location, location)).toList();
  }

  // Mock data function, deleted after back-end server set-up
  // List<Product> filterData(List<Object?> filters, String type) {
  //   List<Product> newProducts = [];
  //   for (Product product in products) {
  //     if (type == "location" && filters.contains(product.manufacturer)) {
  //       newProducts.add(product);
  //     } else if (type == "type" && filters.contains(product.category)) {
  //       newProducts.add(product);
  //     }
  //   }
  //   return newProducts;
  // }
}