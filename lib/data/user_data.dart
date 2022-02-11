import 'dart:async';

class Address {
  String name;
  String phonenumber;
  String address;

  Address({
    this.name = "",
    this.address = "",
    this.phonenumber = "",
  });
}

class User {
  final String id;
  final String name;
  final String password;
  final bool isMerchant;
  final String phonenumber;
  List<Address> address;
  final List cart;
  final List<List> history;

  User({
    this.id = "",
    this.name = "",
    this.password = "",
    this.isMerchant = false,
    this.phonenumber = "",
    this.address = const [],
    this.cart = const [],
    this.history = const [],
  });

  User.fromMap(Map<String, dynamic> map)
    : id = map['id'],
      name = map['name'],
      password = map['password'],
      isMerchant = map['isMerchant'],
      phonenumber = map['phonenumber'],
      address = map['address'],
      cart = map['cart'],
      history = map['history'];
}

abstract class UserRepository {
  Future<User> fetch();
}

class FetchDataException implements Exception {
  String message;

  FetchDataException(this.message);

  @override
  String toString() {
    return "Exception:$message";
  }
}
