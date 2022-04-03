import 'package:csi5112_project/data/cart_product.dart';
import 'package:csi5112_project/injection/dependency_injection.dart';
import '../data/http_data.dart';

abstract class CartProductsListViewContract {
  void onLoadCartProductsComplete(List<CartProduct> items);

  void onLoadCartProductsError(onError);
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
}
