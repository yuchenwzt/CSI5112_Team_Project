import '../data/question.dart';
import 'package:csi5112_project/injection/dependency_injection.dart';
import '../data/http_data.dart';

abstract class QuestionsListViewContract {
  void onLoadQuestionsComplete(List<Question> questions);

  void onLoadQuestionsError(onError);
}

class QuestionsListPresenter {
  QuestionsListViewContract view;
  late QuestionRepository repository;

  QuestionsListPresenter(this.view) {
    repository = Injector().questionRepository;
  }

  void loadQuestions(HttpRequest request) {
    repository
      .fetch(request)
      .then((questions) => view.onLoadQuestionsComplete(questions))
      .catchError((onError) => view.onLoadQuestionsError(onError));
  }
}