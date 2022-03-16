import 'dart:typed_data';

import 'package:flutter/material.dart';
import '../../data/product_data.dart';
import 'package:intl/intl.dart';
import 'package:image_picker_web/image_picker_web.dart';

class ProductEdit extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProductEditState();

  const ProductEdit({ Key? key, required this.product, this.onEditFinish, required this.editRole }) : super(key: key);

  final Product product; 
  final String editRole;
  final onEditFinish;
}

class ProductEditState extends State<ProductEdit> {
  
  final productFormKey = GlobalKey<FormState>();
  final pickedImages = <Image>[];
  String imageInfo = "";
  String imageName = "";

  @override
  Widget build(BuildContext context) {
    Product newProduct = widget.product;
    return widget.editRole == "edit" ? Row(
      children: [
        TextButton(
          style: ButtonStyle(padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero)),
          onPressed: () {
            showFormDialog(context, newProduct, 'update');
          },
          child: const Text("Edit")
        ),
        TextButton(
          style: ButtonStyle(padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero)),
          onPressed: () {
            widget.onEditFinish(newProduct, 'delete');
          },
          child: const Text("Delete")
        ),
      ]
    ) : FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: (){
        showFormDialog(context, newProduct, 'create');
      },
    );
  }

  Future<void> _getImgInfo() async {
    final infos = await ImagePickerWeb.getImageInfo;
    setState(() {
      pickedImages.clear();
      pickedImages.add(Image.memory(
        infos.data ?? Uint8List.fromList([]),
        semanticLabel: infos.fileName,
      ));
      imageInfo = '${infos.toJson()}';
      imageName = infos.fileName ?? "";
    });
  }

  void test() {
    print(imageInfo);
  }

  void showFormDialog(BuildContext context, Product newProduct, String type) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          content: Stack(
            clipBehavior: Clip.antiAlias,
            children: <Widget>[
              Positioned(
                right: -40.0,
                top: -40.0,
                child: InkResponse(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const CircleAvatar(
                    child: Icon(Icons.close),
                    backgroundColor: Colors.red,
                  ),
                ),
              ),
              Form(
                key: productFormKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Name',
                        ),
                        initialValue: widget.product.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "The Name Can't be Empty";
                          }
                          return null;
                        },
                        onSaved: (newValue) => newProduct.name = newValue as String,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Description',
                        ),
                        initialValue: widget.product.description,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "The Description Can't be Empty";
                          }
                          return null;
                        },
                        onSaved: (newValue) => newProduct.description = newValue as String,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Category',
                        ),
                        initialValue: widget.product.category,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "The Category Can't be Empty";
                          }
                          return null;
                        },
                        onSaved: (newValue) => newProduct.category = newValue as String,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Product_ID',
                          hintText: "Will be generated by system",
                        ),
                        initialValue: "",
                        readOnly: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Date',
                        ),
                        initialValue: DateFormat('yyyy-MM-dd').format(DateTime.now()),
                        readOnly: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Price',
                        ),
                        initialValue: widget.product.price.toString(),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "The Price Can't be Empty";
                          } else if (int.parse(value) < 0) {
                            return "The Price Should Large Than 0";
                          }
                          return null;
                        },
                        onSaved: (newValue) => newProduct.price = int.parse(newValue as String),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Manufacturer',
                        ),
                        initialValue: widget.product.manufacturer,
                        onSaved: (newValue) => newProduct.manufacturer = newValue as String,
                      ),
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: _getImgInfo,
                          child: const Text('Select Upload Image'),
                        ),
                        ElevatedButton(
                          onPressed: test,
                          child: const Text('test'),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ElevatedButton(
                        child: const Text("Submit"),
                        onPressed: () {
                          if (productFormKey.currentState!.validate()) {
                            productFormKey.currentState!.save();
                            widget.onEditFinish(newProduct, type);
                            Navigator.pop(context);
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}

