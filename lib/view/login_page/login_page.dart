import 'package:flutter/material.dart';
import '../main_page.dart';

enum Identity {merchant, client}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Identity? _identity;
  final TextEditingController _unameController = TextEditingController();
  final TextEditingController _passwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'User',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Center (
        heightFactor: 1,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 30),
                child: CircleAvatar(
                  radius: 90,
                  backgroundImage: NetworkImage('https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/271deea8-e28c-41a3-aaf5-2913f5f48be6/de7834s-6515bd40-8b2c-4dc6-a843-5ac1a95a8b55.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7InBhdGgiOiJcL2ZcLzI3MWRlZWE4LWUyOGMtNDFhMy1hYWY1LTI5MTNmNWY0OGJlNlwvZGU3ODM0cy02NTE1YmQ0MC04YjJjLTRkYzYtYTg0My01YWMxYTk1YThiNTUuanBnIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmZpbGUuZG93bmxvYWQiXX0.BopkDn1ptIwbmcKHdAOlYHyAOOACXW0Zfgbs0-6BY-E',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 8),
                child: SizedBox(
                  width: 350,
                  child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                    ),
                    autofocus: true,
                    controller: _unameController,
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 15),
                  child: SizedBox(
                    width: 350,
                    child: TextField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                      autofocus: true,
                      controller: _passwController,
                    ),
                  )
              ),
              SizedBox(
                width: 420.0,
                child: Row(
                  children: [
                    Expanded(
                      child: RadioListTile<Identity>(
                        activeColor: Colors.blue,
                        controlAffinity: ListTileControlAffinity.leading,
                        title: const Text("Merchant"),
                        value: Identity.merchant,
                        onChanged: (Identity? value) {
                          setState(() {
                            _identity = value;
                          });
                        }, groupValue: _identity,),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: RadioListTile<Identity>(
                        activeColor: Colors.blue,
                        controlAffinity: ListTileControlAffinity.leading,
                        title: const Text("Client"),
                        value: Identity.client,
                        onChanged: (value) {
                          setState(() {
                            _identity = value;
                          });
                        }, groupValue: _identity,),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SizedBox(
                  width: 350,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                    ),
                    onPressed: () {
                      if (_unameController.text == '') {
                        warningEmptyUserName();
                      } else if (_passwController.text == '') {
                        warningEmptyPassword();
                      } else if (_identity == null) {
                        warningNoIdentity();
                      } else if (authenticateIdentity(_unameController.text, _passwController.text)) {
                        if (_identity == Identity.client) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const MainPage(isMerchant: false)));
                        } else {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const MainPage(isMerchant: true)));
                        }
                      }
                    },
                    child: const Text(
                      'Log In',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void warningNoIdentity() {
    showDialog(context: context,
        builder:(context) => AlertDialog(
          title: const Text('Login error'),
          content: const Text('You should choose an identity before entering the system.'),
          actions: <Widget> [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'))
          ]
        ));
  }

  void warningEmptyUserName() {
    showDialog(context: context,
        builder:(context) => AlertDialog(
            title: const Text('Login error'),
            content: const Text('Username cannot be empty.'),
            actions: <Widget> [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'))
            ]
        ));
  }

  void warningEmptyPassword() {
    showDialog(context: context,
        builder:(context) => AlertDialog(
            title: const Text('Login error'),
            content: const Text('Password cannot be empty.'),
            actions: <Widget> [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'))
            ]
        ));
  }

  // sent to 3rd party verification api
  bool authenticateIdentity(String uname, String pwd) {
    return true;
  }
}