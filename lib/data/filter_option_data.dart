import 'dart:async';
import 'http_data.dart';

class FilterOption {
  final String priceSort;
  final String categories;
  final String manufacturers;

  FilterOption( {
    this.priceSort = "ascending",
    this.categories = "",
    this.manufacturers = ""
  });

  FilterOption.fromMap(Map<String, dynamic> map)
    : priceSort = map['priceSort'],
      categories = map['categories'],
      manufacturers = map['manufacturers'];
}

abstract class FilterOptionRepository {
  Future<FilterOption> fetch(HttpRequest request);
}
