import 'dart:async';
import 'dart:convert';
import '../data/order_data.dart';
import '../data/http_data.dart';

class RealOrderRepository implements OrderRepository {
  @override
  Future<List<OrderDetail>> fetch(HttpRequest request) async {
    var response = await useRequest(request);
    final String jsonBody = response.body;
    final statusCode = response.statusCode;
    
    if (statusCode < 200 || statusCode >= 300) {
      throw FetchDataException( "Error while getting contacts [StatusCode:$statusCode, Error:${response.toString()}]");
    }
    
    final ordersContainer = jsonDecode(jsonBody);
    final List orders = ordersContainer;
    return orders.map((orderRow) => OrderDetail.fromMap(orderRow)).toList();
  }
}