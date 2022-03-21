import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class InvisibleDropdown extends StatelessWidget {
  const InvisibleDropdown({ Key? key, required this.options, required this.origins, this.onFilterFinish, required this.index }) : super(key: key);

  final String options;
  final String origins;
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
        MultiSelectDialogField(
          items: buildSelectList(getInitialList(origins)),
          initialValue: getInitialList(options),
          listType: MultiSelectListType.LIST,
          height: 300,
          searchable: true,
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
}