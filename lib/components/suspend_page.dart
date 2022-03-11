import 'package:flutter/material.dart';

class SuspendCard extends StatelessWidget {
  const SuspendCard({ 
    Key? key, 
    required this.child, 
    required this.isLoadError, 
    required this.isSearching, 
    required this.loadError, 
    required this.data,
    this.retry,
  }) : super(key: key);

  final String loadError;
  final bool isSearching;
  final bool isLoadError;
  final List data;
  final Widget child;
  final retry;

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
    } else if (!isLoadError) {
      if (data.isNotEmpty) {
        selectedWidget = child;
      } else {
        selectedWidget = const Center(
          child: Padding(
            padding: EdgeInsets.only(left: 16.0, right: 16.0),
            child: ListTile(
              leading: Icon(Icons.album),
              title: Text('The Data is Empty'),
              subtitle: Text('Please wait for Merchant to update more'),
            ),
          ),
        );
      }
    } else {
      selectedWidget = Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.album),
                  title: const Text('The Fetch is Error'),
                  subtitle: Text(loadError),
                ),
                TextButton(
                  child: const Text('Retry'),
                  onPressed: retry,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return selectedWidget;
  }
}