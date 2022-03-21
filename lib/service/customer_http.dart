import 'dart:async';
import 'dart:convert';
import '../data/customer_data.dart';
import '../data/http_data.dart';

class RealCustomerRepository implements CustomerRepository {
  @override
  Future<List<Customer>> fetch(HttpRequest request) async {
    var response = await useRequest(request);
    final String jsonBody = response.body;
    final statusCode = response.statusCode;
    
    if (statusCode < 200 || statusCode >= 300) {
      throw FetchDataException( "Error while getting contacts [StatusCode:$statusCode, Error:${response.toString()}]");
    }
    
    final customersContainer = jsonDecode(jsonBody);
    final List customers = customersContainer;
    return customers.map((customerRow) => Customer.fromMap(customerRow)).toList();
  }
}