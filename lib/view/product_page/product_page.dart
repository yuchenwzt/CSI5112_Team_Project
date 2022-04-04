import 'package:csi5112_project/data/filter_option_data.dart';
import 'package:csi5112_project/presenter/filter_option_presenter.dart';
import 'package:flutter/material.dart';
import '../../data/product_data.dart';
import '../../presenter/product_presenter.dart';
import 'product_filter_panel.dart';
import '../../components/search_bar.dart';
import '../../data/http_data.dart';
import '../../data/user_data.dart';
import 'dart:convert';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  ProductListState createState() => ProductListState();
}

class ProductListState extends State<ProductPage>
    implements ProductsListViewContract, FilterOptionListViewContract {
  late ProductsListPresenter _presenter;
  late FilterOptionListPresenter _presenterFilter;
  List<Product> productsReceived = [];
  List<String> filter_index = ["ascending", "", ""];
  List<String> filter_index_select = ["ascending", "", ""];
  String loadError = "";
  bool isSearching = false;
  bool isLoadError = false;
  bool isFilterSearching = false;
  bool isFilterLoadError = false;

  ProductListState() {
    _presenter = ProductsListPresenter(this);
    _presenterFilter = FilterOptionListPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    isSearching = true;
    _presenterFilter.loadFilterOption(HttpRequest(
        'Get',
        widget.user.isMerchant
            ? 'Products/get_filter_option_merchant?merchant_id=${widget.user.merchant_id}'
            : 'Products/get_filter_option',
        {}));
  }

  void retry() {
    isSearching = true;
    _presenterFilter.loadFilterOption(HttpRequest(
        'Get',
        widget.user.isMerchant
            ? 'Products/get_filter_option_merchant?merchant_id=${widget.user.merchant_id}'
            : 'Products/get_filter_option',
        {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: SearchBar(
          onSearchFinish: (value) => updateProductList(inputSearch: value),
          hintText: "Search the Product name",
        ),
      ),
      body: Provider.value(
        value: filter_index[2],
        updateShouldNotify: (oldValue, newValue) => true,
        child: Center(
          child: ProductFilterPanel(
              products: productsReceived,
              filters: filter_index,
              filters_select: filter_index_select,
              user: widget.user,
              onSelectFinish: (value, index) => updateFilterIndex(value, index),
              onEditFinish: (value, type) => updateEditProduct(value, type),
              onCateUpdateFinish: (value, origin, type) =>
                  onCateUpdateFinish(value, origin, type),
              isLoadError: isLoadError,
              isSearching: isSearching,
              loadError: loadError,
              retry: () => retry()),
        ),
      ),
    );
  }

  void onCateUpdateFinish(String value, String origin, String type) {
    String filterUrl = "";
    if (type == 'update') {
      filterUrl =
          'Products/update_category?owner_id=${widget.user.merchant_id}&category=$value&origin=$origin';
      _presenter.updateProducts(HttpRequest('Put', filterUrl, jsonEncode("")));
    } else {
      filterUrl =
          'Products/delete_category?category=$value&owner_id=${widget.user.merchant_id}';
      _presenter
          .updateProducts(HttpRequest('Delete', filterUrl, jsonEncode("")));
    }
    retry();
  }

  void updateFilterIndex(String newOption, int index) {
    setState(() {
      isSearching = true;
      filter_index_select[index] = newOption;
    });
    updateProductList();
  }

  void updateProductList({
    String inputSearch = '%23',
  }) {
    String filterUrl = "";
    if (inputSearch == "") inputSearch = "%23";
    String filterIndex1 =
        filter_index_select[1].isEmpty ? '%23' : filter_index_select[1];
    String filterIndex2 =
        filter_index_select[2].isEmpty ? '%23' : filter_index_select[2];
    if (widget.user.isMerchant) {
      filterUrl =
          'Products/filter/owner?owner_id=${widget.user.merchant_id}&input=$inputSearch&priceSort=${filter_index_select[0]}&location=$filterIndex1&category=$filterIndex2';
    } else {
      filterUrl =
          'Products/filter?input=$inputSearch&priceSort=${filter_index_select[0]}&location=$filterIndex1&category=$filterIndex2';
    }
    _presenter.loadProducts(HttpRequest('Get', filterUrl, {}));
  }

  void updateEditProduct(Product product, String type) {
    switch (type) {
      case 'update':
        _presenter.updateProducts(HttpRequest('Put',
            'Products/update?id=${product.product_id}', jsonEncode(product)));
        break;
      case 'create':
        product.owner_id = widget.user.merchant_id;
        product.owner = widget.user.first_name + " " + widget.user.last_name;
        _presenter.updateProducts(
            HttpRequest('Post', 'Products/create', jsonEncode(product)));
        break;
      case 'delete':
        _presenter.updateProducts(HttpRequest(
            'Delete', 'Products/delete', jsonEncode(product.product_id)));
        break;
    }
  }

  @override
  void onLoadProductsComplete(List<Product> products) {
    setState(() {
      productsReceived = products;
      isSearching = false;
      isLoadError = false;
    });
  }

  @override
  void onUpdateProductsComplete(List<Product> products) {
    retry();
  }

  @override
  void onLoadFilterOptionComplete(FilterOption filterOption) {
    setState(() {
      filter_index = [
        filter_index_select[0],
        filterOption.manufacturers,
        filterOption.categories
      ];
      filter_index_select = [
        filter_index_select[0],
        filterOption.manufacturers,
        filterOption.categories
      ];
      isFilterSearching = false;
      isFilterLoadError = false;
    });
    updateProductList();
  }

  @override
  void onLoadProductsError(e) {
    setState(() {
      isSearching = false;
      isLoadError = true;
      loadError = e.toString();
    });
  }

  @override
  void onUpdateProductsError(e) {
    setState(() {
      isSearching = false;
      isLoadError = true;
      loadError = e.toString();
    });
  }

  @override
  void onLoadFilterOptionError(e) {
    setState(() {
      isFilterSearching = false;
      isFilterLoadError = true;
      loadError = e.toString();
    });
  }
}
