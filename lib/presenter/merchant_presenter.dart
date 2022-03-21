import 'package:csi5112_project/data/merchant_data.dart';
import '../data/http_data.dart';
import '../injection/dependency_injection.dart';

abstract class MerchantListViewContract {
  void onLoadMerchantComplete(List<Merchant> merchants);
  void onLoadMerchantError(onError);
}

class MerchantListPresenter {
  late MerchantListViewContract view;
  late MerchantRepository repository;

  MerchantListPresenter(this.view) {
    repository = Injector().merchantRepository;
  }

  void loadMerchant(HttpRequest request) {
    repository
      .fetch(request)
      .then((merchants) => view.onLoadMerchantComplete(merchants))
      .catchError((onError) => view.onLoadMerchantError(onError));
  }
}
