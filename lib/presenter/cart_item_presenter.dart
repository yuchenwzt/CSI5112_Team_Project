import 'package:csi5112_project/data/cart_item_data.dart';
import 'package:csi5112_project/injection/dependency_injection.dart';
import '../data/http_data.dart';

abstract class CartItemsListViewContract {
  void onLoadCartItemsComplete(List<CartItem> items);

  void onLoadCartItemsError(onError);
}

class CartItemsListPresenter {
  CartItemsListViewContract view;
  late CartItemRepository repository;

  CartItemsListPresenter(this.view) {
    repository = Injector().cartItemRepository;
  }

  void loadItems(HttpRequest request) {
    repository
      .fetch(request)
      .then((items) => view.onLoadCartItemsComplete(items))
      .catchError((onError) => view.onLoadCartItemsError(onError));
  }
}
