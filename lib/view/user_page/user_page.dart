import './address_page.dart';
import './historicalorders_page.dart';
import 'package:flutter/material.dart';
import 'package:csi5112_project/data/user_data.dart';
import '../../data/shipping_address_data.dart';
import '../login_page/login_page.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  _UserRolePageState createState() => _UserRolePageState();
}

class _UserRolePageState extends State<UserPage> {
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
                "Hello, " + widget.user.first_name + " " + widget.user.last_name,
                style: const TextStyle(fontSize: 20, height: 4),
              ),
              const Padding(padding: EdgeInsets.only(top: 30)),
              TextButton(
                child: const Text(
                  "Manage My Address",
                  style: TextStyle(fontSize: 18),
                ),
                // textColor: Colors.blue,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return AddressPage(
                          user: widget.user,
                          onEditFinish: (value) => updateUserAddress(value));
                    }),
                  );
                },
              ),
              const Padding(padding: EdgeInsets.only(top: 5)),
              TextButton(
                child: const Text(
                  " View Orders Receipts",
                  style: TextStyle(fontSize: 18),
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
              //const Padding(padding: EdgeInsets.only(top: 5)),
              SizedBox(
                  width: 200,
                  height: 40,
                  child: Material(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(5),
                    elevation: 6,
                    child: MaterialButton(
                      child: const Text(
                        'Log out',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.popUntil(context, (route) => route is Login);
                      },
                    ),
                  ))
            ]),
      ),
    );
  }

  // mock update func, deleted when build up backend
  void updateUserAddress(ShippingAddress newAddress) {
    var newUser = widget.user;
  }
}
