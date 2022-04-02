import 'package:csi5112_project/presenter/login_presenter.dart';
import 'package:csi5112_project/view/login_page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

enum Identity {merchant, client}

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);


  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _isObscure = true;
  bool _isObscureSecond = true;
  Identity? _identity;
  Identity? _selected;
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _passwordSecond = TextEditingController();
  final TextEditingController _firstname = TextEditingController();
  final TextEditingController _lastname = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  late UserListPresenter _presenter;

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
        body: Center (
          heightFactor: 1,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 8),
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
                    padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 8),
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
                    padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 8),
                    child: SizedBox(
                      width: 350,
                      child: TextField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'User Name',
                        ),
                        autofocus: true,
                        controller: _username,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 8),
                    child: SizedBox(
                      width: 350,
                      child: TextField(
                        obscureText: _isObscure,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              },
                              icon: Icon(
                                _isObscure ? Icons.visibility : Icons.visibility_off
                              )
                          ),
                        ),
                        autofocus: true,
                        controller: _password,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 8),
                    child: SizedBox(
                      width: 350,
                      child: TextField(
                        obscureText: _isObscureSecond,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Confirm your password',
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isObscureSecond = !_isObscureSecond;
                                });
                              },
                              icon: Icon(
                                  _isObscureSecond ? Icons.visibility : Icons.visibility_off
                              )
                          ),
                        ),
                        autofocus: true,
                        controller: _passwordSecond,
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
                          labelText: 'E-mail',
                        ),
                        autofocus: true,
                        controller: _email,
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
                          labelText: 'Phone',
                        ),
                        autofocus: true,
                        controller: _phone,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 8),
                    child: SizedBox(
                      width: 350,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: _selected,
                          hint: Text('You will register as:'),
                          items: [
                            DropdownMenuItem(
                                child: Text('Merchant'),
                                value: Identity.merchant
                            ),
                            DropdownMenuItem(
                                child: Text('Customer'),
                                value: Identity.client
                            )],
                          onChanged: (Identity? value) {
                            setState(() {
                              _identity = value;
                              _selected = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 8),
                    child: SizedBox(
                      width: 150,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(vertical: 20),
                        ),
                        onPressed: () {
                          if (checkField() && checkUsername()) {
                            register();
                            popUpSuccess();
                          }
                        },
                        child: const Text(
                          'Register Now',
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



  // interact with backend via http
  // TODO
  void register() {}

  // check username
  // Assumption: the username is unique
  // TODO
  bool checkUsername() {
    // popRegisterError("The username has been taken.");
    return true;
  }

  bool checkField() {
    if(checkEmptyField()) {
      popRegisterError("You must fill all fields!");
      return false;
    }

    if (!matchPassword()) {
      popRegisterError('The password does not match');
      return false;
    }

    return true;
  }


  bool checkEmptyField() {
    return _username.text == '' || _password.text == '' || _passwordSecond.text == '' ||
          _phone.text == '' || _email.text == '' || _firstname.text == '' || _lastname.text == '' || _identity == null;
  }

  bool matchPassword() {
    return _password.text == _passwordSecond.text;
  }

  void popUpSuccess() {
    showDialog(context: context,
        builder:(context) => AlertDialog(
            title: const Text('Success'),
            content: const Text('You have registered in the system successfully'),
            actions: <Widget> [
              TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: const Text('OK'))
            ]
        ));
  }

  void popRegisterError(String err) {
    showDialog(context: context,
        builder:(context) => AlertDialog(
            title: const Text('Register error'),
            content: Text(err),
            actions: <Widget> [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'))
            ]
        ));
  }

}
