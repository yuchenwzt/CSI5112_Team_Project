import 'dart:convert';
import 'package:csi5112_project/presenter/login_presenter.dart';
import 'package:csi5112_project/data/user_data.dart';
import 'package:csi5112_project/view/register_page/register_page.dart';
import 'package:flutter/material.dart';
import '../main_page.dart';
import '../../data/http_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Identity { merchant, client }

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> implements UserListViewContract {
  Identity? _identity = Identity.merchant;
  final TextEditingController _unameController = TextEditingController();
  final TextEditingController _passwController = TextEditingController();
  late UserListPresenter _presenter;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> _setLoginToken(String token) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString('current_token', token);
  }

  _LoginState() {
    _presenter = UserListPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'UO Shopping Market',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Center(
        heightFactor: 1,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Padding(
                padding:
                    EdgeInsets.only(left: 15, right: 15, top: 40, bottom: 30),
                child: CircleAvatar(
                  radius: 90,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage("images/user2.png"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 15, bottom: 8),
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
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 10, bottom: 15),
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
                  )),
              SizedBox(
                width: 420.0,
                child: Row(
                  children: [
                    const Padding(padding: EdgeInsets.only(left: 15)),
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
                        },
                        groupValue: _identity,
                      ),
                    ),
                    const SizedBox(width: 20),
                    const Padding(padding: EdgeInsets.only(left: 40)),
                    Expanded(
                      child: RadioListTile<Identity>(
                        activeColor: Colors.blue,
                        controlAffinity: ListTileControlAffinity.leading,
                        title: const Text("Customer"),
                        value: Identity.client,
                        onChanged: (value) {
                          setState(() {
                            _identity = value;
                          });
                        },
                        groupValue: _identity,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: SizedBox(
                  width: 350,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                    ),
                    onPressed: () {
                      if (_unameController.text == '') {
                        warningEmptyUserName();
                      } else if (_passwController.text == '') {
                        warningEmptyPassword();
                      } else if (_identity == null) {
                        warningNoIdentity();
                      } else {
                        authenticateIdentity(
                            _unameController.text, _passwController.text);
                      }
                    },
                    child: const Text(
                      'Log In',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 15)),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  navigateToRegistration();
                },
                child: const Text("Don't have an account yet? Register here!"),
              )
            ],
          ),
        ),
      ),
    );
  }

  void warningNoIdentity() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
                title: const Text('Login error'),
                content: const Text(
                    'You should choose an identity before entering the system.'),
                actions: <Widget>[
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('OK'))
                ]));
  }

  void warningEmptyUserName() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
                title: const Text('Login error'),
                content: const Text('Username cannot be empty.'),
                actions: <Widget>[
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('OK'))
                ]));
  }

  void warningEmptyPassword() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
                title: const Text('Login error'),
                content: const Text('Password cannot be empty.'),
                actions: <Widget>[
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('OK'))
                ]));
  }

  void warningWrongAuthentication(e) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
                title: const Text('Login error'),
                content: const Text('UserName or Password might be wrong.'),
                actions: <Widget>[
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('OK'))
                ]));
  }

  // sent to 3rd party verification api
  void authenticateIdentity(String uname, String pwd) {
    _presenter.loadUser(HttpRequest(
        'Post',
        'token',
        jsonEncode(LoginUser(
            username: uname,
            password: pwd,
            isMerchant: _identity == Identity.merchant))));
  }

  @override
  void onLoadUserComplete(List<User> user) {
    _setLoginToken(user[0].token);

    user[0].isMerchant = _identity == Identity.merchant;
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => MainPage(user: user[0])));
  }

  @override
  void onLoadUserError(e) {
    warningWrongAuthentication(e);
  }

  void navigateToRegistration() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Register()));
  }
}
