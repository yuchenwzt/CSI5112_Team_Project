import 'dart:async';
import 'dart:convert';
import '../data/http_data.dart';
import 'package:csi5112_project/data/cart_product.dart';

class RealCartProductRepository implements CartProductRepository {
  @override
  Future<List<CartProduct>> fetch(HttpRequest request) async {
    var response = await useRequest(request);
    final String jsonBody = response.body;
    final statusCode = response.statusCode;

    if (statusCode < 200 || statusCode >= 300) {
      throw FetchDataException(
          "Error while getting contacts [StatusCode:$statusCode, Error:${response.toString()}]");
    }

    final cartProductContainer = jsonDecode(jsonBody);
    final List cartProduct = cartProductContainer;
    return cartProduct
        .map((cartProductRow) => CartProduct.fromMap(cartProductRow))
        .toList();
  }

  @override
  Future<Message> fetch2(HttpRequest request) async {
    var response = await useRequest(request);
    final String jsonBody = response.body;
    final statusCode = response.statusCode;

    if (statusCode < 200 || statusCode >= 300) {
      throw FetchDataException(
          "Error while getting contacts [StatusCode:$statusCode, Error:${response.toString()}]");
    }

    final cartProductContainer = jsonDecode(jsonBody);
    return Message.fromMap(cartProductContainer);
  }
}
