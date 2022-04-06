import 'dart:convert';
import 'package:csi5112_project/components/suspend_page.dart';
import 'package:csi5112_project/data/http_data.dart';
import 'package:csi5112_project/data/user_data.dart';
import 'package:csi5112_project/presenter/question_presenter.dart';
import 'package:csi5112_project/view/product_question_page/answer_page.dart';
import 'package:flutter/material.dart';
import '../../data/product_data.dart';
import '../../data/question.dart';
import 'package:intl/intl.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({Key? key, required this.product, required this.user})
      : super(key: key);

  final Product product;
  final User user;

  @override
  QuestionPageState createState() => QuestionPageState();
}

class QuestionPageState extends State<QuestionPage>
    implements QuestionsListViewContract {
  TextEditingController questionController = TextEditingController();

  late QuestionsListPresenter _presenter;
  List<Question> questionsReceived = [];
  bool isSearching = false;
  bool isLoadError = false;
  String loadError = "";

  QuestionPageState() {
    _presenter = QuestionsListPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    isSearching = true;
    _presenter.loadQuestions(HttpRequest(
        'Get', 'Questions?product_id=${widget.product.product_id}', {}));
  }

  retry() {
    isSearching = true;
    _presenter.loadQuestions(HttpRequest(
        'Get', 'Questions?product_id=${widget.product.product_id}', {}));
  }

  @override
  Widget build(BuildContext context) {
    Question newQuestion = Question();
    var _dialogWidth = MediaQuery.of(context).size.width * 0.8;
    var _dialogHeight = MediaQuery.of(context).size.height * 0.5;

    return Card(
        elevation: 3.0,
        child: Column(children: [
          const Padding(padding: EdgeInsets.only(top: 20)),
          const Text("Chat about this product",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.deepOrange,
                fontWeight: FontWeight.bold,
                fontSize: 28,
              )),
          const Padding(padding: EdgeInsets.only(top: 5)),
          const Text("Frequent Questions from others",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.blueGrey,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              )),
          const Padding(padding: EdgeInsets.only(top: 20)),
          SuspendCard(
              child: Column(
                children: buildQuestionList(_dialogWidth, _dialogHeight),
              ),
              isLoadError: isLoadError,
              isSearching: isSearching,
              loadError: loadError,
              data: questionsReceived,
              retry: () => retry()),
          Padding(
            padding: const EdgeInsets.only(top: 25, left: 30, right: 30),
            child: TextField(
              controller: questionController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Add Question',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: SizedBox(
                width: 500,
                height: 45,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 30, right: 30, bottom: 10),
                  child: Material(
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.circular(5),
                    elevation: 6,
                    child: MaterialButton(
                      child: const Text(
                        'Create Your Question',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      onPressed: () {
                        addQuestion(newQuestion);
                      },
                    ),
                  ),
                )),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 130),
          )
        ]));
  }

  void addQuestion(Question newQuestion) {
    newQuestion.customer_id = widget.user.isMerchant
        ? widget.user.merchant_id
        : widget.user.customer_id;
    newQuestion.question = questionController.text;
    newQuestion.product_id = widget.product.product_id;
    _presenter.loadQuestions(
        HttpRequest('Post', 'Questions/create', jsonEncode(newQuestion)));
  }

  List<Card> buildQuestionList(var _dialogWidth, var _dialogHeight) {
    return questionsReceived
        .map(
          (question) => Card(
            key: Key(question.question_id),
            child: InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return UnconstrainedBox(
                        constrainedAxis: Axis.vertical,
                        child: SizedBox(
                          width: _dialogWidth,
                          child: Dialog(
                            insetPadding: EdgeInsets.zero,
                            child: SizedBox(
                              height: _dialogHeight,
                              child: Center(
                                child: AnswerPage(
                                    user: widget.user, question: question),
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              },
              child: ListTile(
                  leading: const Icon(Icons.question_answer),
                  subtitle: Text(
                      "Customer " +
                          "..." +
                          question.customer_id.substring(
                              question.customer_id.length - 4,
                              question.customer_id.length) +
                          " posted on " +
                          DateFormat('yyyy-MM-dd').format(question.date),
                      style:
                          const TextStyle(fontSize: 13, color: Colors.black)),
                  title: Text(question.question,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold))),
            ),
          ),
        )
        .toList();
  }

  @override
  void onLoadQuestionsComplete(List<Question> questions) {
    setState(() {
      questionsReceived = questions;
      isSearching = false;
      isLoadError = false;
    });
  }

  @override
  void onLoadQuestionsError(e) {
    setState(() {
      isSearching = false;
      isLoadError = true;
      loadError = e;
    });
  }
}
