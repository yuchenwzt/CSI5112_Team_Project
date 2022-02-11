import 'package:csi5112_project/injection/dependency_injection_item.dart';

import '../data/user_data.dart';

abstract class UserViewContract {
  void onLoadUsersComplete(User user);

  void onLoadUsersError();
}

class UserPresenter {
  UserViewContract view;
  late UserRepository repository;

  UserPresenter(this.view) {
    repository = Injector().userRepository;
  }

  void loadUsers() {
    assert(view != null);

    repository
      .fetch()
      .then((user) => view.onLoadUsersComplete(user))
      .catchError((onError) => view.onLoadUsersError());
  }
}
