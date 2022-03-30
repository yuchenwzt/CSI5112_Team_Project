import 'package:flutter/material.dart';

class EditCate extends StatefulWidget {
  const EditCate({Key? key, required this.options, this.onCateEditFinish}) : super(key:key);

  final String options;

  final onCateEditFinish;
  
  @override
  EditCateState createState() => EditCateState();
}

class EditCateState extends State<EditCate> {
  List<String> items = [];
  TextEditingController data = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    items = widget.options.split('_');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
          "Edit Categories",
          textAlign: TextAlign.center,
        )),
        body: ListView(children: [
          const Padding(padding: EdgeInsets.only(top: 10)),
          SizedBox(
            height: 400,
            width: 200,
            child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return (ListTile(
                    title: Text(
                      items[index],
                      style: const TextStyle(fontSize: 18.0),
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
                            showDialog(context: context,
                            builder:(context) => AlertDialog(
                              title: const Text('Add Failed'),
                              content: const Text('The Category is already existed.'),
                              actions: <Widget> [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('OK'))
                              ]
                            ));
                          } else {
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
                        widget.onCateEditFinish(items);
                        Navigator.of(context).pop();
                      }))))
        ]));
  }
}
