import 'package:csi5112_project/injection/dependency_injection.dart';
import '../data/http_data.dart';
import '../data/shipping_address_data.dart';

abstract class ShippingAddressViewContract {
  void onLoadShippingAddressComplete(List<ShippingAddress> shippingAddress);

  void onLoadShippingAddressError(onError);
}

class ShippingAddressPresenter {
  ShippingAddressViewContract view;
  late ShippingAddressRepository repository;

  ShippingAddressPresenter(this.view) {
    repository = Injector().shippingAddressRepository;
  }

  void loadAddress(HttpRequest request) {
    repository
      .fetch(request)
      .then((user) => view.onLoadShippingAddressComplete(user))
      .catchError((onError) => view.onLoadShippingAddressError(onError));
  }
}
