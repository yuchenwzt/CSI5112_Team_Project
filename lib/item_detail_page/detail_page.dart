import 'package:csi5112_project/data/item_data_mock.dart';
import 'package:csi5112_project/view/item/ItemPage.dart';
import 'package:flutter/material.dart';
import 'body.dart';
import '../data/item_data.dart';
import 'package:csi5112_project/MainPage.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({
    Key? key,
  }) : super(key: key);

  @override
  DetailPageState createState() => DetailPageState();
}

class DetailPageState extends State<DetailPage> {
  int selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(child: Center(child: Text('Items'))),
        backgroundColor: Colors.red,
      ),
      body: Body(item: Item()),
    );
  }
}
