import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //     title: const Center(
      //   child: Text("User", textAlign: TextAlign.center),
      // )),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: <Widget>[
              Image(image: AssetImage("images/user.png"), width: 100.0),
              Text("Hello, #username#"),
              TextButton(
                child: Text("Address"),
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
                child: Text("Orders"),
                // textColor: Colors.blue,
                onPressed: () {
                  //导航到新路由
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return OrdersPage();
                    }),
                  );
                },
              ),
              ElevatedButton(
                child: Text("Sign out"),
                onPressed: () {},
              ),
            ]),
      ),
    );
  }
}

class AddressPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Center(
        child: Text("Address"),
      )), //not centered enough in Chrome
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.start,
            // ignore: prefer_const_literals_to_create_immutables
            children: <Widget>[
              Text("#username#", textAlign: TextAlign.start),
              Text("#phonenumber#", textAlign: TextAlign.start),
              Text("#address#", textAlign: TextAlign.start)
            ]),
      ),
    );
  }
}

class OrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Center(
        child: Text("Orders", textAlign: TextAlign.center),
      )),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return InvoicePage();
                    }),
                  );
                },
              ),
            ]),
      ),
    );
  }
}

class InvoicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Center(
        child: Text("Invoice", textAlign: TextAlign.center),
      )),
    );
  }
}
