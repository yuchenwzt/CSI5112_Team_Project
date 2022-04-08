import 'package:flutter/material.dart';

class SuspendCard extends StatelessWidget {
  const SuspendCard({
    Key? key,
    required this.child,
    required this.isLoadError,
    required this.isSearching,
    required this.loadError,
    required this.data,
    required this.retry,
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
        selectedWidget = Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0),
                child: ListTile(
                  leading: Icon(Icons.album, size: 48,),
                  title: Center(child: Text('The Data is Empty', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.grey))),
                  subtitle: Center(child: Text('Please wait for update', style: TextStyle(fontSize: 24, color: Colors.grey)))
                ),
              )
            ],
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
