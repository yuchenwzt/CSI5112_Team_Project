import 'package:csi5112_project/view/product_page/product_page.dart';
import 'package:flutter/material.dart';
import '../shopping_cart_page/cart_item_page.dart';

import '../../data/product_data.dart';
import 'package:csi5112_project/data/user_data.dart';
// import '../item_chat_page/item_chat_page.dart';

class EditCate extends StatefulWidget {
  @override
  EditCateState createState() => EditCateState();
}

class EditCateState extends State<EditCate> {
  List<String> items = [];
  TextEditingController data = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
          "Edit Categories",
          //style: TextStyle(fontSize: 25.0),
          textAlign: TextAlign.center,
        )),
        body: ListView(children: [
          const Padding(padding: EdgeInsets.only(top: 10)),
          Container(
            height: 400,
            width: 200,
            child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return (ListTile(
                    title: Text(
                      items[index],
                      style: TextStyle(fontSize: 18.0),
                    ),
                    trailing: IconButton(
                        iconSize: 20.0,
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          setState(() {
                            items.removeAt(index);
                            index--;
                          });
                        }),
                  ));
                }),
          ),
          Container(
              margin: EdgeInsets.all(20.0),
              child: Row(
                textDirection: TextDirection.rtl,
                children: <Widget>[
                  FloatingActionButton(
                    backgroundColor: Colors.blueGrey,
                    onPressed: () {
                      setState(() {
                        if (data.text != "") {
                          items.add(data.text);
                        }
                        data.clear();
                      });
                    },
                    child: Icon(
                      Icons.add,
                    ),
                  ),
                  Expanded(
                      child: TextField(
                    style: TextStyle(color: Colors.black, fontSize: 18.0),
                    controller: data,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(hintText: "Add a category"),
                  )),
                ],
              )),
          const Padding(padding: EdgeInsets.only(top: 10)),
          SizedBox(
              width: 30,
              height: 40,
              child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Material(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(5),
                      elevation: 6,
                      child: MaterialButton(
                          child: const Text(
                            'Save Changes',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }))))
        ]));
  }
}
