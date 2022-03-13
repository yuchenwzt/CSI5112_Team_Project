import 'package:csi5112_project/data/product_data.dart';
import 'package:csi5112_project/data/order_data.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({ Key? key, required this.searchProducts, this.onSearchFinish, required this.filterType}) : super(key: key);

  final List<dynamic> searchProducts;
  final String filterType;
  final onSearchFinish;

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {

  TextEditingController searchController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Container(
        width: double.infinity,
        height: 40,
        color: Colors.white,
        child: Center(
          child: TextField(
            controller: searchController,
            decoration: const InputDecoration(
              hintText: 'Search',
              prefixIcon: Icon(Icons.search)
            ),
            onSubmitted: (value) {onFilter();},
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(fontSize: 20),
          ),
          onPressed: () {onFilter();},
          child: const Text('Search'),
        )
      ],
    );
  }

  void onFilter() {
    var filterRes = filter(moveBlank(searchController.text));
    widget.onSearchFinish(filterRes);
  }

  String moveBlank(String filterString) {
    if (filterString.isEmpty) {
      return filterString;
    }
    var start = 0;
      var end = filterString.length - 1;
      while (filterString[start].compareTo(' ') == 0) {
        start++;
      }
      while (filterString[end].compareTo(' ') == 0) {
        end--;
      }
    return filterString.substring(start, end + 1);
  }

  List filter(String filterString) {
    List<Product> listRes = [];
    List<Order> orderRes = [];
    for (var o in widget.searchProducts) {
      if (filterCase(o, filterString)) {
        widget.filterType == "product" ? listRes.add(o) : orderRes.add(o);
      }
    }
    return widget.filterType == "product" ? listRes : orderRes;
  }

  bool filterCase(dynamic o, String filterString) {
    bool res = false;
    if (widget.filterType == "order") {
      res = (o as Order).order_id == filterString;
    } else if (widget.filterType == "product") {
      res = (o as Product).name.toLowerCase().contains(filterString.toLowerCase()) || o.description.toLowerCase().contains(filterString.toLowerCase());
    }
    return res;
  }
}