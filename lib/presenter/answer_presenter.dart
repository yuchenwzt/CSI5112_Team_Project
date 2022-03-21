import 'package:csi5112_project/injection/dependency_injection.dart';
import '../data/anser_data.dart';
import '../data/http_data.dart';

abstract class AnswersListViewContract {
  void onLoadAnswersComplete(List<Answer> items);
  void onLoadAnswersError(onError);
}

class AnswersListPresenter {
  AnswersListViewContract view;
  late AnswerRepository repository;

  AnswersListPresenter(this.view) {
    repository = Injector().answerRepository;
  }

  void loadAnswer(HttpRequest request) {
    repository
      .fetch(request)
      .then((answer) => view.onLoadAnswersComplete(answer))
      .catchError((onError) => view.onLoadAnswersError(onError));
  }
}