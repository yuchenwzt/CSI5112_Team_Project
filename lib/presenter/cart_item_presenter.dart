import 'package:csi5112_project/data/cart_item_data.dart';
import 'package:csi5112_project/injection/dependency_injection.dart';
import '../data/http_data.dart';

abstract class CartItemsListViewContractCart {
  void onLoadCartItemsComplete(List<CartItem> items);

  void onLoadCartItemsError();
}

class CartItemsListPresenterCart {
  CartItemsListViewContractCart view;
  late CartItemRepository repository;

  CartItemsListPresenterCart(this.view) {
    repository = Injector().cartItemRepository;
  }

  void loadItems(HttpRequest request) {
    repository
      .fetch(request)
      .then((items) => view.onLoadCartItemsComplete(items))
      .catchError((onError) => view.onLoadCartItemsError());
  }
}
