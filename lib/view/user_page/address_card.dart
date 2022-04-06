import 'package:flutter/material.dart';
import '../../data/shipping_address_data.dart';

class AddressCard extends StatefulWidget {
  const AddressCard({Key? key, required this.address, this.onEditFinish})
      : super(key: key);

  final onEditFinish;
  final ShippingAddress address;

  @override
  State<StatefulWidget> createState() => AddressCardState();
}

class AddressCardState extends State<AddressCard> {
  final itemFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ShippingAddress newAddress = widget.address;
    return ListTile(
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            iconSize: 20.0,
            icon: const Icon(
              Icons.update,
              color: Colors.red,
            ),
            onPressed: () {
              showFormDialog(context, newAddress, 'update');
            },
          ),
          const Padding(padding: EdgeInsets.only(left: 20)),
          IconButton(
            iconSize: 20.0,
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () {
              widget.onEditFinish(newAddress, 'delete');
            },
          )
        ],
      ),
      title: Text(
        widget.address.address,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 18.0,
          height: 1.2,
          fontFamily: "Courier",
        ),
      ),
      subtitle: Text(
        widget.address.city +
            " " +
            widget.address.state +
            " " +
            widget.address.country,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 18,
            height: 1.2,
            fontFamily: "Courier",
            color: Colors.grey),
      ),
      trailing: Text(
        widget.address.zipcode,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 16.0,
          height: 1.2,
          fontFamily: "Courier",
        ),
      ),
    );
  }

  void showFormDialog(
      BuildContext context, ShippingAddress newAddress, String type) {
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
                  key: itemFormKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'address',
                          ),
                          initialValue: newAddress.address,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "The address Can't be Empty";
                            }
                            return null;
                          },
                          onSaved: (newValue) =>
                              newAddress.address = newValue as String,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'City',
                          ),
                          initialValue: newAddress.city,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "The City Can't be Empty";
                            }
                            return null;
                          },
                          onSaved: (newValue) =>
                              newAddress.city = newValue as String,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'State',
                          ),
                          initialValue: newAddress.state,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "The State Can't be Empty";
                            }
                            return null;
                          },
                          onSaved: (newValue) =>
                              newAddress.state = newValue as String,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Country',
                          ),
                          initialValue: newAddress.country,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "The Country Can't be Empty";
                            }
                            return null;
                          },
                          onSaved: (newValue) =>
                              newAddress.country = newValue as String,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Zipcode',
                          ),
                          initialValue: newAddress.zipcode,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "The Zipcode Can't be Empty";
                            }
                            return null;
                          },
                          onSaved: (newValue) =>
                              newAddress.zipcode = newValue as String,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ElevatedButton(
                          child: const Text("Submit"),
                          onPressed: () {
                            if (itemFormKey.currentState!.validate()) {
                              itemFormKey.currentState!.save();
                              widget.onEditFinish(newAddress, type);
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
  }
}
