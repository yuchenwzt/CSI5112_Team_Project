import 'package:csi5112_project/injection/dependency_injection_order.dart';
import '../data/order_data.dart';

abstract class OrdersListViewContract {
  void onLoadOrdersComplete(List<Order> items);

  void onLoadOrdersError();
}

class OrdersListPresenter {
  OrdersListViewContract view;
  late OrderRepository repository;

  OrdersListPresenter(this.view) {
    repository = Injector().orderRepository;
  }

  void loadOrder() {
    assert(view != null);

    repository
      .fetch()
      .then((order) => view.onLoadOrdersComplete(order))
      .catchError((onError) => view.onLoadOrdersError());
  }
}