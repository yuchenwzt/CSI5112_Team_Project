import 'package:csi5112_project/injection/dependency_injection.dart';
import '../data/user_data.dart';
import '../data/http_data.dart';

abstract class UserRegisterListViewContract {
  void onLoadUserRegisterCheck(bool isValid);
  void onLoadUserRegisterComplete(List<User> user);
}

class UserRegisterListPresenter {
  UserRegisterListViewContract view;
  late UserRepository repository;

  UserRegisterListPresenter(this.view) {
    repository = Injector().userRepository;
  }

  void loadUser(HttpRequest request) {
    repository
      .fetch(request)
      .then((user) => view.onLoadUserRegisterComplete(user));
  }

  void checkUser(HttpRequest request) {
    repository
      .check(request)
      .then((valid) => view.onLoadUserRegisterCheck(valid));
  }
}