import 'dart:async';
import 'dart:convert';
import '../data/merchant_data.dart';
import '../data/http_data.dart';

class RealMerchantRepository implements MerchantRepository {
  @override
  Future<List<Merchant>> fetch(HttpRequest request) async {
    var response = await useRequest(request);
    final String jsonBody = response.body;
    final statusCode = response.statusCode;
    
    if (statusCode < 200 || statusCode >= 300) {
      throw FetchDataException( "Error while getting contacts [StatusCode:$statusCode, Error:${response.toString()}]");
    }
    
    final merchantsContainer = jsonDecode(jsonBody);
    final List merchants = merchantsContainer;
    return merchants.map((merchantRow) => Merchant.fromMap(merchantRow)).toList();
  }
}