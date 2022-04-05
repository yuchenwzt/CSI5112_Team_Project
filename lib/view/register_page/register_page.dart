import 'dart:async';
import 'package:csi5112_project/view/login_page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:csi5112_project/presenter/register_presenter.dart';
import 'package:csi5112_project/data/user_data.dart';
import '../../data/http_data.dart';
import 'dart:convert';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register>
    implements UserRegisterListViewContract {
  bool _isObscure = true;
  bool _isObscureSecond = true;
  bool userNameExisted = false;
  bool isChecking = false;
  String _selected = 'Merchant';
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _passwordSecond = TextEditingController();
  final TextEditingController _firstname = TextEditingController();
  final TextEditingController _lastname = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  late UserRegisterListPresenter _presenter;

  Duration durationTime = const Duration(seconds: 1);
  Timer timer = Timer(const Duration(seconds: 1), () {});

  @override
  void dispose() {
    _username.clear();
    timer.cancel();
    super.dispose();
  }

  _RegisterState() {
    _presenter = UserRegisterListPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sign up',
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
              Padding(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 30, bottom: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'You will register as:',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      const Padding(padding: EdgeInsets.only(left: 20)),
                      SizedBox(
                        width: 100,
                        child: DropdownButton(
                          elevation: 3,
                          value: _selected,
                          items: const [
                            DropdownMenuItem(
                                child: Text('Merchant'), value: 'Merchant'),
                            DropdownMenuItem(
                                child: Text('Customer'), value: 'Customer')
                          ],
                          onChanged: (String? value) {
                            setState(() {
                              _selected = value as String;
                            });
                          },
                        ),
                      ),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 15, bottom: 8),
                child: SizedBox(
                  width: 350,
                  child: Column(
                    children: <Widget>[
                      TextField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'User Name',
                        ),
                        autofocus: true,
                        controller: _username,
                        onChanged: (String text) {
                          debounceCheck(text);
                        },
                      ),
                      Visibility(
                          visible: isChecking,
                          child: Row(
                            children: [
                              LoadingAnimationWidget.prograssiveDots(color: Colors.blue, size: 20),
                              const Text("  Checking Username"),
                            ],
                          )),
                      Visibility(
                          visible: !isChecking && userNameExisted,
                          child: Row(
                            children: const [
                              Icon(Icons.error_outline, color: Colors.red,),
                              Text("  This username is already existed"),
                            ],
                          )
                      ),
                      Visibility(
                          visible: !isChecking &&
                              _username.text.isNotEmpty &&
                              !userNameExisted,
                          child: Row(
                            children: const [
                              Icon(Icons.cloud_done_outlined, color: Colors.green,),
                              Text("  This username is valid"),
                            ],
                          ),
                      )
                    ],
                  ),
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
                      labelText: 'First Name',
                    ),
                    autofocus: true,
                    controller: _firstname,
                  ),
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
                      labelText: 'Last Name',
                    ),
                    autofocus: true,
                    controller: _lastname,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 15, bottom: 8),
                child: SizedBox(
                  width: 350,
                  child: TextField(
                    obscureText: _isObscure,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Password',
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                          icon: Icon(_isObscure
                              ? Icons.visibility
                              : Icons.visibility_off)),
                    ),
                    autofocus: true,
                    controller: _password,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 15, bottom: 8),
                child: SizedBox(
                  width: 350,
                  child: TextField(
                    obscureText: _isObscureSecond,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Confirm your password',
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isObscureSecond = !_isObscureSecond;
                            });
                          },
                          icon: Icon(_isObscureSecond
                              ? Icons.visibility
                              : Icons.visibility_off)),
                    ),
                    autofocus: true,
                    controller: _passwordSecond,
                  ),
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
                      labelText: 'E-mail',
                    ),
                    autofocus: true,
                    controller: _email,
                  ),
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
                      labelText: 'Phone',
                    ),
                    autofocus: true,
                    controller: _phone,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 15, bottom: 8),
                child: SizedBox(
                  width: 150,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                    ),
                    onPressed: () {
                      if (checkField()) {
                        _presenter.loadUser(HttpRequest(
                            'Post',
                            'Register',
                            jsonEncode(RegisterUser(
                              first_name: _firstname.text,
                              last_name: _lastname.text,
                              username: _username.text,
                              phone: _phone.text,
                              email: _email.text,
                              password: _password.text,
                              isMerchant: _selected == 'Merchant',
                            ))));
                      }
                    },
                    child: const Text(
                      'Register Now',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
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

  void debounceCheck(String text) {
    timer.cancel();
    setState(() {
      isChecking = true;
      timer = Timer(const Duration(seconds: 1), () {
        String input = text == "" ? '%23' : text;
        _presenter.checkUser(
            HttpRequest('Get', 'Register?username=$input&role=$_selected', {}));
      });
    });
  }

  bool checkField() {
    if (checkEmptyField()) {
      popRegisterError("You must fill all fields!");
      return false;
    }

    if (!matchPassword()) {
      popRegisterError('The password does not match');
      return false;
    }

    if (userNameExisted) {
      popRegisterError('The User Name should be unique');
      return false;
    }

    return true;
  }

  bool checkEmptyField() {
    return _username.text == '' ||
        _password.text == '' ||
        _passwordSecond.text == '' ||
        _phone.text == '' ||
        _email.text == '' ||
        _firstname.text == '' ||
        _lastname.text == '';
  }

  bool matchPassword() {
    return _password.text == _passwordSecond.text;
  }

  void popUpSuccess() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
                title: const Text('Success'),
                content: const Text(
                    'You have registered in the system successfully'),
                actions: <Widget>[
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()));
                      },
                      child: const Text('OK'))
                ]));
  }

  void popRegisterError(String err) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
                title: const Text('Register error'),
                content: Text(err),
                actions: <Widget>[
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('OK'))
                ]));
  }

  @override
  void onLoadUserRegisterComplete(List<User> user) {
    popUpSuccess();
  }

  @override
  void onLoadUserRegisterCheck(bool valid) {
    setState(() {
      userNameExisted = valid;
      isChecking = false;
    });
  }
}
