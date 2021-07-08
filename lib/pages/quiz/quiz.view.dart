import 'package:boro_boro/Widgets/bottomBar.dart';
import 'package:boro_boro/Widgets/quizQuestion.dart';
import 'package:boro_boro/pages/quiz/quiz.controller.dart';
import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  QuizPageController pageController = QuizPageController();

  @override
  void initState() {
    super.initState();

    /// Save state in model so that it can be accessed from controller
    pageController.pageState = setState;

    /// Take note of the following method, it will run once the first widget build is complete
    /// It will not run on further set states
    WidgetsBinding.instance.addPostFrameCallback((_) => setContext(context));

    /// Call Initialize function to fetch the questions
    pageController.initialize();
  }

  void setContext(context) {
    /// Save context in model so that it can be accessed from controller
    if (pageController.context == null) {
      pageController.context = context;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getQuestions(),
    );
  }


  Widget getQuestions(){
     if (pageController.questions == null) {
      return Container(
      alignment: Alignment.center,
      height:MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child:Container(
        height:100,width: 100,
        child: CircularProgressIndicator()));
    }
    return SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          width: MediaQuery.of(context).size.width,
          child:  Scrollbar(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...formatQuestion(),
                  pageController.validationText != '' ?  Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(bottom: 30),
                        child: Text(pageController.validationText)):Container(),
                  getBottomBar()
                ],
              ),
            ),
          ),
        ),
      );
  }

  Widget getBottomBar() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(bottom: 30),
      child: BottomBar(pageController.resetButtonCallback,
          pageController.validateButtonCallback),
    );
  }

  List<Widget> formatQuestion() {
    List<Widget> widgets = [];
    if (pageController.questions == null) {
      widgets.add(CircularProgressIndicator());
    } else {
      pageController.questions.results.asMap().forEach((idx, element) {
        widgets.add(

            /// ctrl+hover above QuizQuestion to see details of parameters to be passed
            QuizQuestion(
                element,
                idx,
                pageController.selectedAnswers,
                pageController.correctAnswers,
                pageController.radioSelectedCallback,
                pageController.isValidated));
      });
    }
    return widgets;
  }
}
