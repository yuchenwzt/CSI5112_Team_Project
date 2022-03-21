import '../data/filter_option_data.dart';
import '../injection/dependency_injection.dart';
import '../data/http_data.dart';

abstract class FilterOptionListViewContract {
  void onLoadFilterOptionComplete(FilterOption filterOption);

  void onLoadFilterOptionError(onError);
}

class FilterOptionListPresenter {
  FilterOptionListViewContract view;
  late FilterOptionRepository repository;

  FilterOptionListPresenter(this.view) {
    repository = Injector().filterOptionRepository;
  }

  void loadFilterOption(HttpRequest request) {
    repository
      .fetch(request)
      .then((filterOption) => view.onLoadFilterOptionComplete(filterOption))
      .catchError((onError) => view.onLoadFilterOptionError(onError));
  }
}