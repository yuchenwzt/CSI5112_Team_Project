import 'package:csi5112_project/data/customer_data.dart';
import 'package:csi5112_project/injection/dependency_injection.dart';
import '../data/http_data.dart';

abstract class CustomerListViewContract {
  void onLoadCustomerComplete(List<Customer> customers);

  void onLoadCustomerError(onError);
}

class CustomerListPresenter {
  CustomerListViewContract view;
  late CustomerRepository repository;

  CustomerListPresenter(this.view) {
    repository = Injector().customerRepository;
  }

  void loadCustomer(HttpRequest request) {
    repository
      .fetch(request)
      .then((users) => view.onLoadCustomerComplete(users))
      .catchError((onError) => view.onLoadCustomerError(onError));
  }
}
