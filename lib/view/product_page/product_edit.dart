import 'package:flutter/material.dart';
import '../../data/product_data.dart';
import 'package:intl/intl.dart';
import 'package:image_picker_web/image_picker_web.dart';

class ProductEdit extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProductEditState();

  const ProductEdit(
      {Key? key,
      required this.product,
      this.onEditFinish,
      required this.filters_dropdown_list,
      required this.editRole})
      : super(key: key);

  final Product product;
  final String editRole;
  final String filters_dropdown_list;
  final onEditFinish;
}

class ProductEditState extends State<ProductEdit> {
  final productFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Product newProduct = widget.product;
    return widget.editRole == "edit"
        ? Row(children: [
            TextButton(
                style: ButtonStyle(
                    padding:
                        MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero)),
                onPressed: () {
                  showFormDialog(context, newProduct, 'update');
                },
                child: const Text("Edit")),
            TextButton(
                style: ButtonStyle(
                    padding:
                        MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero)),
                onPressed: () {
                  widget.onEditFinish(newProduct, 'delete');
                },
                child: const Text("Delete")),
          ])
        : FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              showFormDialog(context, newProduct, 'create');
            },
          );
  }

  Future<List<String>> _getImgInfo() async {
    List<String> res = List<String>.filled(2, "");
    final infos = await ImagePickerWeb.getImageInfo;
    res[0] = infos.fileName as String;
    res[1] = infos.base64 as String;
    return res;
  }

  List<DropdownMenuItem> showAllFilter(String filters_dropdown_list) {
    List<String> list = filters_dropdown_list.split("_");
    return list.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList();
  }

  void showFormDialog(BuildContext context, Product newProduct, String type) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          String imageInfo = "";
          String image_type = "network";
          return StatefulBuilder(builder: (context, state) {
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
                            onSaved: (newValue) =>
                                newProduct.name = newValue as String,
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
                            onSaved: (newValue) =>
                                newProduct.description = newValue as String,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: DropdownButtonFormField<dynamic>(
                              decoration: const InputDecoration(
                                labelText: 'Category',
                              ),
                              value: type == 'create' ? widget.filters_dropdown_list.split('_')[0] : widget.product.category,
                              items: showAllFilter(widget.filters_dropdown_list),
                              onChanged: (newValue) {
                                setState(() {
                                  newProduct.category = newValue as String;
                                });
                              }),
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
                            initialValue:
                                DateFormat('yyyy-MM-dd').format(DateTime.now()),
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
                            onSaved: (newValue) => newProduct.price =
                                int.parse(newValue as String),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Manufacturer',
                            ),
                            initialValue: widget.product.manufacturer,
                            onSaved: (newValue) =>
                                newProduct.manufacturer = newValue as String,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Image',
                              hintText: image_type == "local"
                                  ? "You can upload an image"
                                  : "Enter a network image url",
                            ),
                            initialValue: widget.product.image,
                            readOnly: image_type == "local",
                            onChanged: (newValue) =>
                                newProduct.image = newValue,
                          ),
                        ),
                        SizedBox(
                          width: 420.0,
                          child: Row(
                            children: [
                              Expanded(
                                child: RadioListTile<String>(
                                    activeColor: Colors.blue,
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    title: const Text("Network"),
                                    value: image_type,
                                    onChanged: (String? value) {
                                      state(() {
                                        image_type = "network";
                                      });
                                    },
                                    groupValue: "network"),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: RadioListTile<String>(
                                    activeColor: Colors.blue,
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    title: const Text("Local"),
                                    value: image_type,
                                    onChanged: (value) {
                                      state(() {
                                        image_type = "local";
                                      });
                                    },
                                    groupValue: "local"),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                            visible: image_type == 'local',
                            child: Row(
                              children: <Widget>[
                                ButtonBar(
                                  alignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    ElevatedButton(
                                      onPressed: () async {
                                        List<String> res = await _getImgInfo();
                                        newProduct.image = res[1];
                                        state(() {
                                          imageInfo = res[0];
                                        });
                                      },
                                      child: const Text('Select Upload Image'),
                                    ),
                                  ],
                                ),
                                Text(imageInfo != ""
                                    ? "You have successfully upload: " +
                                        imageInfo
                                    : ""),
                              ],
                            )),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ElevatedButton(
                            child: const Text("Submit"),
                            onPressed: () {
                              if (productFormKey.currentState!.validate()) {
                                productFormKey.currentState!.save();
                                newProduct.category = newProduct.category == '' ? 'null' : newProduct.category;
                                newProduct.image_type = image_type;
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
          });
        });
  }
}
