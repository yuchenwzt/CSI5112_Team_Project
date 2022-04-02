import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({ Key? key, this.onSearchFinish, required this.hintText}) : super(key: key);

  final onSearchFinish;
  final String hintText;

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
            decoration: InputDecoration(
              hintText: widget.hintText,
              prefixIcon: const Icon(Icons.search)
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
    var searchInput = moveBlank(searchController.text);
    widget.onSearchFinish(searchInput);
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

  // this filter function is filtered on front-end
  // we now use back-end to filter the product
  
  // List filter(String filterString) {
  //   List<Product> listRes = [];
  //   List<Order> orderRes = [];
  //   for (var o in widget.searchProducts) {
  //     if (filterCase(o, filterString)) {
  //       widget.filterType == "product" ? listRes.add(o) : orderRes.add(o);
  //     }
  //   }
  //   return widget.filterType == "product" ? listRes : orderRes;
  // }

  // bool filterCase(dynamic o, String filterString) {
  //   bool res = false;
  //   if (widget.filterType == "order") {
  //     res = (o as Order).order_id == filterString;
  //   } else if (widget.filterType == "product") {
  //     res = (o as Product).name.toLowerCase().contains(filterString.toLowerCase()) || o.description.toLowerCase().contains(filterString.toLowerCase());
  //   }
  //   return res;
  // }
}