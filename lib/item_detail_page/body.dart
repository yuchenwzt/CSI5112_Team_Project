import 'package:csi5112_project/item_detail_page/product_description.dart';
import 'package:csi5112_project/item_detail_page/product_img.dart';
import 'package:flutter/material.dart';
import '../data/item_data.dart';
import '../data/item_data_mock.dart';
import 'detail_page.dart';

class Body extends StatelessWidget {
  final Item item;

  const Body({Key? key, required this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Padding(padding: EdgeInsets.only(top: 60)),
      ProductImg(item: item),
      ProductDescription(item: item),
      Padding(padding: EdgeInsets.only(top: 30)),
      SizedBox(
        width: 30,
        height: 30,
        child: Material(
          color: Colors.red,
          borderRadius: BorderRadius.circular(5),
          elevation: 6,
          child: MaterialButton(
            child: Text(
              'place the order',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {},
          ),
        ),
      ),
      Padding(padding: EdgeInsets.only(top: 20)),
      SizedBox(
        width: 30,
        height: 30,
        child: Material(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(5),
          elevation: 6,
          child: MaterialButton(
            child: Text(
              'Add to chart',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {},
          ),
        ),
      )
    ]);
  }
}
