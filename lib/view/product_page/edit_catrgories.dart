import 'package:flutter/material.dart';
class EditCate extends StatefulWidget {
  const EditCate({Key? key, required this.options, this.onCateAddFinish, this.onCateUpdateFinish}) : super(key:key);

  final String options;
  final onCateAddFinish;
  final onCateUpdateFinish;
  
  @override
  EditCateState createState() => EditCateState();
}

class EditCateState extends State<EditCate> {
  List<String> items = [];
  List<String> itemsFilted = [];
  TextEditingController data = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    items = widget.options.split('_');
    itemsFilted = castBlank(widget.options).split('_');
  }

  void showEditFailed() {
    showDialog(context: context,
    builder:(context) => AlertDialog(
      title: const Text('Update Failed'),
      content: const Text('The Category is already existed.'),
      actions: <Widget> [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('OK'))
      ]
    ));
  }

  void showUpdateSuccess() {
    showDialog(context: context,
    builder:(context) => AlertDialog(
      title: const Text('Update Success'),
      content: const Text('Close the Edit window to update category'),
      actions: <Widget> [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('OK'))
      ]
    ));
  }

  String castBlank(String input) {
    String res = "";
    for (int i = 0; i < input.length; i++) {
      if ((i == 0 || i == input.length - 1) && input[i] == '_') {
        continue;
      } else if (input[i] == '_' && input[i + 1] == '_') {
        continue;
      } else {
        res += input[i];
      }
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Edit Categories",
        textAlign: TextAlign.center,
      )),
      body: ListView(shrinkWrap: true, children: [
        const Padding(padding: EdgeInsets.only(top: 10)),
        SizedBox(
          height: 400,
          width: 200,
          child: ListView.builder(
              itemCount: itemsFilted.length,
              itemBuilder: (context, index) {
                return (ListTile(
                  title: Text(
                    itemsFilted[index],
                    style: const TextStyle(fontSize: 18.0),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        iconSize: 20.0,
                        icon: const Icon(
                          Icons.update,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          showDialog(context: context, builder: 
                            (context) => AlertDialog(
                              title: const Text('Update Confirm'),
                              content: const Text("You will update all the products with this category"),
                              actions: <Widget>[
                                TextField(
                                  style: const TextStyle(color: Colors.black, fontSize: 18.0),
                                  controller: data,
                                  keyboardType: TextInputType.text,
                                  decoration: const InputDecoration(hintText: "Type the new Category"),
                                ),
                                TextButton(
                                onPressed: () {
                                  if (data.text != "") {
                                    if (items.contains(data.text)) {
                                      showEditFailed();
                                    } else {
                                      widget.onCateUpdateFinish(data.text, items[index], 'update');
                                      data.clear();
                                      Navigator.of(context).pop();
                                      showUpdateSuccess();
                                    }
                                  }
                                },
                                child: const Text('Update')),
                                TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancel'))
                              ],
                            )
                          );
                        }),
                      IconButton(
                        iconSize: 20.0,
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          showDialog(context: context, builder: 
                            (context) => AlertDialog(
                              title: const Text('Delete Confirm'),
                              content: const Text("You will Delete this category in all products"),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    widget.onCateUpdateFinish(itemsFilted[index], itemsFilted[index], 'delete');
                                    setState(() {
                                      itemsFilted.removeAt(index);
                                      items.removeAt(index);
                                      index--;
                                    });
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Delete')),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Cancel'))
                              ],
                            )
                          );
                        }),
                    ],
                  )
                ));
              }),
        ),
        Container(
          margin: const EdgeInsets.all(20.0),
          child: Row(
            textDirection: TextDirection.rtl,
            children: <Widget>[
              FloatingActionButton(
                backgroundColor: Colors.blueGrey,
                onPressed: () {
                  setState(() {
                    if (data.text != "") {
                      if (items.contains(data.text)) {
                        showEditFailed();
                      } else {
                        itemsFilted.add(data.text);
                        items.add(data.text);
                      }
                    }
                    data.clear();
                  });
                },
                child: const Icon(
                  Icons.add,
                ),
              ),
              Expanded(
                  child: TextField(
                style: const TextStyle(color: Colors.black, fontSize: 18.0),
                controller: data,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(hintText: "Add a category"),
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
                    widget.onCateAddFinish(items);
                    Navigator.of(context).pop();
                  })))),
          const Padding(padding: EdgeInsets.only(top: 10)),
          SizedBox(
            width: 30,
            height: 40,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Material(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(5),
                elevation: 6,
                child: MaterialButton(
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  })))),
      ]));
  }
}
