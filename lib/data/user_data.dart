import 'http_data.dart';

class User {
  final String first_name;
  final String last_name;
  final String email;
  final String username;
  final String password;
  final String phone;
  final String merchant_id;
  final String customer_id;
  bool isMerchant;
  final String token;

  User({
    this.customer_id = "",
    this.merchant_id = "",
    this.first_name = "",
    this.last_name = "",
    this.email = "",
    this.password = "",
    this.username = "",
    this.phone = "",
    this.isMerchant = true,
    this.token = ""
  });

  User.fromMap(Map<String, dynamic> map) 
    : first_name = map["first_name"],
      last_name = map["last_name"],
      email = map["email"],
      password = map["password"],
      username = map["username"],
      phone = map["phone"],
      isMerchant = true,
      customer_id = map["customer_id"] ?? "",
      merchant_id = map["merchant_id"] ?? "",
      token = map["token"];
}

abstract class UserRepository{
  Future<List<User>> fetch(HttpRequest request);
  Future<bool> check(HttpRequest request);
}

class LoginUser {
  final String username;
  String password;
  bool isMerchant;

  LoginUser( {
    this.username = "",
    this.password = "",
    this.isMerchant = true
  });

  Map<String, dynamic> toJson() {
    return {
      'Username': username,
      'Password': password,
      'isMerchant': isMerchant,
    };
  }
}

class RegisterUser {
  final String username;
  String first_name;
  String last_name;
  String phone;
  String email;
  String password;
  bool isMerchant;

  RegisterUser({
    this.username = "",
    this.first_name = "",
    this.isMerchant = true,
    this.last_name = "",
    this.phone = "",
    this.email = "",
    this.password = ""
  });
  
  Map<String, dynamic> toJson() {
    return {
      'Username': username,
      'first_name': first_name,
      'isMerchant': isMerchant,
      'last_name': last_name,
      'phone': phone,
      'email': email,
      'password': password,
    };
  }
}