import 'package:flutter/material.dart';
import '../data/item_data.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({ Key? key, required this.searchItems, this.onSearchFinish}) : super(key: key);

  final List<Item> searchItems;
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

  List<Item> filter(String filterString) {
    List<Item> res = [];
    for (var o in widget.searchItems) {
      if (o.name.toLowerCase().contains(filterString.toLowerCase()) || o.description.toLowerCase().contains(filterString.toLowerCase())) {
        res.add(o);
      }
    }
    return res;
  }
}