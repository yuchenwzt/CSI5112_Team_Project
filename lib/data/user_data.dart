import 'dart:async';

class User {
  final String id;
  final String name;
  final String password;
  final bool is_merchant;
  final String phonenumber;
  final String address;
  final List cart;
  final List<List> history;

  const User({
    this.id = "",
    this.name = "",
    this.password = "",
    this.is_merchant = false,
    this.phonenumber = "",
    this.address = "",
    this.cart = const [],
    this.history = const [],
  });

  User.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        password = map['password'],
        is_merchant = map['is_merchant'],
        phonenumber = map['phonenumber'],
        address = map['address'],
        cart = map['cart'],
        history = map['history'];
}

abstract class UserRepository {
  Future<List<User>> fetch();
}

class FetchDataException implements Exception {
  String message;

  FetchDataException(this.message);

  @override
  String toString() {
    return "Exception:$message";
  }
}
