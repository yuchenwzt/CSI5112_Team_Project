import './address_page.dart';
import './historicalorders_page.dart';
import 'package:flutter/material.dart';
import '../../../../data/user_data.dart';
import '../../../../presenter/user_presenter.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> implements UserViewContract {
  late UserPresenter _presenter;
  User user = User();
  _UserPageState() {
    _presenter = UserPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _presenter.loadUsers();
  }

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
                "Hello, " + user.name,
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
                      return AddressPage(user: user, onEditFinish: (value) => updateUserAddress(value),);
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
                      return HistoryPage(user: user);
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
  void updateUserAddress(Address newAddress) {
    var newUser = user;
    user.address[0] = newAddress;
    setState(() {
      user = newUser;
    });
  }

  @override
  void onLoadUsersComplete(User userReceived) {
    setState(() {
      user = userReceived;
    });
  }

  @override
  void onLoadUsersError() {
    // TODO: implement onLoadUsersError
  }
}
