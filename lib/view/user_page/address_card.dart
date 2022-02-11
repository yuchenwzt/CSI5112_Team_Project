import 'package:flutter/material.dart';
import '../../data/user_data.dart';

class AddressCard extends StatelessWidget {
  AddressCard({ Key? key, required this.address, this.onEditFinish }) : super(key: key);

  final Address address;
  final itemFormKey = GlobalKey<FormState>();
  final onEditFinish;

  @override
  Widget build(BuildContext context) {
    Address newAddress = address;
    return ListTile(
      leading: TextButton(
        style: ButtonStyle(padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero)),
        onPressed: () {
          showFormDialog(context, newAddress);
        },
        child: const Text("Edit"),
      ),
      title: Text(
        address.name,
        textAlign: TextAlign.center,
        style: const TextStyle(
          // color: Colors.blue,
          fontSize: 20.0,
          height: 1.2,
          fontFamily: "Courier",
        ),
      ),
      subtitle: Text(
        address.phonenumber,
        textAlign: TextAlign.center,
        style: const TextStyle(
          // color: Colors.blue,
          fontSize: 20,
          height: 1.2,
          fontFamily: "Courier",
        ),
      ),
      trailing: Text(
        address.address,
        textAlign: TextAlign.center,
        style: const TextStyle(
          // color: Colors.blue,
          fontSize: 20.0,
          height: 1.2,
          fontFamily: "Courier",
        ),
      ),
    );
  }

  void showFormDialog(BuildContext context, Address newAddress) {
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
                          labelText: 'User Name',
                        ),
                        initialValue: newAddress.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "The Name Can't be Empty";
                          }
                          return null;
                        },
                        onSaved: (newValue) => newAddress.name = newValue as String,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'User Phone Number',
                        ),
                        initialValue: newAddress.phonenumber,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "The Number Can't be Empty";
                          }
                          return null;
                        },
                        onSaved: (newValue) => newAddress.phonenumber = newValue as String,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Address',
                        ),
                        initialValue: newAddress.address,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "The Address Can't be Empty";
                          }
                          return null;
                        },
                        onSaved: (newValue) => newAddress.address = newValue as String,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ElevatedButton(
                        child: const Text("Submit"),
                        onPressed: () {
                          if (itemFormKey.currentState!.validate()) {
                            itemFormKey.currentState!.save();
                            onEditFinish(newAddress);
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