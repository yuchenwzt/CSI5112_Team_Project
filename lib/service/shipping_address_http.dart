import 'dart:async';
import 'dart:convert';
import '../data/shipping_address_data.dart';
import '../data/http_data.dart';

class RealShippingAddressRepository implements ShippingAddressRepository {
  @override
  Future<List<ShippingAddress>> fetch(HttpRequest request) async {
    var response = await useRequest(request);
    final String jsonBody = response.body;
    final statusCode = response.statusCode;
    
    if (statusCode < 200 || statusCode >= 300) {
      throw FetchDataException( "Error while getting contacts [StatusCode:$statusCode, Error:${response.toString()}]");
    }
    
    final shippingAddressContainer = jsonDecode(jsonBody);
    final List shippingAddress = shippingAddressContainer;
    return shippingAddress.map((shippingAddressRow) => ShippingAddress.fromMap(shippingAddressRow)).toList();
  }
}