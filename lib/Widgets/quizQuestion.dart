import 'package:flutter/material.dart';
import 'package:boro_boro/Models/QuizModel.dart' as quizmodel;
import 'package:html_character_entities/html_character_entities.dart';

class QuizQuestion extends StatelessWidget {
  /// The element from Result Array, this will contain all details 
  /// about the current question
  final quizmodel.Result questionElement;
  /// The index of the Result
  final int questionIndex;
  /// This is the pageController.selectedAnswers. By default
  /// List items are passed by reference not by value
  final List<int> selectedAnswers;
  /// This is the pageController.selectedAnswers. By default
  /// List items are passed by reference not by value
  final List<int> correctAnswers;
  /// Use callback to use the setState of parent widget
  final void Function() refreshStateCallback;
  /// to show correct answer in color
  final bool isValidated;

  QuizQuestion(this.questionElement,this.questionIndex,this.selectedAnswers,
  this.correctAnswers,this.refreshStateCallback,this.isValidated);

  @override
  Widget build(BuildContext context) {
    return Container(
          margin: EdgeInsets.only(bottom: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 8),
                child: Text(HtmlCharacterEntities.decode(questionElement.question), style: TextStyle(
                  fontSize: 20,
                  height: 1.3
                ),
                ),
              ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: answerGroup(),
                ),
            ],
          ),
        );
  }


  List<Widget> answerGroup() {
    List<Widget> widgets = [];
    List<String> answers = [...questionElement.incorrectAnswers];
    answers.insert(correctAnswers.elementAt(questionIndex), questionElement.correctAnswer);
    if (answers != null){
      answers.asMap().forEach((index, answer) {
        widgets.add(
          Container(
            color :(isValidated? 
            (selectedAnswers[questionIndex] == index ?
            (selectedAnswers[questionIndex] == correctAnswers[questionIndex]? Colors.green : Colors.red) :
            (index == correctAnswers[questionIndex]? Colors.green : Colors.white)
            ) 
             : Colors.white),
            child: RadioListTile(
              value: index,
              groupValue: selectedAnswers.elementAt(questionIndex),
              title: Text(HtmlCharacterEntities.decode(answer)),
              onChanged: (idx) {
                //print("Current answer for question ${questionIndex} is ${idx}");
                selectedAnswers[questionIndex] = idx;
                refreshStateCallback();
              },
              selected: selectedAnswers[questionIndex] == index,
              activeColor: Colors.blue,
            ),
          ),
        );
      });
    }
    return widgets;
  }


  
}