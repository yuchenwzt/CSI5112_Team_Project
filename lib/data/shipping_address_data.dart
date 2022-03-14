import 'dart:async';
import 'http_data.dart';

class ShippingAddress {
  String shipping_address_id;
  String address;
  String city;
  String state;
  String zipcode;
  String country;
  String user_id;
  
  ShippingAddress( {
    this.shipping_address_id = "",
    this.address = "",
    this.city = "",
    this.state = "",
    this.zipcode = "",
    this.country = "",
    this.user_id = "",
  });

  ShippingAddress.fromMap(Map<String, dynamic> map)
    : shipping_address_id = map['shipping_address_id'],
      address = map['address'],
      city = map['city'],
      state = map['state'],
      zipcode = map['zipcode'],
      country = map['country'],
      user_id = map['user_id'];
}

abstract class ShippingAddressRepository {
  Future<List<ShippingAddress>> fetch(HttpRequest request);
}
