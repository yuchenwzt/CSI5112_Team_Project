import 'package:csi5112_project/view/user/AddressPage.dart';
import 'package:csi5112_project/view/user/HistoricalordersPage.dart';
import 'package:flutter/material.dart';
import '../../data/user_data.dart';
import '../../module/user_presenter.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> implements UserListViewContract {
  late UserListPresenter _presenter;
  User _user = new User();
  _UserPageState() {
    _presenter = UserListPresenter(this);
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
              Text(
                " ",
                style: TextStyle(height: 4),
              ),
              Image(image: AssetImage("images/user.png"), width: 200.0),
              Text(
                "Hello, " + _user.name,
                style: TextStyle(fontSize: 20, height: 4),
              ),
              TextButton(
                child: Text(
                  "Address",
                  style: TextStyle(fontSize: 20),
                ),
                // textColor: Colors.blue,
                onPressed: () {
                  //导航到新路由
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return AddressPage();
                    }),
                  );
                },
              ),
              TextButton(
                child: Text(
                  "Orders",
                  style: TextStyle(fontSize: 20),
                ),
                // textColor: Colors.blue,
                onPressed: () {
                  //导航到新路由
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return HistoryPage();
                    }),
                  );
                },
              ),
              Text(
                " ",
                style: TextStyle(height: 4),
              ),
              ElevatedButton(
                child: Text(
                  "Sign out",
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {},
              ),
            ]),
      ),
    );
  }

  @override
  void onLoadUsersComplete(List<User> users) {
    setState(() {
      _user = users[0];
    });
  }

  @override
  void onLoadUsersError() {
    // TODO: implement onLoadUsersError
  }
}

class Orders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Orders"),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.start,
            // ignore: prefer_const_literals_to_create_immutables
            children: <Widget>[
              Text(
                "Apple MacBook Pro",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18.0,
                    height: 1.2,
                    fontFamily: "Courier",
                    background: Paint()..color = Colors.white,
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.dashed),
              ),
              TextButton(
                child: Text("Invoice  >"),
                onPressed: () {
                  //导航到新路由
                },
              ),
            ]),
      ),
    );
  }
}
