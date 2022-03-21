import 'package:csi5112_project/injection/dependency_injection.dart';
import '../data/user_data.dart';
import '../data/http_data.dart';

abstract class UserListViewContract {
  void onLoadUserComplete(List<User> user);
  void onLoadUserError(onError);
}

class UserListPresenter {
  UserListViewContract view;
  late UserRepository repository;

  UserListPresenter(this.view) {
    repository = Injector().userRepository;
  }

  void loadUser(HttpRequest request) {
    repository
      .fetch(request)
      .then((user) => view.onLoadUserComplete(user))
      .catchError((onError) => view.onLoadUserError(onError));
  }
}