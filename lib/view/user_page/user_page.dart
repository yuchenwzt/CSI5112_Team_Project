import './address_page.dart';
import './historicalorders_page.dart';
import 'package:flutter/material.dart';
import 'package:csi5112_project/data/user_data.dart';
import '../login_page/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  _UserRolePageState createState() => _UserRolePageState();
}

class _UserRolePageState extends State<UserPage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> _deleteLoginToken() async {
    final SharedPreferences prefs = await _prefs;
    prefs.remove('current_token');
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 247, 255, 0.5),
      body: Center(
        child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: <Widget>[
              const Text(
                " ",
                style: TextStyle(height: 4),
              ),
              const Image(image: AssetImage("images/user2.png"), width: 200.0),
              Text(
                "Hello, " + widget.user.first_name + " " + widget.user.last_name,
                style: const TextStyle(fontSize: 24, height: 4),
              ),
              const Padding(padding: EdgeInsets.only(top: 30)),
              TextButton(
                child: const Text(
                  "Manage My Address",
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return AddressPage(user: widget.user);
                    }),
                  );
                },
              ),
              const Padding(padding: EdgeInsets.only(top: 5)),
              TextButton(
                child: const Text(
                  " View Order Receipts",
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return HistoryOrderPage(user: widget.user);
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
                        _deleteLoginToken();
                        Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (BuildContext context) {
                                return const Login();
                              },
                            ),
                          (_) => false,
                        );
                      },
                    ),
                  ))
            ]),
      ),
    );
  }
}
