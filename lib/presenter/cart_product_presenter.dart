import 'package:csi5112_project/data/cart_product.dart';
import 'package:csi5112_project/injection/dependency_injection.dart';
import '../data/http_data.dart';

abstract class CartProductsListViewContract {
  void onLoadCartProductsComplete(List<CartProduct> items);

  void onLoadCartProductsError(onError);

  void onInitCartProductsComplete(List<CartProduct> items);

  void onInitCartProductsError(onError);

  void onPlaceOrderComplete(Message e);

  void onPlaceOrderError(onError);
}

class CartProductsListPresenter {
  CartProductsListViewContract view;
  late CartProductRepository repository;

  CartProductsListPresenter(this.view) {
    repository = Injector().cartProductRepository;
  }

  void loadCartProducts(HttpRequest request) {
    repository
        .fetch(request)
        .then((items) => view.onLoadCartProductsComplete(items))
        .catchError((onError) => view.onLoadCartProductsError(onError));
  }

  void initCartProducts(HttpRequest request) {
    repository
        .fetch(request)
        .then((items) => view.onInitCartProductsComplete(items))
        .catchError((onError) => view.onInitCartProductsError(onError));
  }

  void placeOrder(HttpRequest request) {
    repository
        .fetch2(request)
        .then((e) => view.onPlaceOrderComplete(e))
        .catchError((onError) => view.onPlaceOrderError(onError));
  }
}
