import 'package:csi5112_project/data/filter_option_data.dart';
import 'package:csi5112_project/presenter/filter_option_presenter.dart';
import 'package:flutter/material.dart';
import '../../data/product_data.dart';
import '../../presenter/product_presenter.dart';
import 'product_filter_panel.dart';
import '../../components/search_bar.dart';
import '../../components/suspend_page.dart';
import '../../data/http_data.dart';
import '../../data/user_data.dart';
import 'dart:convert';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key, required this.user}) : super(key: key);
  
  final User user;

  @override
  ProductListState createState() => ProductListState();
}

class ProductListState extends State<ProductPage> implements ProductsListViewContract, FilterOptionListViewContract {
  late ProductsListPresenter _presenter;
  late FilterOptionListPresenter _presenterFilter;
  List<Product> productsReceived = [];
  List<String> filter_index = ["ascending","",""];
  List<String> filter_index_select = ["ascending","",""];
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
    _presenter.loadProducts(HttpRequest('Get', 'Products/all', {}));
  }

  void retry() {
    isSearching = true;
    _presenter.loadProducts(HttpRequest('Get', 'Products/all', {}));
  }
  
  @override
  Widget build(BuildContext context) {
    return SuspendCard(
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: SearchBar(onSearchFinish: (value) => updateProductList(inputSearch: value)),
        ),
        body: Center(
          child: ProductFilterPanel(
            products: productsReceived,
            filters: filter_index, 
            filters_select: filter_index_select,
            user: widget.user,
            onSelectFinish: (value, index) => updateFilterIndex(value, index), 
            onEditFinish: (value, type) => updateEditProduct(value, type)
          ),
        ),
      ), 
      isLoadError: isLoadError, 
      isSearching: isSearching, 
      loadError: loadError, 
      data: productsReceived,
      retry: () => retry()
    );
  }

  void updateFilterIndex(String newOption, int index) {
    setState(() {
      filter_index_select[index] = newOption;
    });
    updateProductList();
  }

  void updateProductList({
    String inputSearch = '%23',
  }) {
    String filterUrl = "";
    if (widget.user.isMerchant) {
      filterUrl = 'Products/filter/owner?owner_id=${widget.user.merchant_id}&input=$inputSearch&priceSort=${filter_index_select[0]}&location=${filter_index_select[1]}&category=${filter_index_select[2]}';
    } else {
      filterUrl = 'Products/filter?input=$inputSearch&priceSort=${filter_index_select[0]}&location=${filter_index_select[1]}&category=${filter_index_select[2]}';
    }
    _presenter.loadProducts(HttpRequest('Get', filterUrl, {}));
  }

  void updateEditProduct(Product product, String type) {
    switch (type) {
      case 'update':
        _presenter.loadProducts(HttpRequest('Put', 'Products/update?id=${product.product_id}', jsonEncode(product)));
        break; 
      case 'create':
        product.owner_id = widget.user.merchant_id;
        product.owner = widget.user.first_name + " " + widget.user.last_name;
        _presenter.loadProducts(HttpRequest('Post', 'Products/create', jsonEncode(product)));
        break;
      case 'delete':
        _presenter.loadProducts(HttpRequest('Delete', 'Products/delete', jsonEncode(product.product_id)));
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
    _presenterFilter.loadFilterOption(HttpRequest('Get', 'Products/get_filter_option', {}));
  }

  @override
  void onLoadFilterOptionComplete(FilterOption filterOption) {
    setState(() {
      filter_index = [filterOption.priceSort, filterOption.manufacturers, filterOption.categories];
      filter_index_select = [filterOption.priceSort, filterOption.manufacturers, filterOption.categories];
      isFilterSearching = false;
      isFilterLoadError = false;
    });
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
  void onLoadFilterOptionError(e) {
    setState(() {
      isFilterSearching = false;
      isFilterLoadError = true;
      loadError = e.toString();
    });
  }
}