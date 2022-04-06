import 'dart:convert';
import 'package:csi5112_project/components/suspend_page.dart';
import 'package:csi5112_project/data/http_data.dart';
import 'package:csi5112_project/data/user_data.dart';
import 'package:csi5112_project/data/anser_data.dart';
import 'package:csi5112_project/presenter/answer_presenter.dart';
import 'package:flutter/material.dart';
import '../../data/question.dart';
import 'package:intl/intl.dart';

class AnswerPage extends StatefulWidget {
  const AnswerPage({Key? key, required this.question, required this.user})
      : super(key: key);

  final Question question;
  final User user;

  @override
  AnswerPageState createState() => AnswerPageState();
}

class AnswerPageState extends State<AnswerPage>
    implements AnswersListViewContract {
  TextEditingController answerController = TextEditingController();

  late AnswersListPresenter _presenter;
  List<Answer> answersReceived = [];
  bool isSearching = false;
  bool isLoadError = false;
  String loadError = "";

  AnswerPageState() {
    _presenter = AnswersListPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    isSearching = true;
    _presenter.loadAnswer(HttpRequest('Get',
        'Answers/by_question?question_id=${widget.question.question_id}', {}));
  }

  void retry() {
    isSearching = true;
    _presenter.loadAnswer(HttpRequest('Get',
        'Answers/by_question?question_id=${widget.question.question_id}', {}));
  }

  @override
  Widget build(BuildContext context) {
    Answer newAnswer = Answer();
    return Column(children: [
      Text("Answers about: " + widget.question.question,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.blue,
            fontSize: 30,
          )),
      const Padding(padding: EdgeInsets.only(top: 10)),
      const Text("Answers from others",
          textAlign: TextAlign.start,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          )),
      const Padding(padding: EdgeInsets.only(top: 20)),
      SuspendCard(
        child: Column(
          children: buildQuestionList(),
        ),
        isLoadError: isLoadError,
        isSearching: isSearching,
        loadError: loadError,
        data: answersReceived,
        retry: () => retry(),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 30, left: 30, right: 40),
        child: TextField(
          controller: answerController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Add Answer',
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 30),
        child: SizedBox(
            width: 500,
            height: 45,
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 10),
              child: Material(
                //color: Colors.blue,
                borderRadius: BorderRadius.circular(5),
                elevation: 6,
                child: MaterialButton(
                  color: Colors.deepOrange,
                  elevation: 6,
                  child: const Text(
                    'Create Your Answer',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  onPressed: () {
                    addAnswer(newAnswer);
                  },
                ),
              ),
            )),
      ),
    ]);
  }

  void addAnswer(Answer newAnswer) {
    newAnswer.answer = answerController.text;
    newAnswer.role = widget.user.isMerchant ? 'Merchant' : 'Customer';
    newAnswer.role_id = widget.user.isMerchant
        ? widget.user.merchant_id
        : widget.user.customer_id;
    newAnswer.question_id = widget.question.question_id;
    _presenter.loadAnswer(
        HttpRequest('Post', 'Answers/create', jsonEncode(newAnswer)));
  }

  List<Card> buildQuestionList() {
    return answersReceived
        .map(
          (answer) => Card(
            key: Key(answer.answer_id),
            child: ListTile(
                leading: const Icon(Icons.person),
                subtitle: Text(
                    "..." +
                        answer.role_id.substring(
                            answer.role_id.length - 4, answer.role_id.length) +
                        "(" +
                        answer.role +
                        ") answered on " +
                        DateFormat('yyyy-MM-dd').format(answer.date),
                    style: const TextStyle(fontSize: 14, color: Colors.black)),
                title: Text(answer.answer,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold))),
          ),
        )
        .toList();
  }

  @override
  void onLoadAnswersComplete(List<Answer> answers) {
    setState(() {
      answersReceived = answers;
      isSearching = false;
      isLoadError = false;
    });
  }

  @override
  void onLoadAnswersError(e) {}
}
