import 'package:csi5112_project/injection/dependency_injection.dart';
import '../data/order_data.dart';
import '../data/http_data.dart';

abstract class OrdersListViewContract {
  void onLoadOrdersComplete(List<OrderDetail> items);

  void onLoadOrdersError(onError);
}

class OrdersListPresenter {
  OrdersListViewContract view;
  late OrderRepository repository;

  OrdersListPresenter(this.view) {
    repository = Injector().orderRepository;
  }

  void loadOrder(HttpRequest request) {
    repository
      .fetch(request)
      .then((order) => view.onLoadOrdersComplete(order))
      .catchError((onError) => view.onLoadOrdersError(onError));
  }
}