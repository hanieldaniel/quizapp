import 'dart:math';

import 'package:flutter/material.dart';

import 'package:html_character_entities/html_character_entities.dart';
import 'package:http/http.dart' as http;

import 'package:boro_boro/Models/QuizModel.dart';

// import 'package:boro_boro/Widgets/customConatiner.dart' as custom;
//
// import 'package:boro_boro/page2.dart';

void main() {
  runApp(
    MaterialApp(debugShowCheckedModeBanner: false, home: MyWidget()),
  );
}

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}


class _MyWidgetState extends State<MyWidget> {

  List<int> correctAnswers = List<int>.filled(10, 0, growable: true);
  List<int> selectedAnswers = List<int>.filled(10, null, growable: true);
  QuizModel questions;
  String validationText = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getQuizQuestions();
    insertCorrectAnswer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: questions == null ? MainAxisAlignment.center : MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...formatQuestion(),
                if(validationText != '')  Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(bottom: 30),
                  child: Text(validationText)
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(bottom: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          // background color
                          primary: Colors.orange,
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          textStyle: TextStyle(fontSize: 20),
                        ),
                      onPressed: ()  {
                        selectedAnswers = List<int>.filled(10, null, growable: true);
                        validationText = "";
                        setState(() {});
                      },
                      child: Text('Reset'),),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          // background color
                          primary: Colors.blue,
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          textStyle: TextStyle(fontSize: 20),
                        ),
                      onPressed: ()  {
                        int correctCount = 0;
                        correctAnswers.asMap().forEach((key, value) {
                          if(selectedAnswers[key] == value){
                            correctCount++;
                          }
                        });
                        validationText = '${correctCount} out of 10 answers is correct';
                        setState(() {});
                      },
                      child: Text('Validate Answers'),),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget formattedContainers(color, {double height = 100.0}) {
    return Container(
      height: height,
      width: height,
      color: color,
    );
  }

  List<Widget> answerGroup(List<String> wrongAnswers, String correctAnswer, questionIndex) {
    List<Widget> widgets = [];
    List<String> answers = [...wrongAnswers];
    answers.insert(correctAnswers.elementAt(questionIndex), correctAnswer);
    if (answers != null){
      answers.asMap().forEach((index, answer) {
        widgets.add(
          RadioListTile(
            value: index,
            groupValue: selectedAnswers.elementAt(questionIndex),
            title: Text(HtmlCharacterEntities.decode(answer)),
            onChanged: (idx) {
              print("Current answer for question ${questionIndex} is ${idx}");
              setState(() {
                selectedAnswers[questionIndex] = idx;
              });
            },
            selected: selectedAnswers[questionIndex] == index,
            activeColor: Colors.blue,
          ),
        );
      });
    }
    return widgets;
  }

  List<Widget> formatQuestion(){
    List<Widget> widgets = [];
    if (questions == null){
      widgets.add(CircularProgressIndicator());
    } else {
      questions.results.asMap().forEach((idx, element) {
        widgets.add(Container(
          margin: EdgeInsets.only(bottom: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 8),
                child: Text(HtmlCharacterEntities.decode(element.question), style: TextStyle(
                  fontSize: 20,
                  height: 1.3
                ),
                ),
              ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: answerGroup(element.incorrectAnswers, element.correctAnswer, idx),
                ),
            ],
          ),
        ));
      });
    }
    return widgets;
  }

  void getQuizQuestions() async {
    var url = Uri.parse('https://opentdb.com/api.php?amount=10&category=17&difficulty=easy&type=multiple');
    http.Response response  = await http.get(url);
    setState(() {
      questions = quizModelFromJson(response.body);
    });
  }
  
  void insertCorrectAnswer(){
    correctAnswers.asMap().forEach((key, value) {
      Random random = new Random();
      int randomNumber = random.nextInt(4);
      correctAnswers[key] = randomNumber;
    });
  }
}




