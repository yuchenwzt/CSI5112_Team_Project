import './address_page.dart';
import './historicalorders_page.dart';
import 'package:flutter/material.dart';
import '../../data/shipping_address_data.dart';

class UserRolePage extends StatefulWidget {
  const UserRolePage({Key? key, required this.user}) : super(key: key);
  final dynamic user;

  @override
  _UserRolePageState createState() => _UserRolePageState();
}

class _UserRolePageState extends State<UserRolePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: <Widget>[
              const Text(
                " ",
                style: TextStyle(height: 4),
              ),
              const Image(image: AssetImage("images/user.png"), width: 200.0),
              Text(
                "Hello, " + widget.user.name,
                style: const TextStyle(fontSize: 20, height: 4),
              ),
              TextButton(
                child: const Text(
                  "Manage My Address",
                  style: TextStyle(fontSize: 20),
                ),
                // textColor: Colors.blue,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return AddressPage(user: widget.user, onEditFinish: (value) => updateUserAddress(value));
                    }),
                  );
                },
              ),
              TextButton(
                child: const Text(
                  " View Orders Receipts",
                  style: TextStyle(fontSize: 20),
                ),
                // textColor: Colors.blue,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return HistoryPage(user: widget.user);
                    }),
                  );
                },
              ),
              const Text(
                " ",
                style: TextStyle(height: 4),
              ),
              ElevatedButton(
                child: const Text(
                  "Sign out",
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {},
              ),
            ]),
      ),
    );
  }

  // mock update func, deleted when build up backend
  void updateUserAddress(ShippingAddress newAddress) {
    var newUser = widget.user;
    widget.user.address[0] = newAddress;
  }
}
