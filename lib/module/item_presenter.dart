import '../data/item_data.dart';
import '../Injection/dependency_injection_item.dart';

abstract class ItemsListViewContract {
  void onLoadItemsComplete(List<Item> items);

  void onLoadItemsError();
}

class ItemsListPresenter {
  ItemsListViewContract view;
  late ItemRepository repository;

  ItemsListPresenter(this.view) {
    repository = Injector().itemRepository;
  }

  void loadItems() {
    assert(view != null);

    repository
      .fetch()
      .then((items) => view.onLoadItemsComplete(items))
      .catchError((onError) => view.onLoadItemsError());
  }
}