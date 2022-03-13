import 'package:flutter/material.dart';
import '../../data/product_data.dart';
import '../../presenter/product_presenter.dart';
import 'product_filter_panel.dart';
import '../../components/search_bar.dart';
import '../../components/suspend_page.dart';
import '../../data/http_data.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key, required this.isMerchant}) : super(key: key);
  
  final bool isMerchant;

  @override
  ProductListState createState() => ProductListState();
}

class ProductListState extends State<ProductPage> implements ProductsListViewContract {
  late ProductsListPresenter _presenter;
  List<Product> productsReceived = [];
  List<Product> productsFiltered = [];
  String loadError = "";
  bool isSearching = false;
  bool isLoadError = false;

  ProductListState() {
    _presenter = ProductsListPresenter(this);
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
          flexibleSpace: SearchBar(searchProducts: productsReceived, filterType: "product", onSearchFinish: (value) => updateProductList(value)),
        ),
        body: Center(
          child: ProductFilterPanel(
            products: productsFiltered,
            originProducts: productsReceived, 
            isMerchant: widget.isMerchant,
            onSelectFinish: (value) => updateProductList(value), 
            onEditFinish: (value) => updateEditProduct(value)
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

  @override
  void onLoadProductsComplete(List<Product> products) {
    setState(() {
      productsReceived = products;
      productsFiltered = products;
      isSearching = false;
      isLoadError = false;
    });
  }

  void updateProductList(List<Product> products) {
    setState(() {
      productsFiltered = products;
    });
  }

  // mock update func, deleted when build up backend
  void updateEditProduct(Product product) {
    var newProduct = productsFiltered;
    if (newProduct.contains(product)) {
      newProduct[newProduct.indexOf(product)] = product;
    } else {
      newProduct.add(product);
    }
    
    setState(() {
      productsFiltered = newProduct;
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
}