import 'dart:async';
import 'http_data.dart';

class Merchant {
  final String merchant_id;
  final String first_name;
  final String last_name;
  final String email;
  final String password;
  final String username;
  final String phone;

  Merchant.fromMap(Map<String, dynamic> map)
    : merchant_id = map['merchant_id'],
      first_name = map['first_name'],
      last_name = map['last_name'],
      email = map['email'],
      password = map['password'],
      username = map['username'],
      phone = map['phone'];
}

abstract class MerchantRepository {
  Future<List<Merchant>> fetch(HttpRequest request);
}
