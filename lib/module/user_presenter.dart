import 'package:csi5112_project/injection/dependency_injection_item.dart';

import '../data/user_data.dart';

abstract class UserListViewContract {
  void onLoadUsersComplete(List<User> items);

  void onLoadUsersError();
}

class UserListPresenter {
  UserListViewContract view;
  late UserRepository repository;

  UserListPresenter(this.view) {
    repository = Injector().userRepository;
  }

  void loadUsers() {
    assert(view != null);

    repository
        .fetch()
        .then((users) => view.onLoadUsersComplete(users))
        .catchError((onError) => view.onLoadUsersError());
  }
}
